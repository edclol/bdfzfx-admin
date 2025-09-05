<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="所属任务ID，关联sys_label_task.task_id" prop="taskId">
        <el-input
          v-model="queryParams.taskId"
          placeholder="请输入所属任务ID，关联sys_label_task.task_id"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="变电站ID，如：四川草坝" prop="substationId">
        <el-input
          v-model="queryParams.substationId"
          placeholder="请输入变电站ID，如：四川草坝"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="遥信ID，如：断路器表四川草坝四川/草坝/10kV 901开关遥信值" prop="remoteSignalId">
        <el-input
          v-model="queryParams.remoteSignalId"
          placeholder="请输入遥信ID，如：断路器表四川草坝四川/草坝/10kV 901开关遥信值"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="监控ID，如：XXXXXXXXXX" prop="monitorId">
        <el-input
          v-model="queryParams.monitorId"
          placeholder="请输入监控ID，如：XXXXXXXXXX"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="入库时间，如：2025-12-12 10:00:00" prop="entryTime">
        <el-date-picker clearable
          v-model="queryParams.entryTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择入库时间，如：2025-12-12 10:00:00">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="设备原理，如：通用" prop="devicePrinciple">
        <el-input
          v-model="queryParams.devicePrinciple"
          placeholder="请输入设备原理，如：通用"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="适用电压等级(kW)，如：500" prop="voltageLevel">
        <el-input
          v-model="queryParams.voltageLevel"
          placeholder="请输入适用电压等级(kW)，如：500"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="告警等级，如：1级" prop="alarmLevel">
        <el-input
          v-model="queryParams.alarmLevel"
          placeholder="请输入告警等级，如：1级"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否正样例：1=正样例，0=负样例" prop="isPositiveSample">
        <el-input
          v-model="queryParams.isPositiveSample"
          placeholder="请输入是否正样例：1=正样例，0=负样例"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="标注人姓名" prop="labelUser">
        <el-input
          v-model="queryParams.labelUser"
          placeholder="请输入标注人姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="标注时间" prop="labelTime">
        <el-date-picker clearable
          v-model="queryParams.labelTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择标注时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="是否已标注：1=已标注，0=未标注" prop="isLabeled">
        <el-input
          v-model="queryParams.isLabeled"
          placeholder="请输入是否已标注：1=已标注，0=未标注"
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
          v-hasPermi="['system:detail:add']"
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
          v-hasPermi="['system:detail:edit']"
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
          v-hasPermi="['system:detail:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:detail:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="detailList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <el-table-column label="所属任务ID，关联sys_label_task.task_id" align="center" prop="taskId" />
      <el-table-column label="变电站ID，如：四川草坝" align="center" prop="substationId" />
      <el-table-column label="遥信ID，如：断路器表四川草坝四川/草坝/10kV 901开关遥信值" align="center" prop="remoteSignalId" />
      <el-table-column label="监控ID，如：XXXXXXXXXX" align="center" prop="monitorId" />
      <el-table-column label="遥信类型：遥测/遥信/遥控/遥调" align="center" prop="signalType" />
      <el-table-column label="入库时间，如：2025-12-12 10:00:00" align="center" prop="entryTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.entryTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="监控信息内容，描述性文本" align="center" prop="monitorContent" />
      <el-table-column label="设备类型，如：主变保护" align="center" prop="deviceType" />
      <el-table-column label="设备原理，如：通用" align="center" prop="devicePrinciple" />
      <el-table-column label="信息名称，格式为：[主变编号] [设备编号] 保护 [型号] 远方操作硬压板" align="center" prop="infoName" />
      <el-table-column label="适用电压等级(kW)，如：500" align="center" prop="voltageLevel" />
      <el-table-column label="告警/状态，如：告警" align="center" prop="alarmStatus" />
      <el-table-column label="告警等级，如：1级" align="center" prop="alarmLevel" />
      <el-table-column label="是否正样例：1=正样例，0=负样例" align="center" prop="isPositiveSample" />
      <el-table-column label="标注人姓名" align="center" prop="labelUser" />
      <el-table-column label="标注时间" align="center" prop="labelTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.labelTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="是否已标注：1=已标注，0=未标注" align="center" prop="isLabeled" />
      <el-table-column label="备注信息" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:detail:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:detail:remove']"
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

    <!-- 添加或修改样本标注详情对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="所属任务ID，关联sys_label_task.task_id" prop="taskId">
          <el-input v-model="form.taskId" placeholder="请输入所属任务ID，关联sys_label_task.task_id" />
        </el-form-item>
        <el-form-item label="变电站ID，如：四川草坝" prop="substationId">
          <el-input v-model="form.substationId" placeholder="请输入变电站ID，如：四川草坝" />
        </el-form-item>
        <el-form-item label="遥信ID，如：断路器表四川草坝四川/草坝/10kV 901开关遥信值" prop="remoteSignalId">
          <el-input v-model="form.remoteSignalId" placeholder="请输入遥信ID，如：断路器表四川草坝四川/草坝/10kV 901开关遥信值" />
        </el-form-item>
        <el-form-item label="监控ID，如：XXXXXXXXXX" prop="monitorId">
          <el-input v-model="form.monitorId" placeholder="请输入监控ID，如：XXXXXXXXXX" />
        </el-form-item>
        <el-form-item label="入库时间，如：2025-12-12 10:00:00" prop="entryTime">
          <el-date-picker clearable
            v-model="form.entryTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择入库时间，如：2025-12-12 10:00:00">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="监控信息内容，描述性文本">
          <editor v-model="form.monitorContent" :min-height="192"/>
        </el-form-item>
        <el-form-item label="设备原理，如：通用" prop="devicePrinciple">
          <el-input v-model="form.devicePrinciple" placeholder="请输入设备原理，如：通用" />
        </el-form-item>
        <el-form-item label="信息名称，格式为：[主变编号] [设备编号] 保护 [型号] 远方操作硬压板" prop="infoName">
          <el-input v-model="form.infoName" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="适用电压等级(kW)，如：500" prop="voltageLevel">
          <el-input v-model="form.voltageLevel" placeholder="请输入适用电压等级(kW)，如：500" />
        </el-form-item>
        <el-form-item label="告警等级，如：1级" prop="alarmLevel">
          <el-input v-model="form.alarmLevel" placeholder="请输入告警等级，如：1级" />
        </el-form-item>
        <el-form-item label="是否正样例：1=正样例，0=负样例" prop="isPositiveSample">
          <el-input v-model="form.isPositiveSample" placeholder="请输入是否正样例：1=正样例，0=负样例" />
        </el-form-item>
        <el-form-item label="标注人姓名" prop="labelUser">
          <el-input v-model="form.labelUser" placeholder="请输入标注人姓名" />
        </el-form-item>
        <el-form-item label="标注时间" prop="labelTime">
          <el-date-picker clearable
            v-model="form.labelTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择标注时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="是否已标注：1=已标注，0=未标注" prop="isLabeled">
          <el-input v-model="form.isLabeled" placeholder="请输入是否已标注：1=已标注，0=未标注" />
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
import { listDetail, getDetail, delDetail, addDetail, updateDetail } from "@/api/system/detail"

