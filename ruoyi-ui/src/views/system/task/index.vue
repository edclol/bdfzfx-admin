<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryForm"
      size="small"
      :inline="true"
      v-show="showSearch"
      label-width="120px"
    >
      <el-form-item label="任务ID" prop="taskId">
        <el-input
          v-model="queryParams.taskId"
          placeholder="请输入任务ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="任务名称" prop="taskName">
        <el-input
          v-model="queryParams.taskName"
          placeholder="请输入任务名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="样本总数" prop="sampleCount">
        <el-input
          v-model="queryParams.sampleCount"
          placeholder="请输入样本总数"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="已完成标注数量" prop="completedCount">
        <el-input
          v-model="queryParams.completedCount"
          placeholder="请输入已完成标注数量"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="处理人姓名" prop="handler">
        <el-input
          v-model="queryParams.handler"
          placeholder="请输入处理人姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button
          type="primary"
          icon="el-icon-search"
          size="mini"
          @click="handleQuery"
          >搜索</el-button
        >
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery"
          >重置</el-button
        >
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
          >创建标注任务</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleExport"
          >导出</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="openStats"
          >数据统计</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-magic-stick"
          size="mini"
          @click="handleTokenize"
          >一键分词</el-button
        >
      </el-col>
      <right-toolbar
        :showSearch.sync="showSearch"
        @queryTable="getList"
        :columns="columns"
      ></right-toolbar>
    </el-row>

    <el-table
      v-loading="loading"
      :data="taskList"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column
        label="任务ID"
        width="100"
        align="center"
        prop="taskId"
      />
      <el-table-column label="任务名称" align="center" prop="taskName" />
      <el-table-column label="样本总数" align="center" prop="sampleCount" />
      <el-table-column
        label="已完成标注数量"
        align="center"
        prop="completedCount"
      />
      <el-table-column label="处理人姓名" align="center" prop="handler" />
      <el-table-column label="任务状态" align="center" prop="status">
        <template slot-scope="scope">
          <div v-if="scope.row.status == 0">待标注</div>
          <div v-else-if="scope.row.status == 1">进行中</div>
          <div v-else-if="scope.row.status == 2">已完成</div>
          <div v-else-if="scope.row.status == 3">已回收</div>
        </template>
      </el-table-column>
      <el-table-column label="备注信息" align="center" prop="remark" />
      <!-- <el-table-column label="标注结果" align="center">
        <template slot-scope="scope">
          <el-tag
            v-if="labelResults[scope.row.taskId]"
            :type="labelResults[scope.row.taskId].type === 'correct' ? 'success' : 'danger'"
            disable-transitions
          >
            {{ labelResults[scope.row.taskId].type === 'correct' ? '标注正确' : '异常上报' }}
          </el-tag>
        </template>
      </el-table-column> -->
      <el-table-column
        label="操作"
        align="center"
        class-name="small-padding fixed-width"
      >
        <template slot-scope="scope">
          <el-button
            type="text"
            size="mini"
            v-if="scope.row.status == 0"
            @click="handleStart(scope.row)"
            >开始标注</el-button
          >
          <el-button
            type="text"
            size="mini"
            v-if="scope.row.status == 1"
            @click="handleContinue(scope.row)"
            >继续标注</el-button
          >
          <el-button
            type="text"
            size="mini"
            v-if="scope.row.status == 2"
            @click="handleRecycle(scope.row)"
            >回收</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改样本标注任务对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
    
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
    <!-- 开始/继续标注对话框 -->
    <el-dialog title="标注" :visible.sync="startOpen" width="500px" append-to-body>
      <el-form label-width="100px">
        <el-form-item label="标注选项">
          <el-radio-group v-model="labelChoice">
            <el-radio label="correct">标注正确</el-radio>
            <el-radio label="exception">异常上报</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="异常说明" v-if="labelChoice === 'exception'">
          <el-input
            type="textarea"
            :rows="3"
            v-model="exceptionRemark"
            placeholder="请输入异常说明"
          />
        </el-form-item>
        <el-form-item v-if="labelChoice !== 'exception'">
          <el-alert title="将标记为：标注正确" type="success" :closable="false" />
        </el-form-item>
        <el-form-item v-else>
          <el-alert title="将标记为：异常上报" type="error" :closable="false" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmLabel">完 成</el-button>
        <el-button @click="startOpen = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 一键分词对话框 -->
    <el-dialog title="一键分词" :visible.sync="tokenizeOpen" width="600px" append-to-body>
      <el-form label-width="80px">
        <el-form-item label="输入文本">
          <el-input
            type="textarea"
            :rows="5"
            v-model="tokenizeInput"
            placeholder="请输入待分词的文本"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-scissors" @click="tokenizeNow">分 词</el-button>
          <el-button @click="tokenizeInput = ''; tokenizeResult = []">清 空</el-button>
        </el-form-item>
        <el-form-item label="分词结果" v-if="tokenizeResult && tokenizeResult.length">
          <div>
            <el-tag
              v-for="(tk, idx) in tokenizeResult"
              :key="idx"
              type="info"
              class="mr4 mb4"
            >{{ tk }}</el-tag>
          </div>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="tokenizeOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
    
    <!-- 数据统计对话框 -->
    <el-dialog title="数据统计" :visible.sync="statsOpen" width="640px" append-to-body @closed="onStatsDialogClosed">
      <div ref="statsChart" style="width: 100%; height: 360px;"></div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="statsOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  listTask,
  getTask,
  delTask,
  addTask,
  updateTask,
} from "@/api/system/task";

