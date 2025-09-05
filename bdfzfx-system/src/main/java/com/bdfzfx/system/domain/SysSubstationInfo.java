package com.bdfzfx.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 变电站信息对象 sys_substation_info
 * 
 * @author admin
 * @date 2025-09-05
 */
public class SysSubstationInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    @Excel(name = "主键ID")
    private Long id;

    /** 变电站名称 */
    @Excel(name = "变电站名称")
    private String substationName;

    /** 地理位置 */
    @Excel(name = "地理位置")
    private String location;

    /** 电压等级 */
    @Excel(name = "电压等级")
    private String voltageLevel;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setSubstationName(String substationName) 
    {
        this.substationName = substationName;
    }

    public String getSubstationName() 
    {
        return substationName;
    }

    public void setLocation(String location) 
    {
        this.location = location;
    }

    public String getLocation() 
    {
        return location;
    }

    public void setVoltageLevel(String voltageLevel) 
    {
        this.voltageLevel = voltageLevel;
    }

    public String getVoltageLevel() 
    {
        return voltageLevel;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("substationName", getSubstationName())
            .append("location", getLocation())
            .append("voltageLevel", getVoltageLevel())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
