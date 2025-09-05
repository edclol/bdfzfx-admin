<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="模型名称" prop="modelName">
        <el-input
          v-model="queryParams.modelName"
          placeholder="请输入模型名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="版本号" prop="versionNumber">
        <el-input
          v-model="queryParams.versionNumber"
          placeholder="请输入版本号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="上传时间" prop="uploadTime">
        <el-date-picker clearable
          v-model="queryParams.uploadTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择上传时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="调用次数" prop="callCount">
        <el-input
          v-model="queryParams.callCount"
          placeholder="请输入调用次数"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="精准率" prop="precisionRate">
        <el-input
          v-model="queryParams.precisionRate"
          placeholder="请输入精准率"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="召回率" prop="recallRate">
        <el-input
          v-model="queryParams.recallRate"
          placeholder="请输入召回率"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="模型大小" prop="modelSize">
        <el-input
          v-model="queryParams.modelSize"
          placeholder="请输入模型大小"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="部署路径" prop="modelPath">
        <el-input
          v-model="queryParams.modelPath"
          placeholder="请输入部署路径"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="F1分数" prop="f1Score">
        <el-input
          v-model="queryParams.f1Score"
          placeholder="请输入F1分数"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否启用" prop="isUsed">
        <el-input
          v-model="queryParams.isUsed"
          placeholder="请输入是否启用"
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
          v-hasPermi="['system:model:add']"
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
          v-hasPermi="['system:model:edit']"
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
          v-hasPermi="['system:model:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:model:export']"
        >导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="openAlgoIntro"
        >算法矩阵介绍</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="openInference"
        >推理示例</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="modelList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <el-table-column label="模型名称" align="center" prop="modelName" />
      <el-table-column label="版本号" align="center" prop="versionNumber" />
      <el-table-column label="上传时间" align="center" prop="uploadTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.uploadTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="调用次数" align="center" prop="callCount" />
      <el-table-column label="精准率" align="center" prop="precisionRate" />
      <el-table-column label="召回率" align="center" prop="recallRate" />
      <el-table-column label="模型大小" align="center" prop="modelSize" />
      <el-table-column label="部署路径" align="center" prop="modelPath" />
      <el-table-column label="F1分数" align="center" prop="f1Score" />
      <el-table-column label="模型描述或用途说明" align="center" prop="description" />
      <el-table-column label="是否启用" align="center" prop="isUsed" />
      <el-table-column label="备注信息" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="300">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:model:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:model:remove']"
          >删除</el-button>
          <el-button
            size="mini"
            type="text"
            @click="openThreshold(scope.row)"
          >阈值设置</el-button>
          <el-button
            size="mini"
            type="text"
            @click="openReport(scope.row)"
          >评估报告</el-button>
          <el-button
            size="mini"
            type="text"
            @click="openModelSwitch(scope.row)"
          >切换</el-button>
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

    <!-- 添加或修改模型信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="模型名称" prop="modelName">
          <el-input v-model="form.modelName" placeholder="请输入模型名称" />
        </el-form-item>
        <el-form-item label="版本号" prop="versionNumber">
          <el-input v-model="form.versionNumber" placeholder="请输入版本号" />
        </el-form-item>
        <el-form-item label="上传时间" prop="uploadTime">
          <el-date-picker clearable
            v-model="form.uploadTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择上传时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="调用次数" prop="callCount">
          <el-input v-model="form.callCount" placeholder="请输入调用次数" />
        </el-form-item>
        <el-form-item label="精准率" prop="precisionRate">
          <el-input v-model="form.precisionRate" placeholder="请输入精准率" />
        </el-form-item>
        <el-form-item label="召回率" prop="recallRate">
          <el-input v-model="form.recallRate" placeholder="请输入召回率" />
        </el-form-item>
        <el-form-item label="模型大小" prop="modelSize">
          <el-input v-model="form.modelSize" placeholder="请输入模型大小" />
        </el-form-item>
        <el-form-item label="部署路径" prop="modelPath">
          <el-input v-model="form.modelPath" placeholder="请输入部署路径" />
        </el-form-item>
        <el-form-item label="F1分数" prop="f1Score">
          <el-input v-model="form.f1Score" placeholder="请输入F1分数" />
        </el-form-item>
        <el-form-item label="模型描述或用途说明" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="是否启用" prop="isUsed">
          <el-input v-model="form.isUsed" placeholder="请输入是否启用" />
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

    <!-- 算法矩阵介绍对话框 -->
    <el-dialog title="算法矩阵介绍" :visible.sync="algoIntroOpen" width="720px" append-to-body>
      <div style="line-height: 1.8;">
        <h4>一、语义相似度计算</h4>
        <p>基于词嵌入模型将文本转化为向量空间表示，通过余弦相似度或编辑距离算法量化信号名称间的语义关联度，解决术语表述差异问题，实现标准信号与实际信号的自动归并。</p>
        <h4>二、语义分析</h4>
        <p>采用依存句法解析和实体识别技术，拆解信号名称的语法结构并提取核心要素（设备主体、信号类型、参数），构建结构化特征以支撑标准化映射。</p>
        <h4>三、知识推理</h4>
        <p>利用电力知识图谱的层级关系和预定义规则引擎，推导信号间的隐含逻辑关联，实现信号层级扩展与逻辑冲突检测。</p>
        <h4>四、知识服务</h4>
        <p>通过结构化知识库存储标准信号元数据，提供API接口实现原始信号到标准ID的自动化映射，并基于反馈机制动态优化智能匹配机制。</p>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="algoIntroOpen = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 阈值设置对话框 -->
    <el-dialog title="阈值设置" :visible.sync="thresholdOpen" width="500px" append-to-body>
      <el-form label-width="80px">
        <el-form-item label="模型">
          <el-select v-model="thresholdForm.model" placeholder="选择模型版本" style="width: 100%;">
            <el-option label="model v1" value="v1" />
            <el-option label="model v2" value="v2" />
            <el-option label="model v3" value="v3" />
          </el-select>
        </el-form-item>
        <el-form-item label="阈值">
          <el-input v-model="thresholdForm.value" placeholder="请输入阈值，例如 0.85" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmThreshold">确 认</el-button>
        <el-button @click="thresholdOpen = false">取 消</el-button>
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
        <el-button type="primary" icon="el-icon-download" @click="downloadEvaluationReport">下载两张图片</el-button>
        <el-button @click="reportOpen = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 模型切换对话框 -->
    <el-dialog title="模型切换" :visible.sync="modelSwitchOpen" width="420px" append-to-body>
      <el-form label-width="90px">
        <el-form-item label="选择版本">
          <el-select v-model="modelSwitchForm.version" placeholder="选择模型版本" style="width: 100%;">
            <el-option label="model v1" value="v1" />
            <el-option label="model v2" value="v2" />
            <el-option label="model v3" value="v3" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmModelSwitch">确 认</el-button>
        <el-button @click="modelSwitchOpen = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 推理示例对话框 -->
    <el-dialog title="推理示例" :visible.sync="inferenceOpen" width="820px" append-to-body @closed="onInferenceClosed">
      <div class="inference-stage">
        <img 
          v-for="(img, index) in tlgcImages" 
          :key="index"
          class="inference-img" 
          :class="{ 'active': index < revealedCount }" 
          :style="{ width: (100 / tlgcImages.length) + '%' }"
          :src="img.src" 
          :alt="img.alt" 
        />
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="inferenceOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listModel, getModel, delModel, addModel, updateModel } from "@/api/system/model"

