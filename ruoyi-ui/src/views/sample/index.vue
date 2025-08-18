<template>
  <div class="app-container">
    <!-- 查询条件 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="变电站ID" prop="substationId">
        <el-input v-model="queryParams.substationId" placeholder="请输入变电站ID" clearable style="width: 200px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="遥信ID" prop="telemetryId">
        <el-input v-model="queryParams.telemetryId" placeholder="请输入遥信ID" clearable style="width: 200px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="设备类型" prop="deviceType">
        <el-select v-model="queryParams.deviceType" placeholder="请选择设备类型" clearable style="width: 200px">
          <el-option label="变压器" value="transformer" />
          <el-option label="开关" value="switch" />
          <el-option label="刀闸" value="disconnector" />
          <el-option label="母线" value="busbar" />
          <el-option label="线路" value="line" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 操作按钮 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-upload2" size="mini" @click="handleSampleUpload">样本上传</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-refresh" size="mini" @click="handleSampleShuffle">样本打乱</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleSampleExport">样本导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="info" plain icon="el-icon-data-analysis" size="mini" @click="handleSampleStatistics">数据统计</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-files" size="mini" @click="handleVersionManagement">版本管理</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-check" size="mini" @click="handleStandardizationCheck">标准化检测</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-document-copy" size="mini" @click="handleBackup">备份</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" :columns="columns"></right-toolbar>
    </el-row>

    <!-- 数据表格 -->
    <el-table v-loading="loading" :data="sampleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="50" align="center" />
      <el-table-column label="序号" align="center" width="60">
        <template slot-scope="scope">
          <span>{{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}</span>
        </template>
      </el-table-column>
      <el-table-column label="变电站ID" align="center" prop="substationId" v-if="columns[0].visible" />
      <el-table-column label="遥信ID" align="center" prop="telemetryId" v-if="columns[1].visible" />
      <el-table-column label="间隔ID" align="center" prop="intervalId" v-if="columns[2].visible" />
      <el-table-column label="设备类型" align="center" prop="deviceType" v-if="columns[3].visible">
        <template slot-scope="scope">
          <el-tag :type="getDeviceTypeTag(scope.row.deviceType)">{{ getDeviceTypeLabel(scope.row.deviceType) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="电压等级" align="center" prop="voltageLevel" v-if="columns[4].visible">
        <template slot-scope="scope">
          <span>{{ scope.row.voltageLevel }}kV</span>
        </template>
      </el-table-column>
      <el-table-column label="入库时间" align="center" prop="createTime" v-if="columns[5].visible" width="160">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="120" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-view" @click="handleView(scope.row)">查看</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 样本上传对话框 -->
    <el-dialog title="样本上传" :visible.sync="uploadDialog.visible" width="600px" append-to-body>
      <el-upload
        ref="upload"
        :limit="10"
        accept=".csv,.xlsx,.xls,.txt"
        :headers="uploadHeaders"
        :action="uploadUrl"
        :disabled="uploadDialog.uploading"
        :on-progress="handleFileProgress"
        :on-success="handleFileSuccess"
        :on-error="handleFileError"
        :file-list="uploadDialog.fileList"
        multiple
        drag>
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <div class="el-upload__tip" slot="tip">支持 .csv, .xlsx, .xls, .txt 格式文件，最多可上传10个文件</div>
      </el-upload>
      
      <!-- 上传进度条 -->
      <div v-if="uploadDialog.uploading" style="margin-top: 20px;">
        <el-progress :percentage="uploadDialog.progress" :stroke-width="18" text-inside></el-progress>
        <div style="text-align: center; margin-top: 10px; color: #666;">
          正在上传文件... {{ uploadDialog.currentFile }}/{{ uploadDialog.totalFiles }}
        </div>
      </div>

      <div slot="footer" class="dialog-footer">
        <el-button @click="uploadDialog.visible = false">取 消</el-button>
        <el-button type="primary" @click="submitUpload" :disabled="uploadDialog.uploading">开始上传</el-button>
      </div>
    </el-dialog>

    <!-- 数据统计对话框 -->
    <el-dialog title="样本数据统计" :visible.sync="statisticsDialog.visible" width="800px" append-to-body>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-card>
            <div slot="header">总体统计</div>
            <div class="statistics-item">
              <span class="label">总样本数：</span>
              <span class="value">{{ statistics.totalSamples }}</span>
            </div>
            <div class="statistics-item">
              <span class="label">变电站数量：</span>
              <span class="value">{{ statistics.substationCount }}</span>
            </div>
            <div class="statistics-item">
              <span class="label">设备类型数：</span>
              <span class="value">{{ statistics.deviceTypeCount }}</span>
            </div>
          </el-card>
        </el-col>
        <el-col :span="12">
          <el-card>
            <div slot="header">设备类型分布</div>
            <div v-for="(count, type) in statistics.deviceTypeDistribution" :key="type" class="statistics-item">
              <span class="label">{{ getDeviceTypeLabel(type) }}：</span>
              <span class="value">{{ count }}</span>
            </div>
          </el-card>
        </el-col>
      </el-row>
      <div slot="footer" class="dialog-footer">
        <el-button @click="statisticsDialog.visible = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 版本管理对话框 -->
    <el-dialog title="数据版本管理" :visible.sync="versionDialog.visible" width="800px" append-to-body>
      <el-table :data="versionList" style="width: 100%">
        <el-table-column prop="version" label="版本号" width="120" />
        <el-table-column prop="description" label="版本描述" />
        <el-table-column prop="createTime" label="创建时间" width="160">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.createTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="sampleCount" label="样本数量" width="100" align="center" />
        <el-table-column label="操作" width="150" align="center">
          <template slot-scope="scope">
            <el-button size="mini" type="text" @click="handleVersionView(scope.row)">查看</el-button>
            <el-button size="mini" type="text" @click="handleVersionRestore(scope.row)">恢复</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="versionDialog.visible = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getToken } from "@/utils/auth"
import { parseTime } from "@/utils/ruoyi"
import { 
  listSample, 
  getSample, 
  delSample, 
  addSample, 
  updateSample,
  uploadSample,
  shuffleSample,
  exportSample,
  getSampleStatistics,
  getVersionList,
  createVersion,
  restoreVersion,
  standardizationCheck,
  backupSample
} from "@/api/sample/index"

export default {
  name: "Sample",
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
      // 样本列表数据
      sampleList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        substationId: undefined,
        telemetryId: undefined,
        deviceType: undefined
      },
      // 日期范围
      dateRange: [],
      // 列信息
      columns: [
        { key: 0, label: '变电站ID', visible: true },
        { key: 1, label: '遥信ID', visible: true },
        { key: 2, label: '间隔ID', visible: true },
        { key: 3, label: '设备类型', visible: true },
        { key: 4, label: '电压等级', visible: true },
        { key: 5, label: '入库时间', visible: true }
      ],
      // 上传对话框
      uploadDialog: {
        visible: false,
        uploading: false,
        progress: 0,
        currentFile: 0,
        totalFiles: 0,
        fileList: []
      },
      // 上传配置
      uploadUrl: process.env.VUE_APP_BASE_API + "/sample/upload",
      uploadHeaders: { Authorization: "Bearer " + getToken() },
      // 统计对话框
      statisticsDialog: {
        visible: false
      },
      // 统计数据
      statistics: {
        totalSamples: 0,
        substationCount: 0,
        deviceTypeCount: 0,
        deviceTypeDistribution: {}
      },
      // 版本管理对话框
      versionDialog: {
        visible: false
      },
      // 版本列表
      versionList: []
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询样本列表 */
    getList() {
      this.loading = true
      listSample(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.sampleList = response.rows
        this.total = response.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.dateRange = []
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    /** 查看按钮操作 */
    handleView(row) {
      this.$modal.msgInfo(`查看样本：${row.substationId} - ${row.telemetryId}`)
    },
    /** 样本上传按钮操作 */
    handleSampleUpload() {
      this.uploadDialog.visible = true
      this.uploadDialog.fileList = []
      this.uploadDialog.progress = 0
      this.uploadDialog.uploading = false
    },
    /** 样本打乱按钮操作 */
    handleSampleShuffle() {
      this.$modal.confirm('确认要打乱所有样本数据吗？').then(() => {
        shuffleSample().then(response => {
          this.$modal.msgSuccess("样本打乱完成")
          this.getList()
        }).catch(() => {
          this.$modal.msgError("样本打乱失败")
        })
      }).catch(() => {})
    },
    /** 样本导出按钮操作 */
    handleSampleExport() {
      this.download('sample/export', {
        ...this.queryParams
      }, `sample_${new Date().getTime()}.xlsx`)
    },
    /** 数据统计按钮操作 */
    handleSampleStatistics() {
      this.statisticsDialog.visible = true
      this.loadStatistics()
    },
    /** 版本管理按钮操作 */
    handleVersionManagement() {
      this.versionDialog.visible = true
      this.loadVersionList()
    },
    /** 标准化检测按钮操作 */
    handleStandardizationCheck() {
      standardizationCheck().then(response => {
        this.$modal.msgSuccess("标准化检测完成")
      }).catch(() => {
        this.$modal.msgError("标准化检测失败")
      })
    },
    /** 备份按钮操作 */
    handleBackup() {
      backupSample().then(response => {
        this.$modal.msgSuccess("备份成功")
      }).catch(() => {
        this.$modal.msgError("备份失败")
      })
    },
    /** 获取设备类型标签 */
    getDeviceTypeTag(type) {
      const typeMap = {
        transformer: 'primary',
        switch: 'success',
        disconnector: 'warning',
        busbar: 'info',
        line: 'danger'
      }
      return typeMap[type] || 'info'
    },
    /** 获取设备类型标签文本 */
    getDeviceTypeLabel(type) {
      const typeMap = {
        transformer: '变压器',
        switch: '开关',
        disconnector: '刀闸',
        busbar: '母线',
        line: '线路'
      }
      return typeMap[type] || type
    },
    /** 加载统计数据 */
    loadStatistics() {
      getSampleStatistics().then(response => {
        this.statistics = response.data
      }).catch(() => {
        this.$modal.msgError("获取统计数据失败")
      })
    },
    /** 加载版本列表 */
    loadVersionList() {
      getVersionList().then(response => {
        this.versionList = response.rows
      }).catch(() => {
        this.$modal.msgError("获取版本列表失败")
      })
    },
    /** 文件上传进度处理 */
    handleFileProgress(event, file, fileList) {
      this.uploadDialog.uploading = true
      this.uploadDialog.currentFile = fileList.indexOf(file) + 1
      this.uploadDialog.totalFiles = fileList.length
      this.uploadDialog.progress = Math.round((event.percent || 0))
    },
    /** 文件上传成功处理 */
    handleFileSuccess(response, file, fileList) {
      this.uploadDialog.progress = 100
      setTimeout(() => {
        this.uploadDialog.visible = false
        this.uploadDialog.uploading = false
        this.uploadDialog.progress = 0
        this.$refs.upload.clearFiles()
        this.$modal.msgSuccess("样本上传成功")
        this.getList()
      }, 1000)
    },
    /** 文件上传失败处理 */
    handleFileError(err, file, fileList) {
      this.uploadDialog.uploading = false
      this.$modal.msgError("文件上传失败：" + file.name)
    },
    /** 提交上传 */
    submitUpload() {
      this.$refs.upload.submit()
    },
    /** 版本查看 */
    handleVersionView(row) {
      this.$modal.msgInfo(`查看版本：${row.version}`)
    },
    /** 版本恢复 */
    handleVersionRestore(row) {
      this.$modal.confirm(`确认要恢复到版本 ${row.version} 吗？`).then(() => {
        restoreVersion(row.id).then(response => {
          this.$modal.msgSuccess(`已恢复到版本 ${row.version}`)
          this.loadVersionList()
        }).catch(() => {
          this.$modal.msgError("版本恢复失败")
        })
      }).catch(() => {})
    },
    parseTime
  }
}
</script>

<style lang="scss" scoped>
.statistics-item {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
  
  .label {
    font-weight: 500;
    color: #606266;
  }
  
  .value {
    font-weight: bold;
    color: #409EFF;
  }
}

.el-upload__tip {
  color: #909399;
  font-size: 12px;
  margin-top: 7px;
}

.mb8 {
  margin-bottom: 8px;
}
</style>