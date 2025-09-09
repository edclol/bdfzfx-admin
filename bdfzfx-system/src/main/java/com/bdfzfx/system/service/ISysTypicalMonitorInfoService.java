package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysTypicalMonitorInfo;
import com.bdfzfx.system.domain.SysTypicalMonitorInfoStat;

/**
 * 典型监控信息管理Service接口
 * 
 * @date 2025-08-14
 */
public interface ISysTypicalMonitorInfoService 
{
    /**
     * 查询典型监控信息管理
     * 
     * @param id 典型监控信息管理主键
     * @return 典型监控信息管理
     */
    public SysTypicalMonitorInfo selectSysTypicalMonitorInfoById(Long id);

    /**
     * 查询典型监控信息管理列表
     * 
     * @param sysTypicalMonitorInfo 典型监控信息管理
     * @return 典型监控信息管理集合
     */
    public List<SysTypicalMonitorInfo> selectSysTypicalMonitorInfoList(SysTypicalMonitorInfo sysTypicalMonitorInfo);

    /**
     * 新增典型监控信息管理
     * 
     * @param sysTypicalMonitorInfo 典型监控信息管理
     * @return 结果
     */
    public int insertSysTypicalMonitorInfo(SysTypicalMonitorInfo sysTypicalMonitorInfo);

    /**
     * 修改典型监控信息管理
     * 
     * @param sysTypicalMonitorInfo 典型监控信息管理
     * @return 结果
     */
    public int updateSysTypicalMonitorInfo(SysTypicalMonitorInfo sysTypicalMonitorInfo);

    /**
     * 批量删除典型监控信息管理
     * 
     * @param ids 需要删除的典型监控信息管理主键集合
     * @return 结果
     */
    public int deleteSysTypicalMonitorInfoByIds(Long[] ids);

    /**
     * 删除典型监控信息管理信息
     * 
     * @param id 典型监控信息管理主键
     * @return 结果
     */
    public int deleteSysTypicalMonitorInfoById(Long id);
    
    /**
     * 按设备类型统计典型监控信息
     * 
     * @return 设备类型统计结果列表
     */
    public List<SysTypicalMonitorInfoStat> selectSysTypicalMonitorInfoStatByDeviceType();
}
