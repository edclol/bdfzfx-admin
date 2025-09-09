package com.bdfzfx.system.domain;

import java.io.Serializable;

/**
 * 典型监控信息统计结果
 */
public class SysTypicalMonitorInfoStat implements Serializable {
    private static final long serialVersionUID = 1L;
    
    /** 设备类型 */
    private String deviceType;
    
    /** 总数 */
    private Integer totalCount;
    
    // 构造函数
    public SysTypicalMonitorInfoStat() {}
    
    public SysTypicalMonitorInfoStat(String deviceType, Integer totalCount) {
        this.deviceType = deviceType;
        this.totalCount = totalCount;
    }
    
    // Getter和Setter方法
    public String getDeviceType() {
        return deviceType;
    }
    
    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType;
    }
    
    public Integer getTotalCount() {
        return totalCount;
    }
    
    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }
}
