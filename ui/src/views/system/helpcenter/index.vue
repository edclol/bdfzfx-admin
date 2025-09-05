<template>
  <div class="app-container">
    <div class="help-center">
      <!-- 页面标题 -->
      <div class="page-header">
        <h1 class="page-title">
          <i class="el-icon-question"></i>
          帮助中心
        </h1>
        <p class="page-subtitle">为您提供系统使用指南和技术支持</p>
      </div>

      <!-- 搜索框 -->
      <div class="search-section">
        <el-input
          v-model="searchKeyword"
          placeholder="搜索帮助内容..."
          prefix-icon="el-icon-search"
          clearable
          @input="handleSearch"
          style="max-width: 400px;"
        />
      </div>

      <!-- 帮助内容卡片 -->
      <div class="help-content">
        <!-- 新一代变电站集中监控系统 -->
        <el-card class="help-card" shadow="hover">
          <div slot="header" class="card-header">
            <i class="el-icon-monitor"></i>
            <span class="card-title">新一代变电站集中监控系统</span>
            <el-tag type="primary" size="small">核心功能</el-tag>
          </div>
          
          <div class="card-content">
            <div class="content-section">
              <h3 class="section-title">
                <i class="el-icon-info"></i>
                系统背景
              </h3>
              <p class="section-text">
                随着新一代变电站集中监控系统建设，电网规模不断扩大，智能化水平持续提升，接入集控系统的变电站、电网设备及告警信息持续增长。由于新接入集控系统信息的多样性，现有系统中各类监控信息存在命名规范不一致的情况，导致事件化合成效率不高，影响单点信号监视转为综合事件监视的应用成效。
              </p>
            </div>

            <div class="content-section">
              <h3 class="section-title">
                <i class="el-icon-warning"></i>
                当前挑战
              </h3>
              <div class="challenge-list">
                <div class="challenge-item">
                  <i class="el-icon-circle-check"></i>
                  <span>监控信息命名规范不一致</span>
                </div>
                <div class="challenge-item">
                  <i class="el-icon-circle-check"></i>
                  <span>事件化合成效率不高</span>
                </div>
                <div class="challenge-item">
                  <i class="el-icon-circle-check"></i>
                  <span>单点信号监视转为综合事件监视应用成效受影响</span>
                </div>
                <div class="challenge-item">
                  <i class="el-icon-circle-check"></i>
                  <span>映射结果准确率不高</span>
                </div>
                <div class="challenge-item">
                  <i class="el-icon-circle-check"></i>
                  <span>人工校核工作量较大</span>
                </div>
              </div>
            </div>

            <div class="content-section">
              <h3 class="section-title">
                <i class="el-icon-solution"></i>
                解决方案
              </h3>
              <div class="solution-content">
                <p class="section-text">
                  为进一步提升监控信息标准化水平，需要将实际信号与标准信号进行映射、转换，目前通过监控信号对象化映射工具已完成大部分信息映射，然而由于个别信息接入标准化不高、前期治理不彻底，目前存在映射结果准确率不高且人工校核工作量较大的问题，亟需通过人工智能手段，实现标准信号与实际信号对应规则匹配自学习，提高信息映射精准度，实现信息映射完整性的自动化校验，提升信息映射效率。
                </p>
                
                <div class="ai-solution">
                  <h4 class="ai-title">
                    <i class="el-icon-cpu"></i>
                    人工智能解决方案
                  </h4>
                  <div class="ai-features">
                    <div class="ai-feature">
                      <i class="el-icon-magic-stick"></i>
                      <span>标准信号与实际信号对应规则匹配自学习</span>
                    </div>
                    <div class="ai-feature">
                      <i class="el-icon-aim"></i>
                      <span>提高信息映射精准度</span>
                    </div>
                    <div class="ai-feature">
                      <i class="el-icon-check"></i>
                      <span>实现信息映射完整性的自动化校验</span>
                    </div>
                    <div class="ai-feature">
                      <i class="el-icon-timer"></i>
                      <span>提升信息映射效率</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="content-section">
              <h3 class="section-title">
                <i class="el-icon-connection"></i>
                技术架构
              </h3>
              <div class="architecture-content">
                <p class="section-text">
                  基于人工智能平台，建立信息标准化映射架构，完善监控信息标准化映射库，重点开展监控告警信号智能分析与校核，研究变电设备监控信息智能映射应用并完成技术验证，通过技术验证、评估，调整并制定后续应用提升方案，实现监控信息的自主识别，提升映射准确率和设备故障异常分析能力。
                </p>
                
                <div class="architecture-steps">
                  <div class="step-item">
                    <div class="step-number">1</div>
                    <div class="step-content">
                      <h5>建立信息标准化映射架构</h5>
                      <p>基于人工智能平台构建标准化映射框架</p>
                    </div>
                  </div>
                  <div class="step-item">
                    <div class="step-number">2</div>
                    <div class="step-content">
                      <h5>完善监控信息标准化映射库</h5>
                      <p>建立完整的信号映射数据库</p>
                    </div>
                  </div>
                  <div class="step-item">
                    <div class="step-number">3</div>
                    <div class="step-content">
                      <h5>监控告警信号智能分析与校核</h5>
                      <p>实现告警信号的智能分析和自动校核</p>
                    </div>
                  </div>
                  <div class="step-item">
                    <div class="step-number">4</div>
                    <div class="step-content">
                      <h5>变电设备监控信息智能映射应用</h5>
                      <p>完成技术验证和应用部署</p>
                    </div>
                  </div>
                  <div class="step-item">
                    <div class="step-number">5</div>
                    <div class="step-content">
                      <h5>技术验证与评估</h5>
                      <p>调整并制定后续应用提升方案</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="content-section">
              <h3 class="section-title">
                <i class="el-icon-trophy"></i>
                预期效果
              </h3>
              <div class="expected-results">
                <div class="result-item">
                  <i class="el-icon-success"></i>
                  <span>实现监控信息的自主识别</span>
                </div>
                <div class="result-item">
                  <i class="el-icon-success"></i>
                  <span>提升映射准确率</span>
                </div>
                <div class="result-item">
                  <i class="el-icon-success"></i>
                  <span>增强设备故障异常分析能力</span>
                </div>
                <div class="result-item">
                  <i class="el-icon-success"></i>
                  <span>提高系统整体智能化水平</span>
                </div>
              </div>
            </div>
          </div>
        </el-card>

        <!-- 快速导航 -->
        <el-card class="help-card" shadow="hover">
          <div slot="header" class="card-header">
            <i class="el-icon-menu"></i>
            <span class="card-title">快速导航</span>
          </div>
          
          <div class="quick-nav">
            <div class="nav-item" @click="scrollToSection('background')">
              <i class="el-icon-info"></i>
              <span>系统背景</span>
            </div>
            <div class="nav-item" @click="scrollToSection('challenge')">
              <i class="el-icon-warning"></i>
              <span>当前挑战</span>
            </div>
            <div class="nav-item" @click="scrollToSection('solution')">
              <i class="el-icon-solution"></i>
              <span>解决方案</span>
            </div>
            <div class="nav-item" @click="scrollToSection('architecture')">
              <i class="el-icon-connection"></i>
              <span>技术架构</span>
            </div>
            <div class="nav-item" @click="scrollToSection('results')">
              <i class="el-icon-trophy"></i>
              <span>预期效果</span>
            </div>
          </div>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "HelpCenter",
  data() {
    return {
      searchKeyword: "",
      helpContent: [
        {
          id: "background",
          title: "系统背景",
          icon: "el-icon-info",
          content: "随着新一代变电站集中监控系统建设..."
        },
        {
          id: "challenge", 
          title: "当前挑战",
          icon: "el-icon-warning",
          content: "监控信息命名规范不一致..."
        },
        {
          id: "solution",
          title: "解决方案", 
          icon: "el-icon-solution",
          content: "通过人工智能手段..."
        },
        {
          id: "architecture",
          title: "技术架构",
          icon: "el-icon-connection", 
          content: "基于人工智能平台..."
        },
        {
          id: "results",
          title: "预期效果",
          icon: "el-icon-trophy",
          content: "实现监控信息的自主识别..."
        }
      ]
    };
  },
  methods: {
    handleSearch() {
      // 搜索功能实现
      console.log("搜索关键词:", this.searchKeyword);
    },
    scrollToSection(sectionId) {
      // 滚动到指定区域
      const element = document.getElementById(sectionId);
      if (element) {
        element.scrollIntoView({ behavior: 'smooth' });
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.help-center {
  padding: 20px;
  
  .page-header {
    text-align: center;
    margin-bottom: 30px;
    
    .page-title {
      font-size: 28px;
      color: #303133;
      margin-bottom: 10px;
      
      i {
        margin-right: 10px;
        color: #409EFF;
      }
    }
    
    .page-subtitle {
      font-size: 16px;
      color: #909399;
      margin: 0;
    }
  }
  
  .search-section {
    text-align: center;
    margin-bottom: 30px;
  }
  
  .help-content {
    max-width: 1200px;
    margin: 0 auto;
    
    .help-card {
      margin-bottom: 20px;
      
      .card-header {
        display: flex;
        align-items: center;
        
        i {
          margin-right: 8px;
          color: #409EFF;
        }
        
        .card-title {
          font-size: 18px;
          font-weight: 600;
          color: #303133;
          flex: 1;
        }
      }
      
      .card-content {
        .content-section {
          margin-bottom: 30px;
          
          &:last-child {
            margin-bottom: 0;
          }
          
          .section-title {
            font-size: 18px;
            color: #303133;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            
            i {
              margin-right: 8px;
              color: #409EFF;
            }
          }
          
          .section-text {
            line-height: 1.8;
            color: #606266;
            text-align: justify;
            margin-bottom: 15px;
          }
          
          .challenge-list {
            .challenge-item {
              display: flex;
              align-items: center;
              margin-bottom: 10px;
              
              i {
                color: #F56C6C;
                margin-right: 8px;
              }
              
              span {
                color: #606266;
              }
            }
          }
          
          .ai-solution {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
            
            .ai-title {
              font-size: 16px;
              color: #303133;
              margin-bottom: 15px;
              display: flex;
              align-items: center;
              
              i {
                margin-right: 8px;
                color: #67C23A;
              }
            }
            
            .ai-features {
              .ai-feature {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                
                i {
                  color: #67C23A;
                  margin-right: 8px;
                }
                
                span {
                  color: #606266;
                }
              }
            }
          }
          
          .architecture-steps {
            margin-top: 20px;
            
            .step-item {
              display: flex;
              align-items: flex-start;
              margin-bottom: 20px;
              
              .step-number {
                width: 30px;
                height: 30px;
                background: #409EFF;
                color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                margin-right: 15px;
                flex-shrink: 0;
              }
              
              .step-content {
                h5 {
                  margin: 0 0 5px 0;
                  color: #303133;
                  font-size: 16px;
                }
                
                p {
                  margin: 0;
                  color: #909399;
                  font-size: 14px;
                }
              }
            }
          }
          
          .expected-results {
            .result-item {
              display: flex;
              align-items: center;
              margin-bottom: 10px;
              
              i {
                color: #67C23A;
                margin-right: 8px;
              }
              
              span {
                color: #606266;
              }
            }
          }
        }
      }
    }
    
    .quick-nav {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 15px;
      
      .nav-item {
        display: flex;
        align-items: center;
        padding: 15px;
        background: #f8f9fa;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        
        &:hover {
          background: #e6f7ff;
          transform: translateY(-2px);
        }
        
        i {
          margin-right: 10px;
          color: #409EFF;
          font-size: 18px;
        }
        
        span {
          color: #303133;
          font-weight: 500;
        }
      }
    }
  }
}

// 响应式设计
@media (max-width: 768px) {
  .help-center {
    padding: 10px;
    
    .page-header {
      .page-title {
        font-size: 24px;
      }
    }
    
    .help-content {
      .quick-nav {
        grid-template-columns: 1fr;
      }
    }
  }
}
</style>
