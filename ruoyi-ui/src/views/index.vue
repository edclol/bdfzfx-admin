<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :span="24">
        <el-card class="welcome-card">
          <div slot="header" class="clearfix">
            <span>系统首页</span>
          </div>
          <div class="welcome-content">
            <h2>欢迎使用管理系统</h2>
            <p>这是一个基于现代前端技术构建的管理系统，为您提供高效、便捷的管理体验。</p>
            <p>系统采用前后端分离架构，具有良好的可扩展性和维护性。</p>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :span="8">
        <el-card class="info-card">
          <div class="card-icon">
            <i class="el-icon-user"></i>
          </div>
          <div class="card-content">
            <h4>用户管理</h4>
            <p>管理系统的核心功能之一，支持用户信息的增删改查操作。</p>
          </div>
        </el-card>
      </el-col>

      <el-col :span="8">
        <el-card class="info-card">
          <div class="card-icon">
            <i class="el-icon-setting"></i>
          </div>
          <div class="card-content">
            <h4>系统配置</h4>
            <p>提供系统参数配置功能，可根据业务需求灵活调整系统行为。</p>
          </div>
        </el-card>
      </el-col>

      <el-col :span="8">
        <el-card class="info-card">
          <div class="card-icon">
            <i class="el-icon-data-line"></i>
          </div>
          <div class="card-content">
            <h4>数据统计</h4>
            <p>提供各类业务数据的统计分析功能，帮助您更好地了解业务状况。</p>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :span="24">
        <el-card>
          <div slot="header" class="clearfix">
            <span>系统信息</span>
          </div>
          <div class="system-info">
            <p><b>当前版本：</b> v{{ version }}</p>
            <p><b>技术支持：</b> 请查看相关文档获取帮助信息</p>
            <p><b>更新时间：</b> {{ new Date().getFullYear() }}年{{ new Date().getMonth() + 1 }}月</p>
          </div>
        </el-card>
      </el-col>
    </el-row>

  </div>
</template>

<script>
export default {
  name: "Index",
  data() {
    return {
      // 版本号
      version: "0.1.0"
    }
  },
  methods: {
    goTarget(href) {
      window.open(href, "_blank")
    }
  }
}
</script>

<style scoped lang="scss">
.home {
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}
</style>

