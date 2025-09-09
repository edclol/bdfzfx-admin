package com.bdfzfx.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysTypicalMonitorInfoMapper;
import com.bdfzfx.system.domain.SysTypicalMonitorInfo;
import com.bdfzfx.system.service.ISysTypicalMonitorInfoService;
import com.bdfzfx.system.domain.SysTypicalMonitorInfoStat;

/**
 * 典型监控信息管理Service业务层处理
 * 
 * @date 2025-08-14
 */
@Service
public class SysTypicalMonitorInfoServiceImpl implements ISysTypicalMonitorInfoService 
{
    @Autowired
    private SysTypicalMonitorInfoMapper sysTypicalMonitorInfoMapper;

    /**
     * 查询典型监控信息管理
     * 
     * @param id 典型监控信息管理主键
     * @return 典型监控信息管理
     */
    @Override
    public SysTypicalMonitorInfo selectSysTypicalMonitorInfoById(Long id)
    {
        return sysTypicalMonitorInfoMapper.selectSysTypicalMonitorInfoById(id);
    }

    /**
     * 查询典型监控信息管理列表
     * 
     * @param sysTypicalMonitorInfo 典型监控信息管理
     * @return 典型监控信息管理
     */
    @Override
    public List<SysTypicalMonitorInfo> selectSysTypicalMonitorInfoList(SysTypicalMonitorInfo sysTypicalMonitorInfo)
    {
        return sysTypicalMonitorInfoMapper.selectSysTypicalMonitorInfoList(sysTypicalMonitorInfo);
    }

    /**
     * 新增典型监控信息管理
     * 
     * @param sysTypicalMonitorInfo 典型监控信息管理
     * @return 结果
     */
    @Override
    public int insertSysTypicalMonitorInfo(SysTypicalMonitorInfo sysTypicalMonitorInfo)
    {
        return sysTypicalMonitorInfoMapper.insertSysTypicalMonitorInfo(sysTypicalMonitorInfo);
    }

    /**
     * 修改典型监控信息管理
     * 
     * @param sysTypicalMonitorInfo 典型监控信息管理
     * @return 结果
     */
    @Override
    public int updateSysTypicalMonitorInfo(SysTypicalMonitorInfo sysTypicalMonitorInfo)
    {
        return sysTypicalMonitorInfoMapper.updateSysTypicalMonitorInfo(sysTypicalMonitorInfo);
    }

    /**
     * 批量删除典型监控信息管理
     * 
     * @param ids 需要删除的典型监控信息管理主键
     * @return 结果
     */
    @Override
    public int deleteSysTypicalMonitorInfoByIds(Long[] ids)
    {
        return sysTypicalMonitorInfoMapper.deleteSysTypicalMonitorInfoByIds(ids);
    }

    /**
     * 删除典型监控信息管理信息
     * 
     * @param id 典型监控信息管理主键
     * @return 结果
     */
    @Override
    public int deleteSysTypicalMonitorInfoById(Long id)
    {
        return sysTypicalMonitorInfoMapper.deleteSysTypicalMonitorInfoById(id);
    }
    
    /**
     * 按设备类型统计典型监控信息
     * 
     * @return 设备类型统计结果列表
     */
    @Override
    public List<SysTypicalMonitorInfoStat> selectSysTypicalMonitorInfoStatByDeviceType()
    {
        return sysTypicalMonitorInfoMapper.selectSysTypicalMonitorInfoStatByDeviceType();
    }
}
