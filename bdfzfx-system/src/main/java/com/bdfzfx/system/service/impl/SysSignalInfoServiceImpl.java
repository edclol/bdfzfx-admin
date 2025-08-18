package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysSignalInfoMapper;
import com.bdfzfx.system.domain.SysSignalInfo;
import com.bdfzfx.system.service.ISysSignalInfoService;

/**
 * 信号信息Service业务层处理
 * 
 *
 * @date 2025-08-16
 */
@Service
public class SysSignalInfoServiceImpl implements ISysSignalInfoService 
{
    @Autowired
    private SysSignalInfoMapper sysSignalInfoMapper;

    /**
     * 查询信号信息
     * 
     * @param id 信号信息主键
     * @return 信号信息
     */
    @Override
    public SysSignalInfo selectSysSignalInfoById(Long id)
    {
        return sysSignalInfoMapper.selectSysSignalInfoById(id);
    }

    /**
     * 查询信号信息列表
     * 
     * @param sysSignalInfo 信号信息
     * @return 信号信息
     */
    @Override
    public List<SysSignalInfo> selectSysSignalInfoList(SysSignalInfo sysSignalInfo)
    {
        return sysSignalInfoMapper.selectSysSignalInfoList(sysSignalInfo);
    }

    /**
     * 新增信号信息
     * 
     * @param sysSignalInfo 信号信息
     * @return 结果
     */
    @Override
    public int insertSysSignalInfo(SysSignalInfo sysSignalInfo)
    {
        sysSignalInfo.setCreateTime(DateUtils.getNowDate());
        return sysSignalInfoMapper.insertSysSignalInfo(sysSignalInfo);
    }

    /**
     * 修改信号信息
     * 
     * @param sysSignalInfo 信号信息
     * @return 结果
     */
    @Override
    public int updateSysSignalInfo(SysSignalInfo sysSignalInfo)
    {
        sysSignalInfo.setUpdateTime(DateUtils.getNowDate());
        return sysSignalInfoMapper.updateSysSignalInfo(sysSignalInfo);
    }

    /**
     * 批量删除信号信息
     * 
     * @param ids 需要删除的信号信息主键
     * @return 结果
     */
    @Override
    public int deleteSysSignalInfoByIds(Long[] ids)
    {
        return sysSignalInfoMapper.deleteSysSignalInfoByIds(ids);
    }

    /**
     * 删除信号信息信息
     * 
     * @param id 信号信息主键
     * @return 结果
     */
    @Override
    public int deleteSysSignalInfoById(Long id)
    {
        return sysSignalInfoMapper.deleteSysSignalInfoById(id);
    }
}
