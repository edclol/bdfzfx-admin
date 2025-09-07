<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!-- 标题区域 -->
      <el-col :span="24">
        <div class="page-header">
          <h2>地市监控信息标准化治理指标展示</h2>
          <p class="subtitle">多维度展示标准化治理准确率、完成率等关键指标</p>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="chart-row">
      <!-- 准确率仪表盘 -->
      <el-col :span="12">
        <el-card class="chart-card">
          <div slot="header" class="card-header">
            <span class="card-title">
              <i class="el-icon-data-analysis"></i>
              标准化治理准确率
            </span>
          </div>
          <div class="chart-container">
            <div ref="accuracyChart" class="chart"></div>
            <div class="chart-info">
            </div>
          </div>
        </el-card>
      </el-col>

      <!-- 完成率仪表盘 -->
      <el-col :span="12">
        <el-card class="chart-card">
          <div slot="header" class="card-header">
            <span class="card-title">
              <i class="el-icon-s-data"></i>
              标准化治理完成率
            </span>
          </div>
          <div class="chart-container">
            <div ref="completionChart" class="chart"></div>
            <div class="chart-info">
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="chart-row">
      <!-- 趋势图 -->
      <el-col :span="24">
        <el-card class="chart-card">
          <div slot="header" class="card-header">
            <span class="card-title">
              <i class="el-icon-trend-charts"></i>
              指标趋势分析
            </span>
          </div>
          <div class="chart-container">
            <div ref="trendChart" class="chart trend-chart"></div>
          </div>
        </el-card>
      </el-col>
    </el-row>

  
  </div>
</template>

<script>
import * as echarts from 'echarts'

