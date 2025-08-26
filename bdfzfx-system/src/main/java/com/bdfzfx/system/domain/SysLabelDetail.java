package com.bdfzfx.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.bdfzfx.common.annotation.Excel;
import com.bdfzfx.common.core.domain.BaseEntity;

/**
 * 样本标注详情对象 sys_label_detail
 * 
 * @author admin
 * @date 2025-08-26
 */
public class SysLabelDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 所属任务ID，关联sys_label_task.task_id */
    @Excel(name = "所属任务ID，关联sys_label_task.task_id")
    private Long taskId;

    /** 变电站ID，如：四川草坝 */
    @Excel(name = "变电站ID，如：四川草坝")
    private String substationId;

    /** 遥信ID，如：断路器表四川草坝四川/草坝/10kV 901开关遥信值 */
    @Excel(name = "遥信ID，如：断路器表四川草坝四川/草坝/10kV 901开关遥信值")
    private String remoteSignalId;

    /** 监控ID，如：XXXXXXXXXX */
    @Excel(name = "监控ID，如：XXXXXXXXXX")
    private String monitorId;

    /** 遥信类型：遥测/遥信/遥控/遥调 */
    @Excel(name = "遥信类型：遥测/遥信/遥控/遥调")
    private String signalType;

    /** 入库时间，如：2024-12-12 10:00:00 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "入库时间，如：2024-12-12 10:00:00", width = 30, dateFormat = "yyyy-MM-dd")
    private Date entryTime;

    /** 监控信息内容，描述性文本 */
    @Excel(name = "监控信息内容，描述性文本")
    private String monitorContent;

    /** 设备类型，如：主变保护 */
    @Excel(name = "设备类型，如：主变保护")
    private String deviceType;

    /** 设备原理，如：通用 */
    @Excel(name = "设备原理，如：通用")
    private String devicePrinciple;

    /** 信息名称，格式为：[主变编号] [设备编号] 保护 [型号] 远方操作硬压板 */
    @Excel(name = "信息名称，格式为：[主变编号] [设备编号] 保护 [型号] 远方操作硬压板")
    private String infoName;

    /** 适用电压等级(kW)，如：500 */
    @Excel(name = "适用电压等级(kW)，如：500")
    private String voltageLevel;

    /** 告警/状态，如：告警 */
    @Excel(name = "告警/状态，如：告警")
    private String alarmStatus;

    /** 告警等级，如：1级 */
    @Excel(name = "告警等级，如：1级")
    private String alarmLevel;

    /** 是否正样例：1=正样例，0=负样例 */
    @Excel(name = "是否正样例：1=正样例，0=负样例")
    private String isPositiveSample;

    /** 标注人姓名 */
    @Excel(name = "标注人姓名")
    private String labelUser;

    /** 标注时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "标注时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date labelTime;

    /** 是否已标注：1=已标注，0=未标注 */
    @Excel(name = "是否已标注：1=已标注，0=未标注")
    private String isLabeled;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setTaskId(Long taskId) 
    {
        this.taskId = taskId;
    }

    public Long getTaskId() 
    {
        return taskId;
    }

    public void setSubstationId(String substationId) 
    {
        this.substationId = substationId;
    }

    public String getSubstationId() 
    {
        return substationId;
    }

    public void setRemoteSignalId(String remoteSignalId) 
    {
        this.remoteSignalId = remoteSignalId;
    }

    public String getRemoteSignalId() 
    {
        return remoteSignalId;
    }

    public void setMonitorId(String monitorId) 
    {
        this.monitorId = monitorId;
    }

    public String getMonitorId() 
    {
        return monitorId;
    }

    public void setSignalType(String signalType) 
    {
        this.signalType = signalType;
    }

    public String getSignalType() 
    {
        return signalType;
    }

    public void setEntryTime(Date entryTime) 
    {
        this.entryTime = entryTime;
    }

    public Date getEntryTime() 
    {
        return entryTime;
    }

    public void setMonitorContent(String monitorContent) 
    {
        this.monitorContent = monitorContent;
    }

    public String getMonitorContent() 
    {
        return monitorContent;
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

    public void setIsPositiveSample(String isPositiveSample) 
    {
        this.isPositiveSample = isPositiveSample;
    }

    public String getIsPositiveSample() 
    {
        return isPositiveSample;
    }

    public void setLabelUser(String labelUser) 
    {
        this.labelUser = labelUser;
    }

    public String getLabelUser() 
    {
        return labelUser;
    }

    public void setLabelTime(Date labelTime) 
    {
        this.labelTime = labelTime;
    }

    public Date getLabelTime() 
    {
        return labelTime;
    }

    public void setIsLabeled(String isLabeled) 
    {
        this.isLabeled = isLabeled;
    }

    public String getIsLabeled() 
    {
        return isLabeled;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("taskId", getTaskId())
            .append("substationId", getSubstationId())
            .append("remoteSignalId", getRemoteSignalId())
            .append("monitorId", getMonitorId())
            .append("signalType", getSignalType())
            .append("entryTime", getEntryTime())
            .append("monitorContent", getMonitorContent())
            .append("deviceType", getDeviceType())
            .append("devicePrinciple", getDevicePrinciple())
            .append("infoName", getInfoName())
            .append("voltageLevel", getVoltageLevel())
            .append("alarmStatus", getAlarmStatus())
            .append("alarmLevel", getAlarmLevel())
            .append("isPositiveSample", getIsPositiveSample())
            .append("labelUser", getLabelUser())
            .append("labelTime", getLabelTime())
            .append("isLabeled", getIsLabeled())
            .append("remark", getRemark())
            .toString();
    }
}
