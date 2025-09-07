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
        <el-table-column label="条件语句" align="center" prop="dbStatement" />
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
          <el-form-item label="条件语句" prop="dbStatement">
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
      }
    }
  }
  </script>
  