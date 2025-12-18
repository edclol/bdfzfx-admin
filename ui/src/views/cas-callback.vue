<template>
  <div class="cas-callback">
    <div class="callback-container">
      <!-- Logo -->
      <div class="logo-section">
        <div class="logo">
          <svg-icon icon-class="logo" class="logo-icon" />
        </div>
        <h1 class="system-name">{{ title }}</h1>
        <p class="system-desc">统一身份认证服务</p>
      </div>

      <!-- 主内容区 -->
      <div class="main-content">
        <!-- 加载状态 -->
        <div class="loading-state" v-if="!errorMsg && !loginSuccess">
          <!-- 加载动画 -->
          <div class="loading-animation">
            <el-spinner size="large" type="pulse" color="#409EFF" />
          </div>

          <!-- 加载文本 -->
          <div class="loading-text">
            <h3 class="loading-title">正在处理SSO登录</h3>
            <p class="loading-subtitle">请稍候，正在为您验证身份...</p>
          </div>

          <!-- 进度指示器 -->
          <div class="progress-steps">
            <div class="step-item active">
              <div class="step-icon">1</div>
              <div class="step-text">验证身份</div>
            </div>
            <div class="step-item">
              <div class="step-icon">2</div>
              <div class="step-text">生成令牌</div>
            </div>
            <div class="step-item">
              <div class="step-icon">3</div>
              <div class="step-text">跳转系统</div>
            </div>
          </div>

          <!-- 提示信息 -->
          <div class="tips">
            <el-icon class="el-icon-info"></el-icon>
            <span>如果页面长时间无响应，请刷新页面或联系管理员</span>
          </div>
        </div>

        <!-- 错误状态 -->
        <div class="error-state" v-else-if="errorMsg && !loginSuccess">
          <el-icon class="error-icon">circle-close</el-icon>
          <h3 class="error-title">登录失败</h3>
          <p class="error-message">{{ errorMsg }}</p>
          <el-button type="primary" @click="handleRetry" class="retry-btn">
            重新尝试
          </el-button>
        </div>

        <!-- 成功状态 -->
        <div class="success-state" v-else-if="loginSuccess">
          <el-icon class="success-icon">circle-check</el-icon>
          <h3 class="success-title">登录成功</h3>
          <p class="success-message">正在跳转到系统...</p>
        </div>
      </div>

      <!-- 页脚 -->
      <div class="footer">
        <p>{{ footerContent }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import { setToken } from '@/utils/auth'
import request from '@/utils/request'
import settings from '@/settings'

export default {
  name: 'CasCallback',
  data() {
    return {
      title: settings.title,
      footerContent: settings.footerContent,
      errorMsg: '',
      loginSuccess: false
    }
  },
  created() {
    this.handleCallback()
  },
  methods: {
    handleCallback() {
      // 从URL中获取ticket参数
      const urlParams = new URLSearchParams(window.location.search)
      const ticket = urlParams.get('ticket')

      if (ticket) {
        // 调用后端API获取token，增加超时时间到30秒
        request({
          url: '/isc/callback',
          method: 'get',
          params: {
            ticket: ticket
          },
          headers: {
            isToken: false
          },
          timeout: 30000 // 增加超时时间到30秒
        }).then(response => {
          if (response.code === 200 && response.token) {
            // 标记登录成功
            this.loginSuccess = true
            // 保存token
            setToken(response.token)
            // 跳转到首页
            window.location.href = '/'
          } else {
            this.errorMsg = 'SSO登录失败：' + (response.msg || '未知错误')
          }
        }).catch(error => {
          console.error('SSO登录API调用失败：', error)
          // 改进错误信息
          if (error.code === 'ECONNABORTED') {
            this.errorMsg = 'SSO登录失败：请求超时，请检查网络连接或重试'
          } else if (error.response) {
            this.errorMsg = `SSO登录失败：服务器返回错误 (${error.response.status})`
          } else if (error.request) {
            this.errorMsg = 'SSO登录失败：无法连接到服务器，请检查网络'
          } else {
            this.errorMsg = 'SSO登录失败：' + error.message
          }
        })
      } else {
        this.errorMsg = 'SSO登录失败：未获取到ticket参数'
      }
    },
    handleRetry() {
      // 重置错误信息，重新尝试
      this.errorMsg = ''
      this.handleCallback()
    }
  }
}
</script>

<style scoped>
/* 全局样式 */
.cas-callback {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  padding: 20px;
}

/* 主容器 */
.callback-container {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 16px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
  padding: 40px;
  max-width: 480px;
  width: 100%;
  text-align: center;
  backdrop-filter: blur(10px);
}

/* Logo区域 */
.logo-section {
  margin-bottom: 35px;
}

.logo {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 15px;
}

.logo-icon {
  font-size: 64px;
  color: #409EFF;
  filter: drop-shadow(0 2px 8px rgba(64, 158, 255, 0.3));
}

.system-name {
  font-size: 28px;
  font-weight: 600;
  color: #303133;
  margin: 0 0 8px 0;
}

.system-desc {
  font-size: 14px;
  color: #606266;
  margin: 0;
}

/* 主内容区 */
.main-content {
  margin-bottom: 30px;
}

/* 加载状态 */
.loading-state {
  padding: 20px 0;
}

.loading-animation {
  margin-bottom: 25px;
}

.loading-text {
  margin-bottom: 30px;
}

.loading-title {
  font-size: 22px;
  font-weight: 500;
  color: #303133;
  margin: 0 0 8px 0;
}

.loading-subtitle {
  font-size: 14px;
  color: #909399;
  margin: 0;
}

/* 进度指示器 */
.progress-steps {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  padding: 0 10px;
}

.step-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  flex: 1;
  position: relative;
}

