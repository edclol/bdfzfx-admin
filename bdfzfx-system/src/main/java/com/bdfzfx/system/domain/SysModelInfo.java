package com.bdfzfx.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 模型信息对象 sys_model_info
 * 
 * @author admin
 * @date 2025-08-21
 */
public class SysModelInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    @Excel(name = "主键ID")
    private Long id;

    /** 模型名称（如：故障诊断模型） */
    @Excel(name = "模型名称", readConverterExp = "如=：故障诊断模型")
    private String modelName;

    /** 版本号（如：V20.24.22） */
    @Excel(name = "版本号", readConverterExp = "如=：V20.24.22")
    private String versionNumber;

    /** 上传时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "上传时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date uploadTime;

    /** 调用次数 */
    @Excel(name = "调用次数")
    private Long callCount;

    /** 精准率（百分比，如：85.00） */
    @Excel(name = "精准率", readConverterExp = "百=分比，如：85.00")
    private BigDecimal precisionRate;

    /** 召回率（百分比，如：80.00） */
    @Excel(name = "召回率", readConverterExp = "百=分比，如：80.00")
    private BigDecimal recallRate;

    /** 模型大小 */
    @Excel(name = "模型大小")
    private String modelSize;

    /** 部署路径 */
    @Excel(name = "部署路径")
    private String modelPath;

    /** F1分数（可选） */
    @Excel(name = "F1分数", readConverterExp = "可=选")
    private BigDecimal f1Score;

    /** 模型描述或用途说明 */
    @Excel(name = "模型描述或用途说明")
    private String description;

    /** 是否启用（0：未启用，1：已启用） */
    @Excel(name = "是否启用", readConverterExp = "0=：未启用，1：已启用")
    private String isUsed;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setModelName(String modelName) 
    {
        this.modelName = modelName;
    }

    public String getModelName() 
    {
        return modelName;
    }

    public void setVersionNumber(String versionNumber) 
    {
        this.versionNumber = versionNumber;
    }

    public String getVersionNumber() 
    {
        return versionNumber;
    }

    public void setUploadTime(Date uploadTime) 
    {
        this.uploadTime = uploadTime;
    }

    public Date getUploadTime() 
    {
        return uploadTime;
    }

    public void setCallCount(Long callCount) 
    {
        this.callCount = callCount;
    }

    public Long getCallCount() 
    {
        return callCount;
    }

    public void setPrecisionRate(BigDecimal precisionRate) 
    {
        this.precisionRate = precisionRate;
    }

    public BigDecimal getPrecisionRate() 
    {
        return precisionRate;
    }

    public void setRecallRate(BigDecimal recallRate) 
    {
        this.recallRate = recallRate;
    }

    public BigDecimal getRecallRate() 
    {
        return recallRate;
    }

    public void setModelSize(String modelSize) 
    {
        this.modelSize = modelSize;
    }

    public String getModelSize() 
    {
        return modelSize;
    }

    public void setModelPath(String modelPath) 
    {
        this.modelPath = modelPath;
    }

    public String getModelPath() 
    {
        return modelPath;
    }

    public void setF1Score(BigDecimal f1Score) 
    {
        this.f1Score = f1Score;
    }

    public BigDecimal getF1Score() 
    {
        return f1Score;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setIsUsed(String isUsed) 
    {
        this.isUsed = isUsed;
    }

    public String getIsUsed() 
    {
        return isUsed;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("modelName", getModelName())
            .append("versionNumber", getVersionNumber())
            .append("uploadTime", getUploadTime())
            .append("callCount", getCallCount())
            .append("precisionRate", getPrecisionRate())
            .append("recallRate", getRecallRate())
            .append("modelSize", getModelSize())
            .append("modelPath", getModelPath())
            .append("f1Score", getF1Score())
            .append("description", getDescription())
            .append("isUsed", getIsUsed())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
