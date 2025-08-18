package com.bdfzfx.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 遥信调用记录对象 sys_remote_signal_call
 * 
 *
 * @date 2025-08-17
 */
public class SysRemoteSignalCall extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 调用时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "调用时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date callTime;

    /** 接口名称 */
    @Excel(name = "接口名称")
    private String interfaceName;

    /** 调用结果 */
    @Excel(name = "调用结果")
    private String callResult;

    /** 响应时长 */
    @Excel(name = "响应时长")
    private String responseTime;

    /** 厂站ID */
    @Excel(name = "厂站ID")
    private String stationId;

    /** 厂站名称 */
    @Excel(name = "厂站名称")
    private String stationName;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String deviceName;

    /** 设备类型 */
    @Excel(name = "设备类型")
    private String deviceType;

    /** 电压等级 */
    @Excel(name = "电压等级")
    private String voltageLevel;

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

    public void setCallTime(Date callTime) 
    {
        this.callTime = callTime;
    }

    public Date getCallTime() 
    {
        return callTime;
    }

    public void setInterfaceName(String interfaceName) 
    {
        this.interfaceName = interfaceName;
    }

    public String getInterfaceName() 
    {
        return interfaceName;
    }

    public void setCallResult(String callResult) 
    {
        this.callResult = callResult;
    }

    public String getCallResult() 
    {
        return callResult;
    }

    public void setResponseTime(String responseTime) 
    {
        this.responseTime = responseTime;
    }

    public String getResponseTime() 
    {
        return responseTime;
    }

    public void setStationId(String stationId) 
    {
        this.stationId = stationId;
    }

    public String getStationId() 
    {
        return stationId;
    }

    public void setStationName(String stationName) 
    {
        this.stationName = stationName;
    }

    public String getStationName() 
    {
        return stationName;
    }

    public void setDeviceName(String deviceName) 
    {
        this.deviceName = deviceName;
    }

    public String getDeviceName() 
    {
        return deviceName;
    }

    public void setDeviceType(String deviceType) 
    {
        this.deviceType = deviceType;
    }

    public String getDeviceType() 
    {
        return deviceType;
    }

    public void setVoltageLevel(String voltageLevel) 
    {
        this.voltageLevel = voltageLevel;
    }

    public String getVoltageLevel() 
    {
        return voltageLevel;
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
            .append("callTime", getCallTime())
            .append("interfaceName", getInterfaceName())
            .append("callResult", getCallResult())
            .append("responseTime", getResponseTime())
            .append("stationId", getStationId())
            .append("stationName", getStationName())
            .append("deviceName", getDeviceName())
            .append("deviceType", getDeviceType())
            .append("voltageLevel", getVoltageLevel())
            .append("operation", getOperation())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
