<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="模型名称" prop="modelName">
        <el-input
          v-model="queryParams.modelName"
          placeholder="请输入模型名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="版本号" prop="versionNumber">
        <el-input
          v-model="queryParams.versionNumber"
          placeholder="请输入版本号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="上传时间" prop="uploadTime">
        <el-date-picker clearable
          v-model="queryParams.uploadTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择上传时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="调用次数" prop="callCount">
        <el-input
          v-model="queryParams.callCount"
          placeholder="请输入调用次数"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="精准率" prop="precisionRate">
        <el-input
          v-model="queryParams.precisionRate"
          placeholder="请输入精准率"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="召回率" prop="recallRate">
        <el-input
          v-model="queryParams.recallRate"
          placeholder="请输入召回率"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="模型大小" prop="modelSize">
        <el-input
          v-model="queryParams.modelSize"
          placeholder="请输入模型大小"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="部署路径" prop="modelPath">
        <el-input
          v-model="queryParams.modelPath"
          placeholder="请输入部署路径"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="F1分数" prop="f1Score">
        <el-input
          v-model="queryParams.f1Score"
          placeholder="请输入F1分数"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否启用" prop="isUsed">
        <el-input
          v-model="queryParams.isUsed"
          placeholder="请输入是否启用"
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
          v-hasPermi="['system:model:add']"
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
          v-hasPermi="['system:model:edit']"
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
          v-hasPermi="['system:model:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:model:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="modelList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <el-table-column label="模型名称" align="center" prop="modelName" />
      <el-table-column label="版本号" align="center" prop="versionNumber" />
      <el-table-column label="上传时间" align="center" prop="uploadTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.uploadTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="调用次数" align="center" prop="callCount" />
      <el-table-column label="精准率" align="center" prop="precisionRate" />
      <el-table-column label="召回率" align="center" prop="recallRate" />
      <el-table-column label="模型大小" align="center" prop="modelSize" />
      <el-table-column label="部署路径" align="center" prop="modelPath" />
      <el-table-column label="F1分数" align="center" prop="f1Score" />
      <el-table-column label="模型描述或用途说明" align="center" prop="description" />
      <el-table-column label="是否启用" align="center" prop="isUsed" />
      <el-table-column label="备注信息" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:model:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:model:remove']"
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

    <!-- 添加或修改模型信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="模型名称" prop="modelName">
          <el-input v-model="form.modelName" placeholder="请输入模型名称" />
        </el-form-item>
        <el-form-item label="版本号" prop="versionNumber">
          <el-input v-model="form.versionNumber" placeholder="请输入版本号" />
        </el-form-item>
        <el-form-item label="上传时间" prop="uploadTime">
          <el-date-picker clearable
            v-model="form.uploadTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择上传时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="调用次数" prop="callCount">
          <el-input v-model="form.callCount" placeholder="请输入调用次数" />
        </el-form-item>
        <el-form-item label="精准率" prop="precisionRate">
          <el-input v-model="form.precisionRate" placeholder="请输入精准率" />
        </el-form-item>
        <el-form-item label="召回率" prop="recallRate">
          <el-input v-model="form.recallRate" placeholder="请输入召回率" />
        </el-form-item>
        <el-form-item label="模型大小" prop="modelSize">
          <el-input v-model="form.modelSize" placeholder="请输入模型大小" />
        </el-form-item>
        <el-form-item label="部署路径" prop="modelPath">
          <el-input v-model="form.modelPath" placeholder="请输入部署路径" />
        </el-form-item>
        <el-form-item label="F1分数" prop="f1Score">
          <el-input v-model="form.f1Score" placeholder="请输入F1分数" />
        </el-form-item>
        <el-form-item label="模型描述或用途说明" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="是否启用" prop="isUsed">
          <el-input v-model="form.isUsed" placeholder="请输入是否启用" />
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
import { listModel, getModel, delModel, addModel, updateModel } from "@/api/system/model"

export default {
  name: "Model",
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
      // 模型信息表格数据
      modelList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        modelName: null,
        versionNumber: null,
        uploadTime: null,
        callCount: null,
        precisionRate: null,
        recallRate: null,
        modelSize: null,
        modelPath: null,
        f1Score: null,
        description: null,
        isUsed: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        modelName: [
          { required: true, message: "模型名称不能为空", trigger: "blur" }
        ],
        versionNumber: [
          { required: true, message: "版本号不能为空", trigger: "blur" }
        ],
        uploadTime: [
          { required: true, message: "上传时间不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询模型信息列表 */
    getList() {
      this.loading = true
      listModel(this.queryParams).then(response => {
        this.modelList = response.rows
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
        modelName: null,
        versionNumber: null,
        uploadTime: null,
        callCount: null,
        precisionRate: null,
        recallRate: null,
        modelSize: null,
        modelPath: null,
        f1Score: null,
        description: null,
        isUsed: null,
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
      this.title = "添加模型信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getModel(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改模型信息"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateModel(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addModel(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除模型信息编号为"' + ids + '"的数据项？').then(function() {
        return delModel(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/model/export', {
        ...this.queryParams
      }, `model_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
