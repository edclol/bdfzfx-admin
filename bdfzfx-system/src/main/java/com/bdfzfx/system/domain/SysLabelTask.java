package com.bdfzfx.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 样本标注任务对象 sys_label_task
 * 
 * @author admin
 * @date 2025-08-18
 */
public class SysLabelTask extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 任务ID */
    @Excel(name = "任务ID")
    private Long taskId;

    /** 任务名称 */
    @Excel(name = "任务名称")
    private String taskName;

    /** 样本总数 */
    @Excel(name = "样本总数")
    private Long sampleCount;

    /** 已完成标注数量 */
    @Excel(name = "已完成标注数量")
    private Long completedCount;

    /** 处理人姓名 */
    @Excel(name = "处理人姓名")
    private String handler;

    /** 任务状态（0已发布 1进行中 2已完成 3已回收） */
    @Excel(name = "任务状态", readConverterExp = "0=已发布,1=进行中,2=已完成,3=已回收")
    private String status;

    public void setTaskId(Long taskId) 
    {
        this.taskId = taskId;
    }

    public Long getTaskId() 
    {
        return taskId;
    }

    public void setTaskName(String taskName) 
    {
        this.taskName = taskName;
    }

    public String getTaskName() 
    {
        return taskName;
    }

    public void setSampleCount(Long sampleCount) 
    {
        this.sampleCount = sampleCount;
    }

    public Long getSampleCount() 
    {
        return sampleCount;
    }

    public void setCompletedCount(Long completedCount) 
    {
        this.completedCount = completedCount;
    }

    public Long getCompletedCount() 
    {
        return completedCount;
    }

    public void setHandler(String handler) 
    {
        this.handler = handler;
    }

    public String getHandler() 
    {
        return handler;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("taskId", getTaskId())
            .append("taskName", getTaskName())
            .append("sampleCount", getSampleCount())
            .append("completedCount", getCompletedCount())
            .append("handler", getHandler())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
