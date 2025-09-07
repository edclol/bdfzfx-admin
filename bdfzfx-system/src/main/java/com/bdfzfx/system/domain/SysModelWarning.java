package com.bdfzfx.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 模型预警对象 sys_model_warning
 * 
 * @author admin
 * @date 2025-09-07
 */
public class SysModelWarning extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 序号 */
    @Excel(name = "序号")
    private Long id;

    /** 发生时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "发生时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date occurTime;

    /** 预警等级NING=警告，INFO=轻微 */
    @Excel(name = "预警等级NING=警告，INFO=轻微")
    private String warningLevel;

    /** 预警内容 */
    @Excel(name = "预警内容")
    private String warningContent;

    /** 建议处理 */
    @Excel(name = "建议处理")
    private String suggestion;

    /** 状态 */
    @Excel(name = "状态")
    private String status;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setOccurTime(Date occurTime) 
    {
        this.occurTime = occurTime;
    }

    public Date getOccurTime() 
    {
        return occurTime;
    }

    public void setWarningLevel(String warningLevel) 
    {
        this.warningLevel = warningLevel;
    }

    public String getWarningLevel() 
    {
        return warningLevel;
    }

    public void setWarningContent(String warningContent) 
    {
        this.warningContent = warningContent;
    }

    public String getWarningContent() 
    {
        return warningContent;
    }

    public void setSuggestion(String suggestion) 
    {
        this.suggestion = suggestion;
    }

    public String getSuggestion() 
    {
        return suggestion;
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
            .append("id", getId())
            .append("occurTime", getOccurTime())
            .append("warningLevel", getWarningLevel())
            .append("warningContent", getWarningContent())
            .append("suggestion", getSuggestion())
            .append("status", getStatus())
            .append("remark", getRemark())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