export default {
  name: "Model",
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
      // 模型信息表格数据
      modelList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 阈值设置弹窗
      thresholdOpen: false,
      thresholdForm: { model: 'v1', value: '' },
      // 评估报告弹窗
      reportOpen: false,
      // 推理示例弹窗
      inferenceOpen: false,
      inferenceTimer: null,
      tlgcImages: [
        { src: require('./tlgc.png'), alt: 'tlgc' },
        { src: require('./tlgc1.png'), alt: 'tlgc 1' },
        { src: require('./tlgc2.png'), alt: 'tlgc 2' },
        { src: require('./tlgc3.png'), alt: 'tlgc 3' },
        { src: require('./tlgc4.png'), alt: 'tlgc 4' }
      ],
      currentImageIndex: 0,
      revealedCount: 0,
      inferenceAnimating: false,
      // 模型切换弹窗
      modelSwitchOpen: false,
      modelSwitchForm: { version: 'v1' },
      // 算法矩阵介绍弹窗
      algoIntroOpen: false,
      // 评估报告图片路径
      lossCurveSrc: require('./loss_curve.png'),
      trainCurveSrc: require('./train_curve.png'),
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        modelName: null,
        versionNumber: null,
        uploadTime: null,
        callCount: null,
        precisionRate: null,
        recallRate: null,
        modelSize: null,
        modelPath: null,
        f1Score: null,
        description: null,
        isUsed: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        modelName: [
          { required: true, message: "模型名称不能为空", trigger: "blur" }
        ],
        versionNumber: [
          { required: true, message: "版本号不能为空", trigger: "blur" }
        ],
        uploadTime: [
          { required: true, message: "上传时间不能为空", trigger: "blur" }
        ],
      },
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询模型信息列表 */
    getList() {
      this.loading = true
      listModel(this.queryParams).then(response => {
        this.modelList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 打开评估报告
    openReport() {
      this.reportOpen = true
    },
    // 下载评估报告（下载两张图片）
    downloadEvaluationReport() {
      // 下载第一张图片（损失曲线）
      this.downloadSingleImage(this.lossCurveSrc, 'loss_curve', () => {
        // 下载第二张图片（训练曲线）
        this.downloadSingleImage(this.trainCurveSrc, 'train_curve', () => {
          this.$message.success('两张图片下载完成')
        })
      })
    },
    
    // 下载单张图片的辅助方法
    downloadSingleImage(imgSrc, filename, callback) {
      const canvas = document.createElement('canvas')
      const ctx = canvas.getContext('2d')
      const img = new Image()
      
      img.onload = () => {
        canvas.width = img.width
        canvas.height = img.height
        ctx.drawImage(img, 0, 0)
        
        // 将canvas转换为blob并下载
        canvas.toBlob((blob) => {
          const url = window.URL.createObjectURL(blob)
          const a = document.createElement('a')
          a.href = url
          a.download = `${filename}_${Date.now()}.png`
          a.click()
          window.URL.revokeObjectURL(url)
          
          // 执行回调函数
          if (callback) {
            callback()
          }
        }, 'image/png')
      }
      
      img.src = imgSrc
    },

    // 确认阈值
    confirmThreshold() {
      const value = (this.thresholdForm.value || '').trim()
      if (!value) {
        this.$message.warning('请输入阈值')
        return
      }
      this.$message.success(`已设置 ${this.thresholdForm.model} 阈值为：${value}`)
      this.thresholdOpen = false
    },
    // 打开阈值设置
    openThreshold(row) {
      this.thresholdForm = {
        model: this.thresholdForm.model || 'v1',
        value: this.thresholdForm.value || '',
      }
      this.thresholdOpen = true
    },
    // 打开算法矩阵介绍
    openAlgoIntro() {
      this.algoIntroOpen = true;
    },
    // 打开模型切换
    openModelSwitch(row) {
      this.modelSwitchOpen = true
    },
    // 确认模型切换
    confirmModelSwitch() {
      this.$message.success(`已切换到 ${this.modelSwitchForm.version}`)
      this.modelSwitchOpen = false
    },
    // 打开推理示例
    openInference() {
      this.inferenceOpen = true
      this.revealedCount = 0
      this.inferenceAnimating = false
      this.startImageSequence()
    },
    startImageSequence() {
      this.inferenceTimer = setInterval(() => {
        if (this.revealedCount < this.tlgcImages.length) {
          this.revealedCount += 1
        } else {
          clearInterval(this.inferenceTimer)
          this.inferenceTimer = null
        }
      }, 1000) // 每1秒显示下一张，直到全部显示
    },
    onInferenceClosed() {
      if (this.inferenceTimer) {
        clearInterval(this.inferenceTimer)
        this.inferenceTimer = null
      }
      this.inferenceAnimating = false
      this.revealedCount = 0
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
        modelName: null,
        versionNumber: null,
        uploadTime: null,
        callCount: null,
        precisionRate: null,
        recallRate: null,
        modelSize: null,
        modelPath: null,
        f1Score: null,
        description: null,
        isUsed: null,
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
      this.title = "添加模型信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getModel(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改模型信息"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateModel(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addModel(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除模型信息编号为"' + ids + '"的数据项？').then(function() {
        return delModel(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/model/export', {
        ...this.queryParams
      }, `model_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style scoped>
.inference-stage {
  position: relative;
  width: 100%;
  height: 300px;
  border-radius: 6px;
  overflow: hidden;
  border: 1px solid #ebeef5;
  display: flex;
}
.inference-img {
  height: 100%;
  object-fit: contain;
  display: block;
  background: #fff;
  opacity: 0;
  transition: opacity 0.5s ease-in-out;
}
.inference-img.active {
  opacity: 1;
}
.inference-mask { display: none; }

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
