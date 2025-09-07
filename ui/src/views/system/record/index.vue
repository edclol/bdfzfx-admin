<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="训练日期">
        <el-date-picker
          v-model="daterangeTrainDate"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="版本号" prop="workflowVersion" label-width="20">
        <el-input
          v-model="queryParams.workflowVersion"
          placeholder="请输入版本号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
<!--      <el-form-item label="训练结果" prop="result">-->
<!--        <el-input-->
<!--          v-model="queryParams.result"-->
<!--          placeholder="请输入训练结果"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <!-- <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:record:add']"
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
          v-hasPermi="['system:record:edit']"
        >修改</el-button>
      </el-col> -->
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:record:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:record:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="recordList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="序号" align="center" prop="id" />
<!--      <el-table-column label="训练日期" align="center" prop="trainDate" width="180">-->
<!--        <template slot-scope="scope">-->
<!--          <span>{{ parseTime(scope.row.trainDate, '{y}-{m}-{d}') }}</span>-->
<!--        </template>-->
<!--      </el-table-column>-->
      <el-table-column label="版本号" align="center" prop="workflowVersion" />
      <el-table-column label="训练结果" align="center" prop="result" />
      <el-table-column label="GPU数量" align="center" prop="gpuCount" />
      <el-table-column label="初始化模型参数" align="center" prop="initModelParams" />
      <el-table-column label="执行训练过程" align="center" prop="executionProcess" />
      <el-table-column label="损失函数的变化数据" align="center" prop="lossCurveData" />
      <el-table-column label="备注信息" align="center" prop="remark" />
     <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            @click="openReport(scope.row)"
          >评估报告</el-button>
        </template>
<!--        <template slot-scope="scope">-->
<!--          <el-button-->
<!--            size="mini"-->
<!--            type="text"-->
<!--            icon="el-icon-edit"-->
<!--            @click="handleUpdate(scope.row)"-->
<!--            v-hasPermi="['system:record:edit']"-->
<!--          >修改</el-button>-->
<!--          <el-button-->
<!--            size="mini"-->
<!--            type="text"-->
<!--            icon="el-icon-delete"-->
<!--            @click="handleDelete(scope.row)"-->
<!--            v-hasPermi="['system:record:remove']"-->
<!--          >删除</el-button>-->
<!--        </template>-->
     </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改模型训练记录对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="训练日期" prop="trainDate">
          <el-date-picker clearable
            v-model="form.trainDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择训练日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="版本号" prop="workflowVersion">
          <el-input v-model="form.workflowVersion" placeholder="请输入版本号" />
        </el-form-item>
        <el-form-item label="训练结果" prop="result">
          <el-input v-model="form.result" placeholder="请输入训练结果" />
        </el-form-item>
        <el-form-item label="GPU数量" prop="gpuCount">
          <el-input v-model="form.gpuCount" placeholder="请输入GPU数量" />
        </el-form-item>
        <el-form-item label="初始化模型参数" prop="initModelParams">
          <el-input v-model="form.initModelParams" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="执行训练过程" prop="executionProcess">
          <el-input v-model="form.executionProcess" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="损失函数的变化数据" prop="lossCurveData">
          <el-input v-model="form.lossCurveData" type="textarea" placeholder="请输入内容" />
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
      <!-- 评估报告对话框 -->
      <el-dialog title="评估报告" :visible.sync="reportOpen" width="900px" append-to-body>
      <div class="evaluation-report">
        <div class="chart-container">
          <div class="chart-item">
            <h4>损失曲线 (Loss Curve)</h4>
            <div class="image-container">
              <img :src="lossCurveSrc" alt="Loss Curve" class="chart-image" />
            </div>
          </div>
          <div class="chart-item">
            <h4>训练曲线 (Train Curve)</h4>
            <div class="image-container">
              <img :src="trainCurveSrc" alt="Train Curve" class="chart-image" />
            </div>
          </div>
        </div>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" icon="el-icon-download" @click="downloadEvaluationReport">下载</el-button>
        <el-button @click="reportOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listRecord, getRecord, delRecord, addRecord, updateRecord } from "@/api/system/record"

export default {
  name: "Record",
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
      // 模型训练记录表格数据
      recordList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 备注信息时间范围
      daterangeTrainDate: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        trainDate: null,
        workflowVersion: null,
        result: null,
      },
      reportOpen: false,
      // 评估报告图片路径
      lossCurveSrc: require('../model/loss_curve.png'),
      trainCurveSrc: require('../model/train_curve.png'),
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        trainDate: [
          { required: true, message: "训练日期不能为空", trigger: "blur" }
        ],
        workflowVersion: [
          { required: true, message: "版本号不能为空", trigger: "blur" }
        ],
        result: [
          { required: true, message: "训练结果不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询模型训练记录列表 */
    getList() {
      this.loading = true
      this.queryParams.params = {}
      if (null != this.daterangeTrainDate && '' != this.daterangeTrainDate) {
        this.queryParams.params["beginTrainDate"] = this.daterangeTrainDate[0]
        this.queryParams.params["endTrainDate"] = this.daterangeTrainDate[1]
      }
      listRecord(this.queryParams).then(response => {
        this.recordList = response.rows
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
        trainDate: null,
        workflowVersion: null,
        result: null,
        gpuCount: null,
        initModelParams: null,
        executionProcess: null,
        lossCurveData: null,
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
    // 打开评估报告
    openReport() {
      this.reportOpen = true
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.daterangeTrainDate = []
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
      this.title = "添加模型训练记录"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getRecord(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改模型训练记录"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateRecord(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addRecord(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除模型训练记录编号为"' + ids + '"的数据项？').then(function() {
        return delRecord(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/record/export', {
        ...this.queryParams
      }, `record_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
<style scoped>
/* 评估报告样式 */
.evaluation-report {
  padding: 20px 0;
}

.chart-container {
  display: flex;
  gap: 30px;
}

.chart-item {
  border: 1px solid #ebeef5;
  border-radius: 8px;
  padding: 20px;
  background: #fafafa;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.chart-item h4 {
  margin: 0 0 15px 0;
  color: #303133;
  font-size: 16px;
  font-weight: 600;
}

.image-container {
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 6px;
  overflow: hidden;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  flex: 1;
  min-height: 300px;
}

.chart-image {
  width: 100%;
  height: 300px;
  object-fit: contain;
  display: block;
}
</style>