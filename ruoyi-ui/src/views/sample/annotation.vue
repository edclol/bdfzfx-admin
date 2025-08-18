<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="任务名称" prop="taskName">
        <el-input v-model="queryParams.taskName" placeholder="请输入任务名称" clearable style="width: 200px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="任务状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择任务状态" clearable style="width: 200px">
          <el-option label="未开始" :value="0" />
          <el-option label="进行中" :value="1" />
          <el-option label="已完成" :value="2" />
          <el-option label="已回收" :value="3" />
        </el-select>
      </el-form-item>
      <el-form-item label="创建时间">
        <el-date-picker
          v-model="dateRange"
          type="daterange"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          value-format="yyyy-MM-dd"
          style="width: 240px"
          clearable />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleCreateTask">创建标注任务</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-collection" size="mini" @click="openSynonymDialog">同义词库配置</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-magic-stick" size="mini" @click="handleTokenize">一键分词</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" :columns="columns"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="taskList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="50" align="center" />
      <el-table-column label="序号" align="center" width="60">
        <template slot-scope="scope">
          <span>{{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}</span>
        </template>
      </el-table-column>
      <el-table-column label="任务名称" align="center" prop="taskName" v-if="columns[0].visible" />
      <el-table-column label="样本数量" align="center" prop="sampleCount" width="100" v-if="columns[1].visible" />
      <el-table-column label="标注进度" align="center" width="180" v-if="columns[2].visible">
        <template slot-scope="scope">
          <el-progress :percentage="Number(scope.row.progress)" :status="Number(scope.row.progress) === 100 ? 'success' : undefined"></el-progress>
        </template>
      </el-table-column>
      <el-table-column label="处理人" align="center" prop="assignee" v-if="columns[3].visible" />
      <el-table-column label="任务状态" align="center" prop="status" width="100" v-if="columns[4].visible">
        <template slot-scope="scope">
          <el-tag :type="getStatusTag(scope.row.status)">{{ getStatusLabel(scope.row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="160" v-if="columns[5].visible">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="220" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-video-play" @click="handleStartOrContinue(scope.row)">{{ scope.row.status === 0 ? '开始标注' : '继续标注' }}</el-button>
          <el-button size="mini" type="text" icon="el-icon-refresh-left" @click="handleRecycle(scope.row)" :disabled="scope.row.status === 3">回收</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog title="创建标注任务" :visible.sync="createDialog.visible" width="500px" append-to-body>
      <el-form ref="createFormRef" :model="createForm" :rules="createRules" label-width="90px">
        <el-form-item label="任务名称" prop="taskName">
          <el-input v-model="createForm.taskName" placeholder="请输入任务名称" />
        </el-form-item>
        <el-form-item label="处理人" prop="assignee">
          <el-input v-model="createForm.assignee" placeholder="请输入处理人" />
        </el-form-item>
        <el-form-item label="样本数量" prop="sampleCount">
          <el-input-number v-model="createForm.sampleCount" :min="1" :step="1" controls-position="right" style="width: 200px" />
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input type="textarea" :rows="3" v-model="createForm.description" placeholder="请输入任务描述" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="createDialog.visible = false">取 消</el-button>
        <el-button type="primary" @click="submitCreateTask">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="同义词库配置" :visible.sync="synonymDialog.visible" width="700px" append-to-body>
      <div style="margin-bottom: 10px;">
        <el-button type="primary" size="mini" icon="el-icon-plus" @click="handleSynonymAdd">新增</el-button>
        <el-button type="success" size="mini" icon="el-icon-refresh" @click="loadSynonyms">刷新</el-button>
      </div>
      <el-table :data="synonymList" v-loading="synonymDialog.loading" style="width: 100%">
        <el-table-column label="词条" prop="word" width="200" />
        <el-table-column label="同义词" prop="synonyms">
          <template slot-scope="scope">
            <span>{{ formatSynonyms(scope.row.synonyms) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="创建时间" prop="createTime" width="160">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.createTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="140" align="center">
          <template slot-scope="scope">
            <el-button type="text" size="mini" @click="handleSynonymEdit(scope.row)">编辑</el-button>
            <el-button type="text" size="mini" @click="handleSynonymDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="synonymDialog.visible = false">关 闭</el-button>
      </div>
    </el-dialog>

    <el-dialog :title="synonymEditDialog.isEdit ? '编辑同义词' : '新增同义词'" :visible.sync="synonymEditDialog.visible" width="500px" append-to-body>
      <el-form ref="synonymFormRef" :model="synonymForm" :rules="synonymRules" label-width="90px">
        <el-form-item label="词条" prop="word">
          <el-input v-model="synonymForm.word" placeholder="请输入词条" />
        </el-form-item>
        <el-form-item label="同义词" prop="synonyms">
          <el-input type="textarea" :rows="3" v-model="synonymForm.synonyms" placeholder="用英文逗号分隔多个同义词，如：开关,断路器" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="synonymEditDialog.visible = false">取 消</el-button>
        <el-button type="primary" @click="submitSynonym">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { parseTime } from "@/utils/ruoyi"
import {
  listAnnotationTask,
  addAnnotationTask,
  startAnnotationTask,
  continueAnnotationTask,
  recycleAnnotationTask,
  oneClickTokenize,
  listSynonym,
  addSynonym,
  updateSynonym,
  delSynonym
} from "@/api/annotation/index"

export default {
  name: "Annotation",
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      taskList: [],
      ids: [],
      single: true,
      multiple: true,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        taskName: undefined,
        status: undefined
      },
      dateRange: [],
      columns: [
        { key: 0, label: '任务名称', visible: true },
        { key: 1, label: '样本数量', visible: true },
        { key: 2, label: '标注进度', visible: true },
        { key: 3, label: '处理人', visible: true },
        { key: 4, label: '任务状态', visible: true },
        { key: 5, label: '创建时间', visible: true }
      ],
      createDialog: {
        visible: false
      },
      createForm: {
        taskName: undefined,
        assignee: undefined,
        sampleCount: 100,
        description: undefined
      },
      createRules: {
        taskName: [
          { required: true, message: '任务名称不能为空', trigger: 'blur' }
        ],
        sampleCount: [
          { required: true, message: '样本数量不能为空', trigger: 'change' }
        ]
      },
      synonymDialog: {
        visible: false,
        loading: false
      },
      synonymList: [],
      synonymEditDialog: {
        visible: false,
        isEdit: false
      },
      synonymForm: {
        id: undefined,
        word: undefined,
        synonyms: ''
      },
      synonymRules: {
        word: [
          { required: true, message: '词条不能为空', trigger: 'blur' }
        ],
        synonyms: [
          { required: true, message: '同义词不能为空', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listAnnotationTask(this.addDateRange(this.queryParams, this.dateRange)).then(res => {
        this.taskList = res.rows || []
        this.total = res.total || 0
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.dateRange = []
      this.resetForm('queryForm')
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleCreateTask() {
      this.createDialog.visible = true
      this.createForm = { taskName: undefined, assignee: undefined, sampleCount: 100, description: undefined }
    },
    submitCreateTask() {
      this.$refs.createFormRef.validate(valid => {
        if (!valid) return
        addAnnotationTask(this.createForm).then(() => {
          this.$modal.msgSuccess('创建成功')
          this.createDialog.visible = false
          this.getList()
        })
      })
    },
    handleStartOrContinue(row) {
      const isNotStarted = row.status === 0
      const action = isNotStarted ? startAnnotationTask : continueAnnotationTask
      action(row.id).then(() => {
        this.$modal.msgSuccess(isNotStarted ? '已开始标注' : '继续标注')
        this.getList()
      })
    },
    handleRecycle(row) {
      this.$modal.confirm('确认回收该任务吗？').then(() => {
        recycleAnnotationTask(row.id).then(() => {
          this.$modal.msgSuccess('已回收')
          this.getList()
        })
      }).catch(() => {})
    },
    openSynonymDialog() {
      this.synonymDialog.visible = true
      this.loadSynonyms()
    },
    loadSynonyms() {
      this.synonymDialog.loading = true
      listSynonym().then(res => {
        this.synonymList = res.rows || []
        this.synonymDialog.loading = false
      }).catch(() => { this.synonymDialog.loading = false })
    },
    handleSynonymAdd() {
      this.synonymEditDialog.isEdit = false
      this.synonymForm = { id: undefined, word: undefined, synonyms: '' }
      this.synonymEditDialog.visible = true
    },
    handleSynonymEdit(row) {
      this.synonymEditDialog.isEdit = true
      this.synonymForm = { id: row.id, word: row.word, synonyms: this.formatSynonyms(row.synonyms) }
      this.synonymEditDialog.visible = true
    },
    submitSynonym() {
      this.$refs.synonymFormRef.validate(valid => {
        if (!valid) return
        const data = {
          id: this.synonymForm.id,
          word: this.synonymForm.word,
          synonyms: this.parseSynonyms(this.synonymForm.synonyms)
        }
        const req = this.synonymEditDialog.isEdit ? updateSynonym : addSynonym
        req(data).then(() => {
          this.$modal.msgSuccess('保存成功')
          this.synonymEditDialog.visible = false
          this.loadSynonyms()
        })
      })
    },
    handleSynonymDelete(row) {
      this.$modal.confirm('确认删除该同义词吗？').then(() => {
        delSynonym(row.id).then(() => {
          this.$modal.msgSuccess('已删除')
          this.loadSynonyms()
        })
      }).catch(() => {})
    },
    handleTokenize() {
      this.$modal.confirm('确认执行一键分词吗？').then(() => {
        oneClickTokenize().then(() => {
          this.$modal.msgSuccess('分词任务已触发')
        })
      }).catch(() => {})
    },
    getStatusTag(status) {
      const map = { 0: 'info', 1: 'warning', 2: 'success', 3: 'danger' }
      return map[status] || 'info'
    },
    getStatusLabel(status) {
      const map = { 0: '未开始', 1: '进行中', 2: '已完成', 3: '已回收' }
      return map[status] || status
    },
    formatSynonyms(value) {
      if (!value) return ''
      if (Array.isArray(value)) return value.join(',')
      return String(value)
    },
    parseSynonyms(value) {
      if (!value) return []
      return String(value)
        .split(',')
        .map(s => s.trim())
        .filter(s => s)
    },
    parseTime
  }
}
</script>

<style lang="scss" scoped>
.mb8 {
  margin-bottom: 8px;
}
</style>