package com.bdfzfx.system.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 映射结果对象 sys_mapping_result
 * 
 * @author admin
 * @date 2025-09-05
 */
public class SysMappingResult extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    @Excel(name = "主键ID")
    private Long id;

    /** 遥信ID */
    @Excel(name = "遥信ID")
    private String remoteSignalId;

    /** 条件语句 */
    @Excel(name = "条件语句")
    private String dbStatement;

    /** 相似度 */
    @Excel(name = "相似度")
    private BigDecimal score;

    /** 匹配耗时 */
    @Excel(name = "匹配耗时")
    private String elapsedTime;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setRemoteSignalId(String remoteSignalId) 
    {
        this.remoteSignalId = remoteSignalId;
    }

    public String getRemoteSignalId() 
    {
        return remoteSignalId;
    }

    public void setDbStatement(String dbStatement) 
    {
        this.dbStatement = dbStatement;
    }

    public String getDbStatement() 
    {
        return dbStatement;
    }

    public void setScore(BigDecimal score) 
    {
        this.score = score;
    }

    public BigDecimal getScore() 
    {
        return score;
    }

    public void setElapsedTime(String elapsedTime) 
    {
        this.elapsedTime = elapsedTime;
    }

    public String getElapsedTime() 
    {
        return elapsedTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("remoteSignalId", getRemoteSignalId())
            .append("dbStatement", getDbStatement())
            .append("score", getScore())
            .append("elapsedTime", getElapsedTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
