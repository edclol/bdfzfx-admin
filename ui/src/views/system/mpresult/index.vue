<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="遥信ID" prop="remoteSignalId">
        <el-input
          v-model="queryParams.remoteSignalId"
          placeholder="请输入遥信ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:mpresult:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:mpresult:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:mpresult:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:mpresult:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="mpresultList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <el-table-column label="遥信ID" align="center" prop="remoteSignalId" />
      <el-table-column label="标准信号" align="center" prop="dbStatement" />
      <el-table-column label="相似度" align="center" prop="score" >
        <template slot-scope="scope">
          <span v-if="scope.row.score <0.6" style="color: red;">{{ (scope.row.score * 100).toFixed(2) }}%</span>
          <span v-else>{{ (scope.row.score * 100).toFixed(2) }}%</span>
        </template>
      </el-table-column>
      <el-table-column label="匹配耗时" align="center" prop="elapsedTime" />
      <el-table-column label="备注信息" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:mpresult:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:mpresult:remove']"
          >删除</el-button>
          <el-button
            size="mini"
            type="text"
            @click="handleView(scope.row)"
          >查看</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改映射结果对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="遥信ID" prop="remoteSignalId">
          <el-input v-model="form.remoteSignalId" placeholder="请输入遥信ID" />
        </el-form-item>
        <el-form-item label="标准信号" prop="dbStatement">
          <el-input v-model="form.dbStatement" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="相似度" prop="score">
          <el-input v-model="form.score" placeholder="请输入相似度" />
        </el-form-item>
        <el-form-item label="匹配耗时" prop="elapsedTime">
          <el-input v-model="form.elapsedTime" placeholder="请输入匹配耗时" />
        </el-form-item>
        <el-form-item label="备注信息" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 简化版流程动画对话框（仅四步：标准信号 → 遥信ID → 相似度 → 匹配耗时） -->
    <el-dialog :title="viewTitle" :visible.sync="viewOpen" width="760px" append-to-body @close="stopAnimation">
      <div v-if="selectedRow" v-loading="viewLoading" element-loading-text="加载中..." style="display:flex; justify-content:center; align-items:center; padding: 16px 8px;">
        <div :style="stepStyle(0)" class="flow-step" v-loading="isStepLoading(0)" element-loading-text="加载中...">
          <template v-if="isStepLoaded(0)">标准信号<br/><span>{{ typedValues[0] }}</span></template>
        </div>
        <div class="flow-arrow" :style="arrowStyle(0)">→</div>
        <div :style="stepStyle(1)" class="flow-step" v-loading="isStepLoading(1)" element-loading-text="加载中...">
          <template v-if="isStepLoaded(1)">遥信ID<br/><span>{{ typedValues[1] }}</span></template>
        </div>
        <div class="flow-arrow" :style="arrowStyle(1)">→</div>
        <div :style="stepStyle(2)" class="flow-step" v-loading="isStepLoading(2)" element-loading-text="加载中...">
          <template v-if="isStepLoaded(2)">相似度<br/><span>{{ typedValues[2] }}</span></template>
        </div>
        <div class="flow-arrow" :style="arrowStyle(2)">→</div>
        <div :style="stepStyle(3)" class="flow-step" v-loading="isStepLoading(3)" element-loading-text="加载中...">
          <template v-if="isStepLoaded(3)">匹配耗时<br/><span>{{ typedValues[3] }}</span></template>
        </div>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="viewOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMpresult, getMpresult, delMpresult, addMpresult, updateMpresult } from "@/api/system/mpresult"

