package com.bdfzfx.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 意见反馈对象 sys_feedback
 * 
 * @author admin
 * @date 2025-09-04
 */
public class SysFeedback extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 用户名 */
    @Excel(name = "用户名")
    private String username;

    /** 反馈类型（如：功能问题、界面优化、性能问题等） */
    @Excel(name = "反馈类型", readConverterExp = "如=：功能问题、界面优化、性能问题等")
    private String feedbackType;

    /** 反馈内容（详细描述问题或建议） */
    @Excel(name = "反馈内容", readConverterExp = "详=细描述问题或建议")
    private String content;

    /** 联系方式（如邮箱、电话，便于后续沟通） */
    @Excel(name = "联系方式", readConverterExp = "如=邮箱、电话，便于后续沟通")
    private String contactInfo;

    /** 处理状态（0: 待处理, 1: 处理中, 2: 已解决, 3: 已关闭） */
    @Excel(name = "处理状态", readConverterExp = "0=:,待=处理,,1=:,处=理中,,2=:,已=解决,,3=:,已=关闭")
    private String status;

    /** 优先级（1: 高, 2: 中, 3: 低） */
    @Excel(name = "优先级", readConverterExp = "1=:,高=,,2=:,中=,,3=:,低=")
    private String priority;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setUsername(String username) 
    {
        this.username = username;
    }

    public String getUsername() 
    {
        return username;
    }

    public void setFeedbackType(String feedbackType) 
    {
        this.feedbackType = feedbackType;
    }

    public String getFeedbackType() 
    {
        return feedbackType;
    }

    public void setContent(String content) 
    {
        this.content = content;
    }

    public String getContent() 
    {
        return content;
    }

    public void setContactInfo(String contactInfo) 
    {
        this.contactInfo = contactInfo;
    }

    public String getContactInfo() 
    {
        return contactInfo;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setPriority(String priority) 
    {
        this.priority = priority;
    }

    public String getPriority() 
    {
        return priority;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("username", getUsername())
            .append("feedbackType", getFeedbackType())
            .append("content", getContent())
            .append("contactInfo", getContactInfo())
            .append("status", getStatus())
            .append("priority", getPriority())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
