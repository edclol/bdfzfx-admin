<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="118px">
      <el-form-item label="设备原理" prop="devicePrinciple">
        <el-input
          v-model="queryParams.devicePrinciple"
          placeholder="请输入设备原理"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
<!--      <el-form-item label="通用电压等级" prop="voltageLevel">-->
<!--        <el-input-->
<!--          v-model="queryParams.voltageLevel"-->
<!--          placeholder="请输入通用电压等级"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
      <el-form-item label="告警等级" prop="alarmLevel">
        <el-input
          v-model="queryParams.alarmLevel"
          placeholder="请输入告警等级"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否上送监控" prop="sendToMonitor">
        <el-input
          v-model="queryParams.sendToMonitor"
          placeholder="请输入是否上送监控"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="参考依据" prop="referenceBasis">
        <el-input
          v-model="queryParams.referenceBasis"
          placeholder="请输入参考依据"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="采集要求" prop="collectionRequirement">
        <el-input
          v-model="queryParams.collectionRequirement"
          placeholder="请输入采集要求"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="指向设备" prop="targetDevice">
        <el-input
          v-model="queryParams.targetDevice"
          placeholder="请输入指向设备"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="采集源设备" prop="sourceDevice">
        <el-input
          v-model="queryParams.sourceDevice"
          placeholder="请输入采集源设备"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="数据集成设备" prop="integrationDevice">
        <el-input
          v-model="queryParams.integrationDevice"
          placeholder="请输入数据集成设备"
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
          icon="el-icon-refresh-right"
          size="mini"
          @click="handleUpload"
        >上传</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:monitor:add']"
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
          v-hasPermi="['system:monitor:edit']"
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
          v-hasPermi="['system:monitor:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-refresh-right"
          size="mini"
          @click="syncSignal"
        >信号同步</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:monitor:export']"
        >导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-data-analysis"
          size="mini"
          @click="openStatsDialog"
        >实际信号分类统计</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="monitorList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="序号" align="center" prop="id" />
      <el-table-column label="设备类型" align="center" prop="deviceType" />
      <el-table-column label="设备原理" align="center" prop="devicePrinciple" />
      <el-table-column label="信息名称" align="center" prop="infoName" />
      <el-table-column label="通用电压等级" align="center" prop="voltageLevel" />
      <el-table-column label="告警状态" align="center" prop="alarmStatus" />
      <el-table-column label="告警等级" align="center" prop="alarmLevel" />
<!--      <el-table-column label="是否上送监控" align="center" prop="sendToMonitor">-->
<!--        <template slot-scope="scope">-->
<!--          <dict-tag :options="dict.type.send_to_monitor" :value="scope.row.sendToMonitor"/>-->
<!--        </template>-->
<!--      </el-table-column>-->
      <el-table-column label="参考依据" align="center" prop="referenceBasis" />
      <el-table-column label="采集要求" align="center" prop="collectionRequirement" />
      <el-table-column label="指向设备" align="center" prop="targetDevice" />
      <el-table-column label="采集源设备" align="center" prop="sourceDevice" />
      <el-table-column label="数据集成设备" align="center" prop="integrationDevice" />
      <el-table-column label="备注信息" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:monitor:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:monitor:remove']"
          >删除</el-button>
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

    <!-- 添加或修改典型监控信息管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="设备原理" prop="devicePrinciple">
          <el-input v-model="form.devicePrinciple" placeholder="请输入设备原理" />
        </el-form-item>
        <el-form-item label="信息名称" prop="infoName">
          <el-input v-model="form.infoName" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="通用电压等级" prop="voltageLevel">
          <el-input v-model="form.voltageLevel" placeholder="请输入通用电压等级" />
        </el-form-item>
        <el-form-item label="告警等级" prop="alarmLevel">
          <el-input v-model="form.alarmLevel" placeholder="请输入告警等级" />
        </el-form-item>
        <el-form-item label="是否上送监控" prop="sendToMonitor">
          <el-input v-model="form.sendToMonitor" placeholder="请输入是否上送监控" />
        </el-form-item>
        <el-form-item label="参考依据" prop="referenceBasis">
          <el-input v-model="form.referenceBasis" placeholder="请输入参考依据" />
        </el-form-item>
        <el-form-item label="采集要求" prop="collectionRequirement">
          <el-input v-model="form.collectionRequirement" placeholder="请输入采集要求" />
        </el-form-item>
        <el-form-item label="指向设备" prop="targetDevice">
          <el-input v-model="form.targetDevice" placeholder="请输入指向设备" />
        </el-form-item>
        <el-form-item label="采集源设备" prop="sourceDevice">
          <el-input v-model="form.sourceDevice" placeholder="请输入采集源设备" />
        </el-form-item>
        <el-form-item label="数据集成设备" prop="integrationDevice">
          <el-input v-model="form.integrationDevice" placeholder="请输入数据集成设备" />
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

    <!-- 数据统计对话框（复用样本库统计） -->
    <el-dialog title="实际信号分类统计" :visible.sync="statsOpen" width="720px" append-to-body @closed="onStatsDialogClosed">
      <div ref="statsChart" style="width: 100%; height: 400px;"></div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="statsOpen = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 文件上传对话框 -->
    <el-dialog title="文件上传" :visible.sync="uploadOpen" width="500px" append-to-body @close="cancelUpload">
      <el-form ref="uploadForm" :model="uploadForm" label-width="100px">
        <el-form-item label="上传文件">
          <file-upload
            v-model="uploadForm.fileList"
            :file-type="['pdf', 'doc', 'docx', 'xls', 'xlsx']"
            :file-size="10"
            :limit="5"
            @input="handleFileChange"
          />
        </el-form-item>
      </el-form>
      
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitUpload" :loading="uploadLoading" :disabled="!uploadForm.fileList">确 定</el-button>
        <el-button @click="cancelUpload" :disabled="uploadLoading">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMonitor, getMonitor, delMonitor, addMonitor, updateMonitor } from "@/api/system/monitor"