export default {
  name: 'ResultsIndex',
  data() {
    return {
      accuracyChart: null,
      completionChart: null,
      trendChart: null,
      radarChart: null
    }
  },
  mounted() {
    this.initCharts()
  },
  beforeDestroy() {
    // 销毁图表实例
    if (this.accuracyChart) this.accuracyChart.dispose()
    if (this.completionChart) this.completionChart.dispose()
    if (this.trendChart) this.trendChart.dispose()
    if (this.radarChart) this.radarChart.dispose()
  },
  methods: {
    initCharts() {
      this.$nextTick(() => {
        this.initAccuracyChart()
        this.initCompletionChart()
        this.initTrendChart()
        this.initRadarChart()
      })
    },

    // 初始化准确率仪表盘
    initAccuracyChart() {
      this.accuracyChart = echarts.init(this.$refs.accuracyChart)
      const option = {
        series: [{
          type: 'gauge',
          startAngle: 180,
          endAngle: 0,
          min: 0,
          max: 100,
          splitNumber: 10,
                     itemStyle: {
             color: '#58957f',
             shadowColor: 'rgba(88,149,127,0.45)',
             shadowBlur: 10,
             shadowOffsetX: 2,
             shadowOffsetY: 2
           },
          progress: {
            show: true,
            roundCap: true,
            width: 18
          },
          pointer: {
            icon: 'path://M2090.36389,615.30999 L2090.36389,615.30999 C2091.48372,615.30999 2092.40383,616.194028 2092.44859,617.312956 L2096.90698,728.755929 C2097.05155,732.369577 2094.2393,735.416212 2090.62566,735.56078 C2090.53845,735.564269 2090.45117,735.566014 2090.36389,735.566014 L2090.36389,735.566014 C2086.74736,735.566014 2083.81556,732.63423 2083.81556,729.017692 C2083.81556,728.930412 2083.81732,728.84314 2083.82081,728.755929 L2088.2792,617.312956 C2088.32396,616.194028 2089.24407,615.30999 2090.36389,615.30999 Z',
            length: '75%',
            width: 16,
            offsetCenter: [0, '5%']
          },
          axisLine: {
            roundCap: true,
            lineStyle: {
              width: 18
            }
          },
          axisTick: {
            splitNumber: 2,
            lineStyle: {
              width: 2,
              color: '#999'
            }
          },
          splitLine: {
            length: 12,
            lineStyle: {
              width: 3,
              color: '#999'
            }
          },
          axisLabel: {
            distance: 30,
            color: '#999',
            fontSize: 12
          },
          title: {
            offsetCenter: [0, '30%'],
            fontSize: 20
          },
          detail: {
            valueAnimation: true,
            formatter: '{value}%',
            color: 'auto',
            fontSize: 30,
            offsetCenter: [0, '70%']
          },
          data: [{
            value: 91.3,
            name: '准确率'
          }]
        }]
      }
      this.accuracyChart.setOption(option)
    },

    // 初始化完成率仪表盘
    initCompletionChart() {
      this.completionChart = echarts.init(this.$refs.completionChart)
      const option = {
        series: [{
          type: 'gauge',
          startAngle: 180,
          endAngle: 0,
          min: 0,
          max: 100,
          splitNumber: 10,
                     itemStyle: {
             color: '#7fb069',
             shadowColor: 'rgba(127,176,105,0.45)',
             shadowBlur: 10,
             shadowOffsetX: 2,
             shadowOffsetY: 2
           },
          progress: {
            show: true,
            roundCap: true,
            width: 18
          },
          pointer: {
            icon: 'path://M2090.36389,615.30999 L2090.36389,615.30999 C2091.48372,615.30999 2092.40383,616.194028 2092.44859,617.312956 L2096.90698,728.755929 C2097.05155,732.369577 2094.2393,735.416212 2090.62566,735.56078 C2090.53845,735.564269 2090.45117,735.566014 2090.36389,735.566014 L2090.36389,735.566014 C2086.74736,735.566014 2083.81556,732.63423 2083.81556,729.017692 C2083.81556,728.930412 2083.81732,728.84314 2083.82081,728.755929 L2088.2792,617.312956 C2088.32396,616.194028 2089.24407,615.30999 2090.36389,615.30999 Z',
            length: '75%',
            width: 16,
            offsetCenter: [0, '5%']
          },
          axisLine: {
            roundCap: true,
            lineStyle: {
              width: 18
            }
          },
          axisTick: {
            splitNumber: 2,
            lineStyle: {
              width: 2,
              color: '#999'
            }
          },
          splitLine: {
            length: 12,
            lineStyle: {
              width: 3,
              color: '#999'
            }
          },
          axisLabel: {
            distance: 30,
            color: '#999',
            fontSize: 12
          },
          title: {
            offsetCenter: [0, '30%'],
            fontSize: 20
          },
          detail: {
            valueAnimation: true,
            formatter: '{value}%',
            color: 'auto',
            fontSize: 30,
            offsetCenter: [0, '70%']
          },
          data: [{
            value: 85.2,
            name: '完成率'
          }]
        }]
      }
      this.completionChart.setOption(option)
    },

    // 初始化趋势图
    initTrendChart() {
      this.trendChart = echarts.init(this.$refs.trendChart)
      const option = {
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['准确率', '完成率']
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
        },
        yAxis: {
          type: 'value',
          min: 0,
          max: 100,
          axisLabel: {
            formatter: '{value}%'
          }
        },
        series: [
          {
            name: '准确率',
            type: 'line',
            stack: 'Total',
            data: [82, 84, 86, 88, 89, 90, 91, 91.3, 92, 93, 94, 95],
            smooth: true,
                         lineStyle: {
               color: '#58957f',
               width: 3
             },
             areaStyle: {
               color: {
                 type: 'linear',
                 x: 0,
                 y: 0,
                 x2: 0,
                 y2: 1,
                 colorStops: [{
                   offset: 0, color: 'rgba(88,149,127,0.3)'
                 }, {
                   offset: 1, color: 'rgba(88,149,127,0.1)'
                 }]
               }
             }
          },
          {
            name: '完成率',
            type: 'line',
            stack: 'Total',
            data: [75, 77, 79, 81, 82, 83, 84, 85.2, 86, 87, 88, 89],
            smooth: true,
                         lineStyle: {
               color: '#7fb069',
               width: 3
             },
             areaStyle: {
               color: {
                 type: 'linear',
                 x: 0,
                 y: 0,
                 x2: 0,
                 y2: 1,
                 colorStops: [{
                   offset: 0, color: 'rgba(127,176,105,0.3)'
                 }, {
                   offset: 1, color: 'rgba(127,176,105,0.1)'
                 }]
               }
             }
          }
        ]
      }
      this.trendChart.setOption(option)
    },



    // 初始化雷达图
    initRadarChart() {
      this.radarChart = echarts.init(this.$refs.radarChart)
      const option = {
        radar: {
          indicator: [
            { name: '准确率', max: 100 },
            { name: '完成率', max: 100 },
            { name: '及时性', max: 100 },
            { name: '规范性', max: 100 },
            { name: '一致性', max: 100 },
            { name: '完整性', max: 100 }
          ],
          radius: '65%'
        },
        series: [{
          name: '指标对比',
          type: 'radar',
          data: [
            {
              value: [91.3, 85.2, 88, 92, 89, 87],
              name: '当前指标',
                             areaStyle: {
                 color: 'rgba(88,149,127,0.3)'
               },
               lineStyle: {
                 color: '#58957f'
               },
               itemStyle: {
                 color: '#58957f'
               }
            },
            {
              value: [85, 80, 82, 88, 85, 83],
              name: '目标指标',
              areaStyle: {
                color: 'rgba(145,204,117,0.3)'
              },
              lineStyle: {
                color: '#91CC75'
              },
              itemStyle: {
                color: '#91CC75'
              }
            }
          ]
        }]
      }
      this.radarChart.setOption(option)
    }
  }
}
</script>

<style lang="scss" scoped>
.app-container {
  padding: 20px;
  background-color: #f5f7fa;
  min-height: 100vh;
}

.page-header {
  text-align: center;
  margin-bottom: 30px;
  
  h2 {
    color: #303133;
    margin-bottom: 10px;
    font-size: 28px;
    font-weight: 600;
  }
  
  .subtitle {
    color: #606266;
    font-size: 16px;
    margin: 0;
  }
}

.chart-row {
  margin-bottom: 20px;
}

.chart-card {
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  
     .card-header {
     background: linear-gradient(135deg, #58957f 0%, #7fb069 100%);
     color: white;
     border-radius: 8px 8px 0 0;
    
    .card-title {
      font-size: 16px;
      font-weight: 600;
      
      i {
        margin-right: 8px;
      }
    }
  }
}

.chart-container {
  position: relative;
  height: 300px;
  display: flex;
  align-items: center;
  justify-content: center;
  
  .chart {
    width: 100%;
    height: 100%;
  }
  
  .chart-info {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    z-index: 10;
    
    .metric-value {
      font-size: 36px;
      font-weight: bold;
      color: #303133;
      margin-bottom: 8px;
    }
    
    .metric-label {
      font-size: 14px;
      color: #606266;
    }
  }
}

.trend-chart {
  height: 400px;
}

// 响应式设计
@media (max-width: 768px) {
  .chart-container {
    height: 250px;
  }
  
  .trend-chart {
    height: 300px;
  }
  
  .page-header h2 {
    font-size: 24px;
  }
}
</style>
