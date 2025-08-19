package com.bdfzfx.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 样本数据版本管理对象 sys_yx_data_version
 * 
 * @author admin
 * @date 2025-08-19
 */
public class SysYxDataVersion extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 版本号 */
    @Excel(name = "版本号")
    private String versionNumber;

    /** 变更时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "变更时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date changeTime;

    /** 变更内容 */
    @Excel(name = "变更内容")
    private String changeContent;

    /** 操作 */
    @Excel(name = "操作")
    private String operation;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setVersionNumber(String versionNumber) 
    {
        this.versionNumber = versionNumber;
    }

    public String getVersionNumber() 
    {
        return versionNumber;
    }

    public void setChangeTime(Date changeTime) 
    {
        this.changeTime = changeTime;
    }

    public Date getChangeTime() 
    {
        return changeTime;
    }

    public void setChangeContent(String changeContent) 
    {
        this.changeContent = changeContent;
    }

    public String getChangeContent() 
    {
        return changeContent;
    }

    public void setOperation(String operation) 
    {
        this.operation = operation;
    }

    public String getOperation() 
    {
        return operation;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("versionNumber", getVersionNumber())
            .append("changeTime", getChangeTime())
            .append("changeContent", getChangeContent())
            .append("operation", getOperation())
            .toString();
    }
}
