package com.bdfzfx.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 样本库对象 sys_yx_info_all
 * 
 * @author xx
 * @date 2025-08-18
 */
public class SysYxInfoAll extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 序号 */
    @Excel(name = "序号")
    private Long id;

    /** 遥信ID */
    @Excel(name = "遥信ID")
    private String yxId;

    /** 信息名称 */
    private String infoName;

    /** 原始信息名称 */
    private String infoNameOriginal;

    /** 变电站ID */
    @Excel(name = "变电站ID")
    private String substationId;

    /** 间隔ID */
    @Excel(name = "间隔ID")
    private String intervalId;

    /** 设备类型 */
    @Excel(name = "设备类型")
    private String yxType;

    /** 设备类型 */
    private String deviceType;

    /** 部件类型 */
    private String partType;

    /** 设备原理 */
    private String devicePrinciple;

    /** 电压等级 */
    @Excel(name = "电压等级")
    private String vLevel;

    /** 告警类型 */
    private String alarmType;

    /** 告警级别 */
    private String alarmLevel;

    /** 是否需要推送 */
    private String needPush;

    /** 参考资料 */
    private String reference;

    /** 要求 */
    private String requirement;

    /** 目标设备 */
    private String targetDevice;

    /** 源设备 */
    private String originDevice;

    /** 主数据设备 */
    private String dataPrimaryDevice;

    /** 从数据设备 */
    private String dataSecondaryDevice;

    /** 是否包含花括号 */
    private String isIncludeCurlyBraces;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setYxId(String yxId) 
    {
        this.yxId = yxId;
    }

    public String getYxId() 
    {
        return yxId;
    }

    public void setInfoName(String infoName) 
    {
        this.infoName = infoName;
    }

    public String getInfoName() 
    {
        return infoName;
    }

    public void setInfoNameOriginal(String infoNameOriginal) 
    {
        this.infoNameOriginal = infoNameOriginal;
    }

    public String getInfoNameOriginal() 
    {
        return infoNameOriginal;
    }

    public void setSubstationId(String substationId) 
    {
        this.substationId = substationId;
    }

    public String getSubstationId() 
    {
        return substationId;
    }

    public void setIntervalId(String intervalId) 
    {
        this.intervalId = intervalId;
    }

    public String getIntervalId() 
    {
        return intervalId;
    }

    public void setYxType(String yxType) 
    {
        this.yxType = yxType;
    }

    public String getYxType() 
    {
        return yxType;
    }

    public void setDeviceType(String deviceType) 
    {
        this.deviceType = deviceType;
    }

    public String getDeviceType() 
    {
        return deviceType;
    }

    public void setPartType(String partType) 
    {
        this.partType = partType;
    }

    public String getPartType() 
    {
        return partType;
    }

    public void setDevicePrinciple(String devicePrinciple) 
    {
        this.devicePrinciple = devicePrinciple;
    }

    public String getDevicePrinciple() 
    {
        return devicePrinciple;
    }

    public void setvLevel(String vLevel) 
    {
        this.vLevel = vLevel;
    }

    public String getvLevel() 
    {
        return vLevel;
    }

    public void setAlarmType(String alarmType) 
    {
        this.alarmType = alarmType;
    }

    public String getAlarmType() 
    {
        return alarmType;
    }

    public void setAlarmLevel(String alarmLevel) 
    {
        this.alarmLevel = alarmLevel;
    }

    public String getAlarmLevel() 
    {
        return alarmLevel;
    }

    public void setNeedPush(String needPush) 
    {
        this.needPush = needPush;
    }

    public String getNeedPush() 
    {
        return needPush;
    }

    public void setReference(String reference) 
    {
        this.reference = reference;
    }

    public String getReference() 
    {
        return reference;
    }

    public void setRequirement(String requirement) 
    {
        this.requirement = requirement;
    }

    public String getRequirement() 
    {
        return requirement;
    }

    public void setTargetDevice(String targetDevice) 
    {
        this.targetDevice = targetDevice;
    }

    public String getTargetDevice() 
    {
        return targetDevice;
    }

    public void setOriginDevice(String originDevice) 
    {
        this.originDevice = originDevice;
    }

    public String getOriginDevice() 
    {
        return originDevice;
    }

    public void setDataPrimaryDevice(String dataPrimaryDevice) 
    {
        this.dataPrimaryDevice = dataPrimaryDevice;
    }

    public String getDataPrimaryDevice() 
    {
        return dataPrimaryDevice;
    }

    public void setDataSecondaryDevice(String dataSecondaryDevice) 
    {
        this.dataSecondaryDevice = dataSecondaryDevice;
    }

    public String getDataSecondaryDevice() 
    {
        return dataSecondaryDevice;
    }

    public void setIsIncludeCurlyBraces(String isIncludeCurlyBraces) 
    {
        this.isIncludeCurlyBraces = isIncludeCurlyBraces;
    }

    public String getIsIncludeCurlyBraces() 
    {
        return isIncludeCurlyBraces;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("yxId", getYxId())
            .append("infoName", getInfoName())
            .append("infoNameOriginal", getInfoNameOriginal())
            .append("substationId", getSubstationId())
            .append("intervalId", getIntervalId())
            .append("yxType", getYxType())
            .append("deviceType", getDeviceType())
            .append("partType", getPartType())
            .append("devicePrinciple", getDevicePrinciple())
            .append("vLevel", getvLevel())
            .append("alarmType", getAlarmType())
            .append("alarmLevel", getAlarmLevel())
            .append("needPush", getNeedPush())
            .append("reference", getReference())
            .append("requirement", getRequirement())
            .append("targetDevice", getTargetDevice())
            .append("originDevice", getOriginDevice())
            .append("dataPrimaryDevice", getDataPrimaryDevice())
            .append("dataSecondaryDevice", getDataSecondaryDevice())
            .append("isIncludeCurlyBraces", getIsIncludeCurlyBraces())
            .toString();
    }
}