export default {
  name: "Task",
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
      // 样本标注任务表格数据
      taskList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      synonymOpen: false,
      open: false,
      // 开始/继续标注弹窗
      startOpen: false,
      currentTaskId: null,
      labelChoice: 'correct', // 'correct' | 'exception'
      exceptionRemark: '',
      // 标注结果映射
      labelResults: {},
      // 一键分词
      tokenizeOpen: false,
      tokenizeInput: '',
      tokenizeResult: [],
      // 数据统计
      statsOpen: false,
      statsChartInstance: null,
      // 右侧工具栏列配置（占位，避免未定义报错）
      columns: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        taskId: null,
        taskName: null,
        sampleCount: null,
        completedCount: null,
        handler: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        taskName: [
          { required: true, message: "任务名称不能为空", trigger: "blur" },
        ],
        status: [
          { required: true, message: "任务状态不能为空", trigger: "change" },
        ],
      },
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询样本标注任务列表 */
    getList() {
      this.loading = true;
      listTask(this.queryParams).then((response) => {
        this.taskList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        taskId: null,
        taskName: null,
        sampleCount: null,
        completedCount: null,
        handler: null,
        status: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null,
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map((item) => item.taskId);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加样本标注任务";
    },
    /** 修改按钮操作 */
    handleStart(row) {
      this.currentTaskId = row.taskId;
      this.labelChoice = 'correct';
      this.exceptionRemark = '';
      this.startOpen = true;
    },
    handleContinue(row) {
      this.currentTaskId = row.taskId;
      this.labelChoice = 'correct';
      this.exceptionRemark = '';
      this.startOpen = true;
    },
    handleRecycle(row) {
      this.$modal.confirm('是否确认回收样本标注任务编号为"' + row.taskId + '"的数据项？').then(function() {
          
          this.$modal.msgSuccess("回收成功")
        }).catch(() => {})
    },
    // 打开一键分词弹窗
    handleTokenize() {
      this.tokenizeOpen = true;
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          if (this.form.taskId != null) {
            updateTask(this.form).then((response) => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addTask(this.form).then((response) => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    // 简易前端分词逻辑（演示用）
    tokenizeNow() {
      const text = (this.tokenizeInput || '').trim();
      if (!text) {
        this.tokenizeResult = [];
        return;
      }
      // 规则：
      // - 连续的英文字母/数字作为一个词
      // - 中文字符逐字分开（去除空白和常见标点）
      // - 其它空白或标点作为分隔
      const tokens = [];
      let buffer = '';
      const flushBuffer = () => {
        if (buffer) {
          tokens.push(buffer);
          buffer = '';
        }
      };
      for (let i = 0; i < text.length; i++) {
        const ch = text[i];
        if (/^[A-Za-z0-9_]$/.test(ch)) {
          buffer += ch;
          continue;
        }
        flushBuffer();
        // 中文字符范围（基本区）
        if (/^[\u4e00-\u9fa5]$/.test(ch)) {
          tokens.push(ch);
          continue;
        }
        // 其它符号/空白作为分隔，忽略
      }
      flushBuffer();
      this.tokenizeResult = tokens;
    },
    // 打开数据统计并渲染饼图
    openStats() {
      this.statsOpen = true;
      this.$nextTick(() => {
        this.initStatsChart();
      });
    },
    async initStatsChart() {
      if (!this.$refs.statsChart) return;
      if (this.statsChartInstance) {
        this.statsChartInstance.dispose();
        this.statsChartInstance = null;
      }
      const echartsModule = await import('echarts');
      const echarts = echartsModule && (echartsModule.default || echartsModule);
      if (!echarts || !echarts.init) {
        this.$message.error('图表库加载失败');
        return;
      }
      this.statsChartInstance = echarts.init(this.$refs.statsChart);
      const data = [
        { name: '已标注', value: 91 },
        { name: '未标注', value: 5 },
        { name: '存疑', value: 4 },
      ];
      const option = {
        tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
        legend: { bottom: 0, left: 'center' },
        series: [
          {
            name: '标注情况',
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            label: { show: true, formatter: '{b}\n{d}%' },
            labelLine: { show: true },
            data,
          },
        ],
      };
      this.statsChartInstance.setOption(option);
      window.addEventListener('resize', this.resizeStatsChart, { passive: true });
    },
    resizeStatsChart() {
      if (this.statsChartInstance) {
        this.statsChartInstance.resize();
      }
    },
    onStatsDialogClosed() {
      window.removeEventListener('resize', this.resizeStatsChart);
      if (this.statsChartInstance) {
        this.statsChartInstance.dispose();
        this.statsChartInstance = null;
      }
    },
    // 确认标注
    confirmLabel() {
      if (!this.currentTaskId) {
        this.startOpen = false;
        return;
      }
      const resultType = this.labelChoice === 'exception' ? 'exception' : 'correct';
      this.$set(this.labelResults, this.currentTaskId, {
        type: resultType,
        remark: this.exceptionRemark || ''
      });
      this.startOpen = false;
      if (resultType === 'correct') {
        this.$message.success('已标记为：标注正确');
      } else {
        this.$message.error('已标记为：异常上报');
      }
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const taskIds = row.taskId || this.ids;
      this.$modal
        .confirm('是否确认删除样本标注任务编号为"' + taskIds + '"的数据项？')
        .then(function () {
          return delTask(taskIds);
        })
        .then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        })
        .catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download(
        "system/task/export",
        {
          ...this.queryParams,
        },
        `task_${new Date().getTime()}.xlsx`
      );
    },
  },
};
</script>
