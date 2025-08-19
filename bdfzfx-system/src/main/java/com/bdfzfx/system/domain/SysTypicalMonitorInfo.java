package com.bdfzfx.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 典型监控信息管理对象 sys_typical_monitor_info
 * 
 * @author admin
 * @date 2025-08-19
 */
public class SysTypicalMonitorInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 设备类型，如：开关保护、线路保护 */
    @Excel(name = "设备类型，如：开关保护、线路保护")
    private String deviceType;

    /** 设备原理，如：带过压远跳功能 */
    @Excel(name = "设备原理，如：带过压远跳功能")
    private String devicePrinciple;

    /** 信息名称，格式为：[电压等级][间隔名称][设备编号][保护（型号）] 光纤通道一软压板 */
    @Excel(name = "信息名称，格式为：[电压等级][间隔名称][设备编号][保护", readConverterExp = "型=号")
    private String infoName;

    /** 通用电压等级，如：550/220kV */
    @Excel(name = "通用电压等级，如：550/220kV")
    private String voltageLevel;

    /** 告警状态，如：告警、动作、异常 */
    @Excel(name = "告警状态，如：告警、动作、异常")
    private String alarmStatus;

    /** 告警等级，如：4级 */
    @Excel(name = "告警等级，如：4级")
    private String alarmLevel;

    /** 是否上送监控（0否，1是） */
    @Excel(name = "是否上送监控", readConverterExp = "0=否，1是")
    private String sendToMonitor;

    /** 参考依据，如：新一代、2020企标 */
    @Excel(name = "参考依据，如：新一代、2020企标")
    private String referenceBasis;

    /** 采集要求，如：实时采集、定时采集 */
    @Excel(name = "采集要求，如：实时采集、定时采集")
    private String collectionRequirement;

    /** 指向设备，如：线路保护装置、开关 */
    @Excel(name = "指向设备，如：线路保护装置、开关")
    private String targetDevice;

    /** 采集源设备，如：线路保护装置 */
    @Excel(name = "采集源设备，如：线路保护装置")
    private String sourceDevice;

    /** 数据集成设备，如：线路保护装置 */
    @Excel(name = "数据集成设备，如：线路保护装置")
    private String integrationDevice;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setDeviceType(String deviceType) 
    {
        this.deviceType = deviceType;
    }

    public String getDeviceType() 
    {
        return deviceType;
    }

    public void setDevicePrinciple(String devicePrinciple) 
    {
        this.devicePrinciple = devicePrinciple;
    }

    public String getDevicePrinciple() 
    {
        return devicePrinciple;
    }

    public void setInfoName(String infoName) 
    {
        this.infoName = infoName;
    }

    public String getInfoName() 
    {
        return infoName;
    }

    public void setVoltageLevel(String voltageLevel) 
    {
        this.voltageLevel = voltageLevel;
    }

    public String getVoltageLevel() 
    {
        return voltageLevel;
    }

    public void setAlarmStatus(String alarmStatus) 
    {
        this.alarmStatus = alarmStatus;
    }

    public String getAlarmStatus() 
    {
        return alarmStatus;
    }

    public void setAlarmLevel(String alarmLevel) 
    {
        this.alarmLevel = alarmLevel;
    }

    public String getAlarmLevel() 
    {
        return alarmLevel;
    }

    public void setSendToMonitor(String sendToMonitor) 
    {
        this.sendToMonitor = sendToMonitor;
    }

    public String getSendToMonitor() 
    {
        return sendToMonitor;
    }

    public void setReferenceBasis(String referenceBasis) 
    {
        this.referenceBasis = referenceBasis;
    }

    public String getReferenceBasis() 
    {
        return referenceBasis;
    }

    public void setCollectionRequirement(String collectionRequirement) 
    {
        this.collectionRequirement = collectionRequirement;
    }

    public String getCollectionRequirement() 
    {
        return collectionRequirement;
    }

    public void setTargetDevice(String targetDevice) 
    {
        this.targetDevice = targetDevice;
    }

    public String getTargetDevice() 
    {
        return targetDevice;
    }

    public void setSourceDevice(String sourceDevice) 
    {
        this.sourceDevice = sourceDevice;
    }

    public String getSourceDevice() 
    {
        return sourceDevice;
    }

    public void setIntegrationDevice(String integrationDevice) 
    {
        this.integrationDevice = integrationDevice;
    }

    public String getIntegrationDevice() 
    {
        return integrationDevice;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("deviceType", getDeviceType())
            .append("devicePrinciple", getDevicePrinciple())
            .append("infoName", getInfoName())
            .append("voltageLevel", getVoltageLevel())
            .append("alarmStatus", getAlarmStatus())
            .append("alarmLevel", getAlarmLevel())
            .append("sendToMonitor", getSendToMonitor())
            .append("referenceBasis", getReferenceBasis())
            .append("collectionRequirement", getCollectionRequirement())
            .append("targetDevice", getTargetDevice())
            .append("sourceDevice", getSourceDevice())
            .append("integrationDevice", getIntegrationDevice())
            .append("updateTime", getUpdateTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("remark", getRemark())
            .toString();
    }
}
