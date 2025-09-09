package com.bdfzfx.system.domain;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 遥信调用记录统计结果
 */
public class SysRemoteSignalCallStat implements Serializable {
    private static final long serialVersionUID = 1L;
    
    /** 厂站名称 */
    private String stationName;
    
    /** 总调用次数 */
    private Integer totalCount;
    
    /** 成功次数 */
    private Integer successCount;
    
    /** 失败次数 */
    private Integer failCount;
    
    /** 平均响应时间（秒） */
    private BigDecimal avgResponseTime;
    
    // 构造函数
    public SysRemoteSignalCallStat() {}
    
    public SysRemoteSignalCallStat(String stationName, Integer totalCount, Integer successCount, Integer failCount, BigDecimal avgResponseTime) {
        this.stationName = stationName;
        this.totalCount = totalCount;
        this.successCount = successCount;
        this.failCount = failCount;
        this.avgResponseTime = avgResponseTime;
    }
    
    // Getter和Setter方法
    public String getStationName() {
        return stationName;
    }
    
    public void setStationName(String stationName) {
        this.stationName = stationName;
    }
    
    public Integer getTotalCount() {
        return totalCount;
    }
    
    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }
    
    public Integer getSuccessCount() {
        return successCount;
    }
    
    public void setSuccessCount(Integer successCount) {
        this.successCount = successCount;
    }
    
    public Integer getFailCount() {
        return failCount;
    }
    
    public void setFailCount(Integer failCount) {
        this.failCount = failCount;
    }
    
    public BigDecimal getAvgResponseTime() {
        return avgResponseTime;
    }
    
    public void setAvgResponseTime(BigDecimal avgResponseTime) {
        this.avgResponseTime = avgResponseTime;
    }
}
