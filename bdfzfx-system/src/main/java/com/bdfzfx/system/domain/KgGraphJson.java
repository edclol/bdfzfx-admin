package com.bdfzfx.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 知识图谱JSON存储对象 kg_graph_json
 * 
 * @author admin
 * @date 2025-08-26
 */
public class KgGraphJson extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    @Excel(name = "主键ID")
    private Long id;

    /** 知识图谱JSON数据 */
    @Excel(name = "知识图谱JSON数据")
    private String graphData;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setGraphData(String graphData) 
    {
        this.graphData = graphData;
    }

    public String getGraphData() 
    {
        return graphData;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("graphData", getGraphData())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
