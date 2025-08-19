package com.bdfzfx.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 同义词库对象 sys_synonym
 * 
 * @author admin
 * @date 2025-08-19
 */
public class SysSynonym extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    @Excel(name = "主键ID")
    private Long id;

    /** 原始词汇（如：过流Ⅰ段） */
    @Excel(name = "原始词汇", readConverterExp = "如=：过流Ⅰ段")
    private String word;

    /** 统一理解为的标准词（如：过流 I 段） */
    @Excel(name = "统一理解为的标准词", readConverterExp = "如=：过流,I=,段=")
    private String synonym;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setWord(String word) 
    {
        this.word = word;
    }

    public String getWord() 
    {
        return word;
    }

    public void setSynonym(String synonym) 
    {
        this.synonym = synonym;
    }

    public String getSynonym() 
    {
        return synonym;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("word", getWord())
            .append("synonym", getSynonym())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
