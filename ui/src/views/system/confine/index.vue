<template>
  <div class="app-container">
    <!-- 限流配置卡片 -->
    <el-card class="box-card" style="margin-bottom: 20px;">
      <div slot="header" class="clearfix">
        <span>限流配置管理</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="refreshStatus">刷新状态</el-button>
      </div>
      
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form ref="confineForm" :model="confineForm" :rules="confineRules" label-width="120px">
            <el-form-item label="每分钟请求数限制" prop="requestsPerMinute">
              <el-input
                v-model.number="confineForm.requestsPerMinute"
                placeholder="请输入每分钟最大请求数"
                type="number"
                min="1"
                max="10000"
                style="width: 200px"
              >
                <template slot="append">次/分钟</template>
              </el-input>
            </el-form-item>
            
            <el-form-item label="每小时请求数限制" prop="requestsPerHour">
              <el-input
                v-model.number="confineForm.requestsPerHour"
                placeholder="请输入每小时最大请求数"
                type="number"
                min="1"
                max="100000"
                style="width: 200px"
              >
                <template slot="append">次/小时</template>
              </el-input>
            </el-form-item>
            
            <el-form-item label="滑动窗口大小" prop="windowSize">
              <el-select v-model="confineForm.windowSize" placeholder="请选择滑动窗口大小" style="width: 200px">
                <el-option label="1分钟" value="1"></el-option>
                <el-option label="5分钟" value="5"></el-option>
                <el-option label="10分钟" value="10"></el-option>
                <el-option label="30分钟" value="30"></el-option>
                <el-option label="1小时" value="60"></el-option>
              </el-select>
            </el-form-item>
            
            <el-form-item label="限流状态" prop="enabled">
              <el-switch
                v-model="confineForm.enabled"
                active-text="启用"
                inactive-text="禁用"
              ></el-switch>
            </el-form-item>
            
            <el-form-item>
              <el-button type="primary" @click="handleSaveConfine" :loading="saveLoading">确认配置</el-button>
              <el-button @click="resetForm">重置</el-button>
              <el-button type="danger" @click="clearAllData">清空所有数据</el-button>
            </el-form-item>
          </el-form>
        </el-col>
        
        <el-col :span="12">
          <div class="status-panel">
            <h4>当前状态</h4>
            <el-descriptions :column="1" border>
              <el-descriptions-item label="限流状态">
                <el-tag :type="currentStatus.enabled ? 'success' : 'danger'">
                  {{ currentStatus.enabled ? '已启用' : '已禁用' }}
                </el-tag>
              </el-descriptions-item>
              <el-descriptions-item label="每分钟限制">
                {{ currentStatus.requestsPerMinute || '未设置' }} 次
              </el-descriptions-item>
              <el-descriptions-item label="每小时限制">
                {{ currentStatus.requestsPerHour || '未设置' }} 次
              </el-descriptions-item>
              <el-descriptions-item label="滑动窗口">
                {{ currentStatus.windowSize || '未设置' }} 分钟
              </el-descriptions-item>
              <el-descriptions-item label="当前分钟请求数">
                <el-tag :type="getRequestCountType(currentStatus.currentMinuteRequests, currentStatus.requestsPerMinute)">
                  {{ currentStatus.currentMinuteRequests || 0 }} / {{ currentStatus.requestsPerMinute || '∞' }}
                </el-tag>
              </el-descriptions-item>
              <el-descriptions-item label="当前小时请求数">
                <el-tag :type="getRequestCountType(currentStatus.currentHourRequests, currentStatus.requestsPerHour)">
                  {{ currentStatus.currentHourRequests || 0 }} / {{ currentStatus.requestsPerHour || '∞' }}
                </el-tag>
              </el-descriptions-item>
            </el-descriptions>
          </div>
        </el-col>
      </el-row>
    </el-card>

  </div>
</template>