export default {
  name: "Mpresult",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 映射结果表格数据
      mpresultList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查看过程对话框
      viewOpen: false,
      viewTitle: "查看",
      selectedRow: null,
      // 简化动画：仅四个关键步骤
      currentStepIndex: -1,
      animationTimer: null,
      animationRunning: true,
      viewLoading: false,
      visibleSteps: 0,
      stepLoaded: [false, false, false, false],
      typedValues: ['', '', '', ''],
      typingTimers: [],
      stepIntervalMs: 2000,
      stepLoadingDelay: 400,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        remoteSignalId: null,
        dbStatement: null,
        score: null,
        elapsedTime: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        remoteSignalId: [
          { required: true, message: "遥信ID不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询映射结果列表 */
    getList() {
      this.loading = true
      listMpresult(this.queryParams).then(response => {
        this.mpresultList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        remoteSignalId: null,
        dbStatement: null,
        score: null,
        elapsedTime: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加映射结果"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getMpresult(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改映射结果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateMpresult(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMpresult(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除映射结果编号为"' + ids + '"的数据项？').then(function() {
        return delMpresult(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/mpresult/export', {
        ...this.queryParams
      }, `mpresult_${new Date().getTime()}.xlsx`)
    },
    /** 查看按钮操作 */
    handleView(row) {
      this.selectedRow = row
      this.viewOpen = true
      this.viewTitle = `查看`
      this.viewLoading = true
      this.currentStepIndex = -1
      this.visibleSteps = 0
      this.stepLoaded = [false, false, false, false]
      this.typedValues = ['', '', '', '']
      this.clearTypingTimers()
      // 模拟加载延迟，结束后依次展示
      setTimeout(() => {
        this.viewLoading = false
        this.startAnimation()
      }, 400)
    },
    startAnimation() {
      this.stopAnimation()
      let idx = -1
      const total = 4
      this.animationTimer = setInterval(() => {
        idx += 1
        if (idx >= total) {
          this.stopAnimation()
          return
        }
        this.currentStepIndex = idx
        this.visibleSteps = Math.max(this.visibleSteps, idx + 1)
        // 先进入该步的 loading 态，稍后再展示内容
        this.$set(this.stepLoaded, idx, false)
        setTimeout(() => {
          this.$set(this.stepLoaded, idx, true)
          this.startTyping(idx)
        }, this.stepLoadingDelay)
      }, this.stepIntervalMs)
    },
    stopAnimation() {
      if (this.animationTimer) {
        clearInterval(this.animationTimer)
        this.animationTimer = null
      }
      this.clearTypingTimers()
    },
    startTyping(stepIndex) {
      const texts = [
        (this.selectedRow && this.selectedRow.dbStatement) || '',
        (this.selectedRow && this.selectedRow.remoteSignalId) || '',
        this.formatPercent((this.selectedRow && this.selectedRow.score) || 0),
        (this.selectedRow && this.selectedRow.elapsedTime) || ''
      ]
      const fullText = String(texts[stepIndex])
      this.$set(this.typedValues, stepIndex, '')
      let i = 0
      const timer = setInterval(() => {
        if (i >= fullText.length) {
          clearInterval(timer)
          return
        }
        this.$set(this.typedValues, stepIndex, this.typedValues[stepIndex] + fullText.charAt(i))
        i += 1
      }, 20)
      this.typingTimers.push(timer)
    },
    clearTypingTimers() {
      if (!this.typingTimers) return
      this.typingTimers.forEach(t => clearInterval(t))
      this.typingTimers = []
    },
    isStepLoaded(index) {
      return !!this.stepLoaded[index]
    },
    isStepLoading(index) {
      // 仅当前步骤在未加载完成前显示 loading，其它未来步骤只占位
      return this.currentStepIndex === index && !this.stepLoaded[index]
    },
    arrowStyle(index) {
      const enabled = this.visibleSteps > index + 1
      return {
        margin: '0 8px',
        color: enabled ? '#909399' : '#dcdfe6',
        fontSize: '16px',
        transition: 'color .3s'
      }
    },
    formatPercent(v) {
      if (v === null || v === undefined || isNaN(v)) return '-'
      return `${(Number(v) * 100).toFixed(2)}%`
    },
    stepStyle(stepIndex) {
      const isActive = this.currentStepIndex === stepIndex
      const loaded = this.isStepLoaded(stepIndex)
      return {
        padding: '12px 16px',
        minWidth: '150px',
        textAlign: 'center',
        borderRadius: '8px',
        border: loaded ? (isActive ? '2px solid #409EFF' : '1px solid #e5e7eb') : '1px dashed transparent',
        boxShadow: loaded && isActive ? '0 0 8px rgba(64,158,255,0.5)' : 'none',
        transition: 'all .3s',
        background: loaded ? (isActive ? 'rgba(64,158,255,0.06)' : '#fff') : 'transparent'
      }
    }
  }
}
</script>
