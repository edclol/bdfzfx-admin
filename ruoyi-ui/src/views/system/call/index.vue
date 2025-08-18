<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="调用时间">
        <el-date-picker
          v-model="daterangeCallTime"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="接口名称" prop="interfaceName">
        <el-input
          v-model="queryParams.interfaceName"
          placeholder="请输入接口名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="调用结果" prop="callResult">
        <el-select v-model="queryParams.callResult" placeholder="请选择调用结果" clearable>
          <el-option
            v-for="dict in dict.type.sys_remote_signal_call_result"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="响应时长" prop="responseTime">
        <el-input
          v-model="queryParams.responseTime"
          placeholder="请输入响应时长"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="厂站ID" prop="stationId">
        <el-input
          v-model="queryParams.stationId"
          placeholder="请输入厂站ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="厂站名称" prop="stationName">
        <el-input
          v-model="queryParams.stationName"
          placeholder="请输入厂站名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="设备名称" prop="deviceName">
        <el-input
          v-model="queryParams.deviceName"
          placeholder="请输入设备名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="设备类型" prop="deviceType">
        <el-select v-model="queryParams.deviceType" placeholder="请选择设备类型" clearable>
          <el-option
            v-for="dict in dict.type.sys_device_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="电压等级" prop="voltageLevel">
        <el-input
          v-model="queryParams.voltageLevel"
          placeholder="请输入电压等级"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="操作" prop="operation">
        <el-input
          v-model="queryParams.operation"
          placeholder="请输入操作"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="创建者" prop="createBy">
        <el-input
          v-model="queryParams.createBy"
          placeholder="请输入创建者"
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
          v-hasPermi="['system:call:add']"
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
          v-hasPermi="['system:call:edit']"
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
          v-hasPermi="['system:call:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:call:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="callList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="调用时间" align="center" prop="callTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.callTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="接口名称" align="center" prop="interfaceName" />
      <el-table-column label="调用结果" align="center" prop="callResult">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_remote_signal_call_result" :value="scope.row.callResult"/>
        </template>
      </el-table-column>
      <el-table-column label="响应时长" align="center" prop="responseTime" />
      <el-table-column label="厂站ID" align="center" prop="stationId" />
      <el-table-column label="厂站名称" align="center" prop="stationName" />
      <el-table-column label="设备名称" align="center" prop="deviceName" />
      <el-table-column label="设备类型" align="center" prop="deviceType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_device_type" :value="scope.row.deviceType"/>
        </template>
      </el-table-column>
      <el-table-column label="电压等级" align="center" prop="voltageLevel" />
      <el-table-column label="操作" align="center" prop="operation" />
      <el-table-column label="创建者" align="center" prop="createBy" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:call:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:call:remove']"
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

    <!-- 添加或修改遥信调用记录对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="调用时间" prop="callTime">
          <el-date-picker clearable
            v-model="form.callTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择调用时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="接口名称" prop="interfaceName">
          <el-input v-model="form.interfaceName" placeholder="请输入接口名称" />
        </el-form-item>
        <el-form-item label="调用结果" prop="callResult">
          <el-select v-model="form.callResult" placeholder="请选择调用结果">
            <el-option
              v-for="dict in dict.type.sys_remote_signal_call_result"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="响应时长" prop="responseTime">
          <el-input v-model="form.responseTime" placeholder="请输入响应时长" />
        </el-form-item>
        <el-form-item label="厂站ID" prop="stationId">
          <el-input v-model="form.stationId" placeholder="请输入厂站ID" />
        </el-form-item>
        <el-form-item label="厂站名称" prop="stationName">
          <el-input v-model="form.stationName" placeholder="请输入厂站名称" />
        </el-form-item>
        <el-form-item label="设备名称" prop="deviceName">
          <el-input v-model="form.deviceName" placeholder="请输入设备名称" />
        </el-form-item>
        <el-form-item label="设备类型" prop="deviceType">
          <el-select v-model="form.deviceType" placeholder="请选择设备类型">
            <el-option
              v-for="dict in dict.type.sys_device_type"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="电压等级" prop="voltageLevel">
          <el-input v-model="form.voltageLevel" placeholder="请输入电压等级" />
        </el-form-item>
        <el-form-item label="操作" prop="operation">
          <el-input v-model="form.operation" placeholder="请输入操作" />
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
import { listCall, getCall, delCall, addCall, updateCall } from "@/api/system/call"

export default {
  name: "Call",
  dicts: ['sys_device_type', 'sys_remote_signal_call_result'],
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
      // 遥信调用记录表格数据
      callList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 操作时间范围
      daterangeCallTime: [],
      // 操作时间范围
      daterangeCreateTime: [],
      // 操作时间范围
      daterangeUpdateTime: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        callTime: null,
        interfaceName: null,
        callResult: null,
        responseTime: null,
        stationId: null,
        stationName: null,
        deviceName: null,
        deviceType: null,
        voltageLevel: null,
        operation: null,
        createBy: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        callTime: [
          { required: true, message: "调用时间不能为空", trigger: "blur" }
        ],
        interfaceName: [
          { required: true, message: "接口名称不能为空", trigger: "blur" }
        ],
        callResult: [
          { required: true, message: "调用结果不能为空", trigger: "change" }
        ],
        responseTime: [
          { required: true, message: "响应时长不能为空", trigger: "blur" }
        ],
        stationId: [
          { required: true, message: "厂站ID不能为空", trigger: "blur" }
        ],
        stationName: [
          { required: true, message: "厂站名称不能为空", trigger: "blur" }
        ],
        deviceType: [
          { required: true, message: "设备类型不能为空", trigger: "change" }
        ],
        voltageLevel: [
          { required: true, message: "电压等级不能为空", trigger: "blur" }
        ],
        operation: [
          { required: true, message: "操作不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询遥信调用记录列表 */
    getList() {
      this.loading = true
      this.queryParams.params = {}
      if (null != this.daterangeCallTime && '' != this.daterangeCallTime) {
        this.queryParams.params["beginCallTime"] = this.daterangeCallTime[0]
        this.queryParams.params["endCallTime"] = this.daterangeCallTime[1]
      }
      if (null != this.daterangeCreateTime && '' != this.daterangeCreateTime) {
        this.queryParams.params["beginCreateTime"] = this.daterangeCreateTime[0]
        this.queryParams.params["endCreateTime"] = this.daterangeCreateTime[1]
      }
      if (null != this.daterangeUpdateTime && '' != this.daterangeUpdateTime) {
        this.queryParams.params["beginUpdateTime"] = this.daterangeUpdateTime[0]
        this.queryParams.params["endUpdateTime"] = this.daterangeUpdateTime[1]
      }
      listCall(this.queryParams).then(response => {
        this.callList = response.rows
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
        callTime: null,
        interfaceName: null,
        callResult: null,
        responseTime: null,
        stationId: null,
        stationName: null,
        deviceName: null,
        deviceType: null,
        voltageLevel: null,
        operation: null,
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
      this.daterangeCallTime = []
      this.daterangeCreateTime = []
      this.daterangeUpdateTime = []
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
      this.title = "添加遥信调用记录"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getCall(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改遥信调用记录"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateCall(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addCall(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除遥信调用记录编号为"' + ids + '"的数据项？').then(function() {
        return delCall(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/call/export', {
        ...this.queryParams
      }, `call_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
