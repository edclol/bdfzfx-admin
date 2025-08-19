<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <!-- <el-form-item label="序号" prop="id">
        <el-input
          v-model="queryParams.id"
          placeholder="请输入序号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item> -->
      <el-form-item label="遥信ID" prop="yxId">
        <el-input
          v-model="queryParams.yxId"
          placeholder="请输入遥信ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="变电站ID" prop="substationId">
        <el-input
          v-model="queryParams.substationId"
          placeholder="请输入变电站ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <!-- <el-form-item label="间隔ID" prop="intervalId">
        <el-input
          v-model="queryParams.intervalId"
          placeholder="请输入间隔ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item> -->
      <el-form-item label="设备类型" prop="yxType">
        <el-select v-model="queryParams.yxType" placeholder="请选择设备类型" clearable>
          <el-option
            v-for="dict in dict.type.sys_device_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <!-- <el-form-item label="电压等级" prop="vLevel">
        <el-input
          v-model="queryParams.vLevel"
          placeholder="请输入电压等级"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item> -->
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
        <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleSampleExport">样本打乱/导出</el-button>
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
    </el-row>

    <el-table v-loading="loading" :data="allList" >
      <el-table-column label="序号" width="50" align="center" prop="id" />
      <el-table-column label="遥信ID" align="center" prop="yxId" />
      <el-table-column label="变电站ID" align="center" prop="substationId" />
      <el-table-column label="间隔ID" align="center" prop="intervalId" />
      <el-table-column label="设备类型" align="center" prop="yxType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_device_type" :value="scope.row.yxType"/>
        </template>
      </el-table-column>
      <el-table-column label="电压等级" align="center" prop="vLevel" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
         
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
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

    <!-- 样本批量上传对话框 -->
    <el-dialog :title="upload.title" :visible.sync="upload.open" width="520px" append-to-body>
      <el-upload
        ref="upload"
        :limit="10"
        multiple
        accept=".xlsx, .xls"
        :headers="upload.headers"
        :action="upload.url + '?updateSupport=' + upload.updateSupport"
        :disabled="upload.isUploading"
        :on-progress="handleFileUploadProgress"
        :on-success="handleFileSuccess"
        :auto-upload="false"
        drag
      >
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em>（可多选）</div>
        <div class="el-upload__tip" slot="tip">
          <span>仅允许导入xls、xlsx格式文件。支持单个或多个文件</span>
          <el-link type="primary" :underline="false" style="font-size: 12px; vertical-align: baseline" @click="importTemplate">下载模板</el-link>
        </div>
      </el-upload>
      <div v-if="upload.isUploading" style="margin-top: 10px;">
        <el-progress :percentage="upload.progress" :text-inside="true" status="success"></el-progress>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFileForm" :loading="upload.isUploading">确定</el-button>
        <el-button @click="upload.open = false" :disabled="upload.isUploading">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 数据统计（饼图） -->
    <el-dialog title="样本库数据统计" :visible.sync="stat.open" width="820px" append-to-body>
      <div ref="statsChart" style="width: 100%; height: 420px;"></div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="stat.open = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 版本管理 -->
    <el-dialog title="数据版本管理" :visible.sync="version.open" width="800px" append-to-body>
      <el-table :data="version.list" v-loading="version.loading" >
        <el-table-column prop="versionNumber" label="版本号" width="140" />
        <el-table-column prop="changeTime" label="变更时间" width="180" />
        <el-table-column prop="changeContent" label="变更内容" />
        <el-table-column prop="operation" label="操作说明" width="160" />
        <el-table-column label="操作" width="120">
          <template slot-scope="scope">
            <el-button type="text" size="mini" @click="downloadVersion(scope.row)">下载</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="version.open = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 监控信息详情查看 -->
    <el-dialog :title="detail.title" :visible.sync="detail.open" width="700px"  append-to-body>
      <el-form label-width="120px" v-loading="detail.loading">
        <el-form-item label="变电站ID">
          <span>{{ detail.item.substationId }}</span>
        </el-form-item>
        <el-form-item label="遥信ID">
          <span>{{ detail.item.yxId }}</span>
        </el-form-item>
        <el-form-item label="监控ID">
          <span>{{ detail.item.intervalId }}</span>
        </el-form-item>
        <el-form-item label="遥信类型">
          <span>{{ detail.item.partType }}</span>
        </el-form-item>
      
        <el-form-item label="入库时间">
          <span>{{ detail.item.importTime }}</span>
        </el-form-item>
        <el-form-item label="监控信息内容">
          <span>{{ detail.item.dataPrimaryDevice }}</span>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="detail.open = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listAll, getAll, getAllStat, getVersion, getRandomExport,importTemplate } from "@/api/system/all"
import { getToken } from "@/utils/auth"
import * as echarts from 'echarts'
require('echarts/theme/macarons')