<script>
export default {
  name: "Confine",
  data() {
    return {
      // 遮罩层
      loading: false,
      saveLoading: false,
      // 总条数
      total: 0,
      // 限流记录表格数据
      confineList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        ipAddress: null,
        confineType: null
      },
      // 限流配置表单
      confineForm: {
        requestsPerMinute: 100,
        requestsPerHour: 1000,
        windowSize: '1',
        enabled: true
      },
      // 表单验证规则
      confineRules: {
        requestsPerMinute: [
          { required: true, message: "请输入每分钟请求数限制", trigger: "blur" },
          { type: 'number', min: 1, max: 10000, message: "每分钟请求数限制必须在1-10000之间", trigger: "blur" }
        ],
        requestsPerHour: [
          { required: true, message: "请输入每小时请求数限制", trigger: "blur" },
          { type: 'number', min: 1, max: 100000, message: "每小时请求数限制必须在1-100000之间", trigger: "blur" }
        ],
        windowSize: [
          { required: true, message: "请选择滑动窗口大小", trigger: "change" }
        ]
      },
      // 当前状态
      currentStatus: {
        enabled: true,
        requestsPerMinute: 100,
        requestsPerHour: 1000,
        windowSize: 1,
        currentMinuteRequests: 0,
        currentHourRequests: 0
      }
    };
  },
  created() {
    this.loadDataFromStorage();
    this.getList();
    this.getCurrentStatus();
    // 模拟定时更新请求数量
    this.startRequestSimulation();
  },
  beforeDestroy() {
    // 清理定时器
    if (this.requestTimer) {
      clearInterval(this.requestTimer);
    }
  },
  methods: {
    /** 从localStorage加载数据 */
    loadDataFromStorage() {
      try {
        // 加载配置数据
        const savedConfig = localStorage.getItem('confine_config');
        if (savedConfig) {
          const config = JSON.parse(savedConfig);
          this.confineForm = { ...this.confineForm, ...config };
        }

        // 加载状态数据
        const savedStatus = localStorage.getItem('confine_status');
        if (savedStatus) {
          const status = JSON.parse(savedStatus);
          this.currentStatus = { ...this.currentStatus, ...status };
        }
      } catch (error) {
        console.error('加载localStorage数据失败:', error);
      }
    },

    /** 保存数据到localStorage */
    saveDataToStorage() {
      try {
        // 保存配置数据
        localStorage.setItem('confine_config', JSON.stringify(this.confineForm));
        
        // 保存状态数据
        localStorage.setItem('confine_status', JSON.stringify(this.currentStatus));
        
        // 保存记录数据
        localStorage.setItem('confine_records', JSON.stringify(this.confineList));
      } catch (error) {
        console.error('保存localStorage数据失败:', error);
      }
    },

    /** 查询限流记录列表 */
    getList() {
      this.loading = true;
      
      try {
        // 从localStorage加载记录数据
        const savedRecords = localStorage.getItem('confine_records');
        if (savedRecords) {
          this.confineList = JSON.parse(savedRecords);
        } else {
          // 如果没有保存的记录，使用默认模拟数据
          this.confineList = this.getDefaultRecords();
        }
        
        this.total = this.confineList.length;
        this.loading = false;
      } catch (error) {
        console.error('加载记录数据失败:', error);
        this.confineList = this.getDefaultRecords();
        this.total = this.confineList.length;
        this.loading = false;
      }
    },

    /** 获取默认记录数据 */
    getDefaultRecords() {
      return [
        {
          recordId: 1,
          userId: 1,
          userName: 'admin',
          ipAddress: '192.168.1.100',
          requestPath: '/api/system/user/list',
          requestTime: new Date(),
          confineType: 'MINUTE',
          status: 'PASS'
        },
        {
          recordId: 2,
          userId: 2,
          userName: 'test',
          ipAddress: '192.168.1.101',
          requestPath: '/api/system/role/list',
          requestTime: new Date(Date.now() - 60000),
          confineType: 'HOUR',
          status: 'BLOCKED'
        }
      ];
    },

    /** 获取当前限流状态 */
    getCurrentStatus() {
      // 从配置表单更新状态
      this.currentStatus = {
        enabled: this.confineForm.enabled,
        requestsPerMinute: this.confineForm.requestsPerMinute,
        requestsPerHour: this.confineForm.requestsPerHour,
        windowSize: parseInt(this.confineForm.windowSize),
        currentMinuteRequests: this.currentStatus.currentMinuteRequests,
        currentHourRequests: this.currentStatus.currentHourRequests
      };
    },

    /** 开始请求数量模拟 */
    startRequestSimulation() {
      this.requestTimer = setInterval(() => {
        // 模拟随机增加请求数量
        const minuteIncrease = Math.floor(Math.random() * 5);
        const hourIncrease = Math.floor(Math.random() * 20);
        
        this.currentStatus.currentMinuteRequests += minuteIncrease;
        this.currentStatus.currentHourRequests += hourIncrease;
        
        // 每分钟重置分钟请求数
        if (new Date().getSeconds() === 0) {
          this.currentStatus.currentMinuteRequests = 0;
        }
        
        // 每小时重置小时请求数
        if (new Date().getMinutes() === 0 && new Date().getSeconds() === 0) {
          this.currentStatus.currentHourRequests = 0;
        }
        
        // 保存到localStorage
        this.saveDataToStorage();
      }, 5000); // 每5秒更新一次
    },

    /** 刷新状态 */
    refreshStatus() {
      this.getCurrentStatus();
      this.$message.success("状态已刷新");
    },

    /** 保存限流配置 */
    handleSaveConfine() {
      this.$refs["confineForm"].validate(valid => {
        if (valid) {
          this.saveLoading = true;
          const data = {
            requestsPerMinute: this.confineForm.requestsPerMinute,
            requestsPerHour: this.confineForm.requestsPerHour,
            windowSize: parseInt(this.confineForm.windowSize),
            enabled: this.confineForm.enabled
          };
          
          // 更新状态
          this.currentStatus = {
            enabled: data.enabled,
            requestsPerMinute: data.requestsPerMinute,
            requestsPerHour: data.requestsPerHour,
            windowSize: data.windowSize,
            currentMinuteRequests: this.currentStatus.currentMinuteRequests,
            currentHourRequests: this.currentStatus.currentHourRequests
          };
          
          // 保存到localStorage
          this.saveDataToStorage();
          
          this.$modal.msgSuccess("配置保存成功");
          this.saveLoading = false;
        }
      });
    },

    /** 重置表单 */
    resetForm() {
      this.$refs["confineForm"].resetFields();
      this.confineForm = {
        requestsPerMinute: 100,
        requestsPerHour: 1000,
        windowSize: '1',
        enabled: true
      };
      this.getCurrentStatus();
      this.saveDataToStorage();
    },

    /** 清空所有数据 */
    clearAllData() {
      this.$confirm('确定要清空所有限流数据吗？此操作不可恢复！', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 清空localStorage
        localStorage.removeItem('confine_config');
        localStorage.removeItem('confine_status');
        localStorage.removeItem('confine_records');
        
        // 重置数据
        this.confineForm = {
          requestsPerMinute: 100,
          requestsPerHour: 1000,
          windowSize: '1',
          enabled: true
        };
        
        this.currentStatus = {
          enabled: true,
          requestsPerMinute: 100,
          requestsPerHour: 1000,
          windowSize: 1,
          currentMinuteRequests: 0,
          currentHourRequests: 0
        };
        
        this.confineList = [];
        this.total = 0;
        
        this.$message.success("所有数据已清空");
      }).catch(() => {
        this.$message.info("已取消清空操作");
      });
    },

    /** 查询按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },

    /** 获取请求数量标签类型 */
    getRequestCountType(current, limit) {
      if (!limit) return 'info';
      const ratio = current / limit;
      if (ratio >= 0.9) return 'danger';
      if (ratio >= 0.7) return 'warning';
      return 'success';
    }
  }
};
</script>

<style scoped>
.status-panel {
  padding: 10px;
  background-color: #f8f9fa;
  border-radius: 4px;
}

.status-panel h4 {
  margin-top: 0;
  margin-bottom: 15px;
  color: #303133;
}

.box-card {
  margin-bottom: 20px;
}

.el-descriptions {
  margin-top: 10px;
}
</style>
