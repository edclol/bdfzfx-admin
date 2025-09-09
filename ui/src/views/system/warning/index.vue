<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="发生时间">
        <el-date-picker
          v-model="daterangeOccurTime"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="预警等级" prop="warningLevel">
        <el-input
          v-model="queryParams.warningLevel"
          placeholder="请输入预警等级"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:warning:add']"
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
          v-hasPermi="['system:warning:edit']"
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
          v-hasPermi="['system:warning:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:warning:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row> -->

    <el-table v-loading="loading" :data="warningList" @selection-change="handleSelectionChange">
      <!-- <el-table-column type="selection" width="55" align="center" /> -->
      <el-table-column label="序号" align="center" prop="id"  width="55"/>
      <el-table-column label="发生时间" align="center" prop="occurTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.occurTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="预警等级" align="center" prop="warningLevel" />
      <el-table-column label="预警内容" align="center" prop="warningContent" />
      <!-- <el-table-column label="建议处理" align="center" prop="suggestion" />
      <el-table-column label="状态" align="center" prop="status" /> -->
      <!-- <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:warning:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:warning:remove']"
          >删除</el-button>
        </template>
      </el-table-column> -->
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改模型预警对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="发生时间" prop="occurTime">
          <el-date-picker clearable
            v-model="form.occurTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择发生时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="预警等级" prop="warningLevel">
          <el-input v-model="form.warningLevel" placeholder="请输入预警等级" />
        </el-form-item>
        <el-form-item label="预警内容">
          <editor v-model="form.warningContent" :min-height="192"/>
        </el-form-item>
        <el-form-item label="建议处理" prop="suggestion">
          <el-input v-model="form.suggestion" type="textarea" placeholder="请输入内容" />
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
  </div>
</template>

<script>
import { listWarning, getWarning, delWarning, addWarning, updateWarning } from "@/api/system/warning"

export default {
  name: "Warning",
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
      // 模型预警表格数据
      warningList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 备注信息时间范围
      daterangeOccurTime: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        occurTime: null,
        warningLevel: null,
        warningContent: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        occurTime: [
          { required: true, message: "发生时间不能为空", trigger: "blur" }
        ],
        warningLevel: [
          { required: true, message: "预警等级不能为空", trigger: "blur" }
        ],
        warningContent: [
          { required: true, message: "预警内容不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询模型预警列表 */
    getList() {
      this.loading = true
      this.queryParams.params = {}
      if (null != this.daterangeOccurTime && '' != this.daterangeOccurTime) {
        this.queryParams.params["beginOccurTime"] = this.daterangeOccurTime[0]
        this.queryParams.params["endOccurTime"] = this.daterangeOccurTime[1]
      }
      listWarning(this.queryParams).then(response => {
        this.warningList = response.rows
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
        occurTime: null,
        warningLevel: null,
        warningContent: null,
        suggestion: null,
        status: null,
        remark: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null
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
      this.daterangeOccurTime = []
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
      this.title = "添加模型预警"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getWarning(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改模型预警"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateWarning(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addWarning(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除模型预警编号为"' + ids + '"的数据项？').then(function() {
        return delWarning(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/warning/export', {
        ...this.queryParams
      }, `warning_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