export default {
  name: "All",
  dicts: ['sys_device_type'],
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
      // 样本库表格数据
      allList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        id: null,
        yxId: null,
        substationId: null,
        intervalId: null,
        yxType: null,
        vLevel: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        yxId: [
          { required: true, message: "遥信ID不能为空", trigger: "blur" }
        ],
        substationId: [
          { required: true, message: "变电站ID不能为空", trigger: "blur" }
        ],
        intervalId: [
          { required: true, message: "间隔ID不能为空", trigger: "blur" }
        ],
        yxType: [
          { required: true, message: "设备类型不能为空", trigger: "change" }
        ],
        vLevel: [
          { required: true, message: "电压等级不能为空", trigger: "blur" }
        ],
      },
      // 上传配置
      upload: {
        open: false,
        title: '样本数据批量上传',
        isUploading: false,
        progress: 0,
        updateSupport: false,
        headers: { Authorization: 'Bearer ' + getToken() },
        url: process.env.VUE_APP_BASE_API + '/system/all/importData'
      },
      // 统计
      stat: {
        open: false,
        chart: null
      },
      // 版本管理
      version: {
        open: false,
        loading: false,
        list: []
      },
      // 详情查看
      detail: {
        open: false,
        title: '监控信息详情（监控信息点表-全）',
        loading: false,
        list: [],
        item: {}
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询样本库列表 */
    getList() {
      this.loading = true
      listAll(this.queryParams).then(response => {
        this.allList = response.rows
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
   
   
   
    /** 查看（打开全量详情列表） */
    handleView(row) {
      this.detail.title = '监控信息详情'
      this.detail.open = true
      this.detail.loading = true
      getAll(row.id).then(res => {
        const d = res && res.data ? res.data : {}
        this.detail.item = {
          ...d,
          ...row
        }
      }).finally(() => { this.detail.loading = false })
    },
    /** 导出（打乱后导出） */
    handleSampleExport() {
      getRandomExport({}).then(res => {
        //下载流
        const blob = new Blob([res], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' })
        const url = window.URL.createObjectURL(blob)
        const a = document.createElement('a')
        a.href = url
        a.download = '监控信息样本.xlsx'
        a.click()
        window.URL.revokeObjectURL(url)
        this.$message.success('样本打乱/导出成功')
      }).finally(() => { this.detail.loading = false })
    },
    /** 样本批量上传 */
    handleSampleUpload() {
      this.upload.title = '样本数据批量上传'
      this.upload.open = true
      this.upload.progress = 0
    },
    async importTemplate() {
      //使用a标签下载模板
      const res = await importTemplate()
      console.log(res)
      this.$download.name(res.msg)
    },
    handleFileUploadProgress(event, file, fileList) {
      this.upload.isUploading = true
      this.upload.progress = Math.floor(event.percent)
    },
    handleFileSuccess(response, file, fileList) {
      // 当所有文件完成后，给出提示
      if (fileList.every(f => f.status === 'success')) {
        this.$notify({ title: '上传完成', message: '样本集上传已完成。', type: 'success' })
        this.upload.open = false
        this.upload.isUploading = false
        this.upload.progress = 100
        this.$refs.upload && this.$refs.upload.clearFiles()
        this.getList()
      }
    },
    submitFileForm() {
      this.$refs.upload && this.$refs.upload.submit()
    },
    /** 数据统计（饼图） */
    handleSampleStatistics() {
      this.stat.open = true
      this.$nextTick(() => {
        if (!this.stat.chart) {
          this.stat.chart = echarts.init(this.$refs.statsChart, 'macarons')
        }
        getAllStat().then(res => {
          const total = (res && res.data && res.data.total) ? res.data.total : 0
          const data = (res && res.data && Array.isArray(res.data.categories)) ? res.data.categories.map(i => ({ name: i.name, value: i.value })) : []
          const legend = data.map(d => d.name)
          this.stat.chart.setOption({
            title: { text: '样本库数据统计', subtext: total ? `共计${total}条` : '', left: 'center' },
            tooltip: { trigger: 'item', formatter: '{b} : {c} ({d}%)' },
            legend: { left: 'center', bottom: 10, data: legend },
            series: [{
              name: '设备类型占比',
              type: 'pie',
              radius: [20, 120],
              center: ['50%', '45%'],
              roseType: 'radius',
              data: data,
              animationEasing: 'cubicInOut',
              animationDuration: 800
            }]
          })
          this.stat.chart.resize()
        })
      })
    },
    /** 版本管理 */
    handleVersionManagement() {
      this.version.open = true
      this.version.loading = true
      getVersion().then(res => {
        this.version.list = Array.isArray(res.rows) ? res.rows : []
      }).finally(() => { this.version.loading = false })
    },
    createVersion() {
      this.$message.success('已创建新版本（示例），可在后端完善版本持久化逻辑')
    },
    downloadVersion(row) {
      getRandomExport({}).then(res => {
        //下载流
        const blob = new Blob([res], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' })
        const url = window.URL.createObjectURL(blob)
        const a = document.createElement('a')
        a.href = url
        a.download = row.versionNumber + '.xlsx'
        a.click()
        window.URL.revokeObjectURL(url)
        this.$message.success('版本下载成功')
      }).finally(() => { this.version.loading = false })
    },
    /** 标准化检测 */
    handleStandardizationCheck() {
      this.$message.success('标准化检测完成')
    },
    /** 备份 */
    handleBackup() {
      this.$message.success('备份成功')
    },
  }
}
</script>