export default {
  name: "Detail",
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
      // 样本标注详情表格数据
      detailList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        taskId: null,
        substationId: null,
        remoteSignalId: null,
        monitorId: null,
        signalType: null,
        entryTime: null,
        monitorContent: null,
        deviceType: null,
        devicePrinciple: null,
        infoName: null,
        voltageLevel: null,
        alarmStatus: null,
        alarmLevel: null,
        isPositiveSample: null,
        labelUser: null,
        labelTime: null,
        isLabeled: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        taskId: [
          { required: true, message: "所属任务ID，关联sys_label_task.task_id不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询样本标注详情列表 */
    getList() {
      this.loading = true
      listDetail(this.queryParams).then(response => {
        this.detailList = response.rows
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
        taskId: null,
        substationId: null,
        remoteSignalId: null,
        monitorId: null,
        signalType: null,
        entryTime: null,
        monitorContent: null,
        deviceType: null,
        devicePrinciple: null,
        infoName: null,
        voltageLevel: null,
        alarmStatus: null,
        alarmLevel: null,
        isPositiveSample: null,
        labelUser: null,
        labelTime: null,
        isLabeled: null,
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
      this.title = "添加样本标注详情"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getDetail(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改样本标注详情"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateDetail(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addDetail(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除样本标注详情编号为"' + ids + '"的数据项？').then(function() {
        return delDetail(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/detail/export', {
        ...this.queryParams
      }, `detail_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