.step-item::before {
  content: '';
  position: absolute;
  top: 20px;
  left: 50%;
  width: calc(100% + 20px);
  height: 2px;
  background: #e4e7ed;
  z-index: 1;
}

.step-item:last-child::before {
  display: none;
}

.step-item.active::before {
  background: #409EFF;
}

.step-icon {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #e4e7ed;
  color: #909399;
  display: flex;
  justify-content: center;
  align-items: center;
  font-weight: 600;
  font-size: 16px;
  position: relative;
  z-index: 2;
  transition: all 0.3s ease;
}

.step-item.active .step-icon {
  background: #409EFF;
  color: #fff;
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.4);
}

.step-text {
  margin-top: 8px;
  font-size: 13px;
  color: #909399;
  transition: all 0.3s ease;
}

.step-item.active .step-text {
  color: #409EFF;
  font-weight: 500;
}

/* 提示信息 */
.tips {
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  color: #909399;
  background: #f5f7fa;
  padding: 12px 20px;
  border-radius: 8px;
  border: 1px solid #ebeef5;
}

.tips .el-icon {
  margin-right: 6px;
  font-size: 14px;
}

/* 错误状态 */
.error-state {
  padding: 30px 0;
}

.error-icon {
  font-size: 64px;
  color: #f56c6c;
  margin-bottom: 15px;
}

.error-title {
  font-size: 22px;
  font-weight: 500;
  color: #f56c6c;
  margin: 0 0 10px 0;
}

.error-message {
  font-size: 14px;
  color: #606266;
  margin: 0 0 20px 0;
  line-height: 1.6;
}

.retry-btn {
  width: 100%;
  padding: 10px;
  font-size: 15px;
}

/* 成功状态 */
.success-state {
  padding: 30px 0;
}

.success-icon {
  font-size: 64px;
  color: #67c23a;
  margin-bottom: 15px;
}

.success-title {
  font-size: 22px;
  font-weight: 500;
  color: #67c23a;
  margin: 0 0 10px 0;
}

.success-message {
  font-size: 14px;
  color: #606266;
  margin: 0 0 20px 0;
  line-height: 1.6;
}

/* 页脚 */
.footer {
  text-align: center;
  font-size: 12px;
  color: #909399;
  border-top: 1px solid #ebeef5;
  padding-top: 20px;
}

/* 响应式设计 */
@media (max-width: 576px) {
  .callback-container {
    padding: 30px 20px;
    margin: 0 15px;
  }

  .system-name {
    font-size: 24px;
  }

  .loading-title {
    font-size: 20px;
  }

  .progress-steps {
    padding: 0;
  }

  .step-item::before {
    width: calc(100% + 10px);
  }

  .tips {
    font-size: 12px;
    padding: 10px 15px;
  }
}
</style>