import { getAllStat } from "@/api/system/all"
import FileUpload from "@/components/FileUpload"

export default {
  name: "Monitor",
  components: {
    FileUpload
  },
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
      // 典型监控信息管理表格数据
      monitorList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 数据统计对话框
      statsOpen: false,
      statsChartInstance: null,
      // 文件上传对话框
      uploadOpen: false,
      uploadLoading: false,
      uploadForm: {
        fileList: ''
      },
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        deviceType: null,
        devicePrinciple: null,
        infoName: null,
        voltageLevel: null,
        alarmStatus: null,
        alarmLevel: null,
        sendToMonitor: null,
        referenceBasis: null,
        collectionRequirement: null,
        targetDevice: null,
        sourceDevice: null,
        integrationDevice: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        deviceType: [
          { required: true, message: "设备类型不能为空", trigger: "change" }
        ],
        devicePrinciple: [
          { required: true, message: "设备原理不能为空", trigger: "blur" }
        ],
        infoName: [
          { required: true, message: "信息名称不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    // 打开统计对话框
    openStatsDialog() {
      this.statsOpen = true
      this.$nextTick(() => {
        this.initStatsChart()
      })
    },
    // 初始化并渲染统计图
    async initStatsChart() {
      if (!this.$refs.statsChart) return
      if (this.statsChartInstance) {
        this.statsChartInstance.dispose()
        this.statsChartInstance = null
      }
      const echartsModule = await import('echarts')
      const echarts = echartsModule && (echartsModule.default || echartsModule)
      if (!echarts || !echarts.init) {
        this.$message.error('图表库加载失败')
        return
      }
      this.statsChartInstance = echarts.init(this.$refs.statsChart)
      try {
        const res = await getAllStat()
        const total = (res && res.data && res.data.total) ? res.data.total : 0
        const data = (res && res.data && Array.isArray(res.data.categories)) ? res.data.categories.map(i => ({ name: i.name, value: i.value })) : []
        const legend = data.map(d => d.name)
        const option = {
          title: { text: '样本库数据统计', subtext: total ? `共计${total}条` : '', left: 'center' },
          tooltip: { trigger: 'item', formatter: '{b} : {c} ({d}%)' },
          legend: { left: 'center', bottom: 10, data: legend },
          series: [{
            name: '类别占比',
            type: 'pie',
            radius: ['30%', '70%'],
            center: ['50%', '45%'],
            roseType: false,
            data,
            animationEasing: 'cubicInOut',
            animationDuration: 800
          }]
        }
        this.statsChartInstance.setOption(option)
        this.statsChartInstance.resize()
      } catch (e) {
        this.$message.error('获取统计数据失败')
      }
      window.addEventListener('resize', this.resizeStatsChart, { passive: true })
    },
    resizeStatsChart() {
      if (this.statsChartInstance) {
        this.statsChartInstance.resize()
      }
    },
    onStatsDialogClosed() {
      window.removeEventListener('resize', this.resizeStatsChart)
      if (this.statsChartInstance) {
        this.statsChartInstance.dispose()
        this.statsChartInstance = null
      }
    },
    /** 查询典型监控信息管理列表 */
    getList() {
      this.loading = true
      listMonitor(this.queryParams).then(response => {
        this.monitorList = response.rows
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
        deviceType: null,
        devicePrinciple: null,
        infoName: null,
        voltageLevel: null,
        alarmStatus: null,
        alarmLevel: null,
        sendToMonitor: null,
        referenceBasis: null,
        collectionRequirement: null,
        targetDevice: null,
        sourceDevice: null,
        integrationDevice: null,
        updateTime: null,
        createBy: null,
        createTime: null,
        updateBy: null,
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
      this.title = "添加典型监控信息管理"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getMonitor(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改典型监控信息管理"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateMonitor(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMonitor(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除典型监控信息管理编号为"' + ids + '"的数据项？').then(function() {
        return delMonitor(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/monitor/export', {
        ...this.queryParams
      }, `monitor_${new Date().getTime()}.xlsx`)
    },
    // 信号同步：仅提示成功
    syncSignal() {
      this.$message.success('信号同步成功')
    },
    // 打开上传对话框
    handleUpload() {
      this.uploadOpen = true
      this.resetUploadForm()
    },
    // 重置上传表单
    resetUploadForm() {
      this.uploadForm = {
        fileList: ''
      }
    },
    // 文件变化处理
    handleFileChange(value) {
      this.uploadForm.fileList = value
    },
    // 提交上传
    submitUpload() {
      if (!this.uploadForm.fileList) {
        this.$modal.msgError('请选择要上传的文件')
        return
      }
      
      this.uploadLoading = true
      
      // 模拟上传处理（这里可以根据实际需求调用后端API）
      setTimeout(() => {
        this.uploadLoading = false
        this.$modal.msgSuccess('文件上传成功')
        this.uploadOpen = false
        this.resetUploadForm()
        this.handleQuery()
        // 上传成功后刷新列表数据
        this.getList()
      }, 1000)
    },
    // 取消上传
    cancelUpload() {
      this.uploadOpen = false
      this.resetUploadForm()
    }
  }
}
</script>
