<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="序号" prop="id">
        <el-input
          v-model="queryParams.id"
          placeholder="请输入序号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
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
      <el-form-item label="间隔ID" prop="intervalId">
        <el-input
          v-model="queryParams.intervalId"
          placeholder="请输入间隔ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
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
      <el-form-item label="电压等级" prop="vLevel">
        <el-input
          v-model="queryParams.vLevel"
          placeholder="请输入电压等级"
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
          v-hasPermi="['system:all:add']"
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
          v-hasPermi="['system:all:edit']"
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
          v-hasPermi="['system:all:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:all:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="allList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="序号" align="center" prop="id" />
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
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:all:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:all:remove']"
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

    <!-- 添加或修改样本库对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="遥信ID" prop="yxId">
          <el-input v-model="form.yxId" placeholder="请输入遥信ID" />
        </el-form-item>
        <el-form-item label="变电站ID" prop="substationId">
          <el-input v-model="form.substationId" placeholder="请输入变电站ID" />
        </el-form-item>
        <el-form-item label="间隔ID" prop="intervalId">
          <el-input v-model="form.intervalId" placeholder="请输入间隔ID" />
        </el-form-item>
        <el-form-item label="设备类型" prop="yxType">
          <el-select v-model="form.yxType" placeholder="请选择设备类型">
            <el-option
              v-for="dict in dict.type.sys_device_type"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="电压等级" prop="vLevel">
          <el-input v-model="form.vLevel" placeholder="请输入电压等级" />
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
import { listAll, getAll, delAll, addAll, updateAll } from "@/api/system/all"

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
        id: null,
        yxId: null,
        infoName: null,
        infoNameOriginal: null,
        substationId: null,
        intervalId: null,
        yxType: null,
        deviceType: null,
        partType: null,
        devicePrinciple: null,
        vLevel: null,
        alarmType: null,
        alarmLevel: null,
        needPush: null,
        reference: null,
        requirement: null,
        targetDevice: null,
        originDevice: null,
        dataPrimaryDevice: null,
        dataSecondaryDevice: null,
        isIncludeCurlyBraces: null
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
      this.title = "添加样本库"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getAll(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改样本库"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateAll(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addAll(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除样本库编号为"' + ids + '"的数据项？').then(function() {
        return delAll(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/all/export', {
        ...this.queryParams
      }, `all_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
