package com.bdfzfx.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 信号信息对象 sys_signal_info
 * 
 *
 * @date 2025-08-16
 */
public class SysSignalInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 序号 */
    @Excel(name = "序号")
    private Long excelId;

    /** 厂站ID */
    @Excel(name = "厂站ID")
    private String stationId;

    /** 信号名称 */
    @Excel(name = "信号名称")
    private String signalName;

    /** 类型 */
    @Excel(name = "类型")
    private String signalType;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setExcelId(Long excelId) 
    {
        this.excelId = excelId;
    }

    public Long getExcelId() 
    {
        return excelId;
    }

    public void setStationId(String stationId) 
    {
        this.stationId = stationId;
    }

    public String getStationId() 
    {
        return stationId;
    }

    public void setSignalName(String signalName) 
    {
        this.signalName = signalName;
    }

    public String getSignalName() 
    {
        return signalName;
    }

    public void setSignalType(String signalType) 
    {
        this.signalType = signalType;
    }

    public String getSignalType() 
    {
        return signalType;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("excelId", getExcelId())
            .append("stationId", getStationId())
            .append("signalName", getSignalName())
            .append("signalType", getSignalType())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
