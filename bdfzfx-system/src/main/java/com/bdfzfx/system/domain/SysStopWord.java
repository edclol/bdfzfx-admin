package com.bdfzfx.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 停用语料库对象 sys_stop_word
 * 
 * @author admin
 * @date 2025-08-21
 */
public class SysStopWord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    @Excel(name = "主键ID")
    private Long id;

    /** 停用词内容（如：的、-4、空格、& 等） */
    @Excel(name = "停用词内容", readConverterExp = "如=：的、-4、空格、&,等=")
    private String stopWord;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setStopWord(String stopWord) 
    {
        this.stopWord = stopWord;
    }

    public String getStopWord() 
    {
        return stopWord;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("stopWord", getStopWord())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
