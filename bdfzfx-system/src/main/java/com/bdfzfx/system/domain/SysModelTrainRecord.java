package com.bdfzfx.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 模型训练记录对象 sys_model_train_record
 * 
 * @author admin
 * @date 2025-08-21
 */
public class SysModelTrainRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    @Excel(name = "主键ID")
    private Long id;

    /** 训练日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "训练日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date trainDate;

    /** 工作流版本号 */
    @Excel(name = "工作流版本号")
    private String workflowVersion;

    /** 训练结果（成功/失败） */
    @Excel(name = "训练结果", readConverterExp = "成=功/失败")
    private String result;

    /** GPU数量 */
    @Excel(name = "GPU数量")
    private Long gpuCount;

    /** 初始化模型参数（如：XXXX, YYYY, ZZZZ） */
    @Excel(name = "初始化模型参数", readConverterExp = "如=：XXXX,,Y=YYY,,Z=ZZZ")
    private String initModelParams;

    /** 执行训练过程（如：AAAAA, BBBBB, CCCCC） */
    @Excel(name = "执行训练过程", readConverterExp = "如=：AAAAA,,B=BBBB,,C=CCCC")
    private String executionProcess;

    /** 损失函数的变化数据（TEXT格式，包含多个系列） */
    @Excel(name = "损失函数的变化数据", readConverterExp = "T=EXT格式，包含多个系列")
    private String lossCurveData;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setTrainDate(Date trainDate) 
    {
        this.trainDate = trainDate;
    }

    public Date getTrainDate() 
    {
        return trainDate;
    }

    public void setWorkflowVersion(String workflowVersion) 
    {
        this.workflowVersion = workflowVersion;
    }

    public String getWorkflowVersion() 
    {
        return workflowVersion;
    }

    public void setResult(String result) 
    {
        this.result = result;
    }

    public String getResult() 
    {
        return result;
    }

    public void setGpuCount(Long gpuCount) 
    {
        this.gpuCount = gpuCount;
    }

    public Long getGpuCount() 
    {
        return gpuCount;
    }

    public void setInitModelParams(String initModelParams) 
    {
        this.initModelParams = initModelParams;
    }

    public String getInitModelParams() 
    {
        return initModelParams;
    }

    public void setExecutionProcess(String executionProcess) 
    {
        this.executionProcess = executionProcess;
    }

    public String getExecutionProcess() 
    {
        return executionProcess;
    }

    public void setLossCurveData(String lossCurveData) 
    {
        this.lossCurveData = lossCurveData;
    }

    public String getLossCurveData() 
    {
        return lossCurveData;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("trainDate", getTrainDate())
            .append("workflowVersion", getWorkflowVersion())
            .append("result", getResult())
            .append("gpuCount", getGpuCount())
            .append("initModelParams", getInitModelParams())
            .append("executionProcess", getExecutionProcess())
            .append("lossCurveData", getLossCurveData())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
