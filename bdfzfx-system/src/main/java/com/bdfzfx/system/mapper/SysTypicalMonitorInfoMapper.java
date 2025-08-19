package com.bdfzfx.system.mapper;

import java.util.List;
import com.bdfzfx.system.domain.SysTypicalMonitorInfo;

/**
 * 典型监控信息管理Mapper接口
 * 
 * @author admin
 * @date 2025-08-19
 */
public interface SysTypicalMonitorInfoMapper 
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
     * 删除典型监控信息管理
     * 
     * @param id 典型监控信息管理主键
     * @return 结果
     */
    public int deleteSysTypicalMonitorInfoById(Long id);

    /**
     * 批量删除典型监控信息管理
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysTypicalMonitorInfoByIds(Long[] ids);
}
