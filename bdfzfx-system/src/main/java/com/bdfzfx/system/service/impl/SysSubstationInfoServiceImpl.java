package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysSubstationInfoMapper;
import com.bdfzfx.system.domain.SysSubstationInfo;
import com.bdfzfx.system.service.ISysSubstationInfoService;

/**
 * 变电站信息Service业务层处理
 * 
 * @author admin
 * @date 2025-09-05
 */
@Service
public class SysSubstationInfoServiceImpl implements ISysSubstationInfoService 
{
    @Autowired
    private SysSubstationInfoMapper sysSubstationInfoMapper;

    /**
     * 查询变电站信息
     * 
     * @param id 变电站信息主键
     * @return 变电站信息
     */
    @Override
    public SysSubstationInfo selectSysSubstationInfoById(Long id)
    {
        return sysSubstationInfoMapper.selectSysSubstationInfoById(id);
    }

    /**
     * 查询变电站信息列表
     * 
     * @param sysSubstationInfo 变电站信息
     * @return 变电站信息
     */
    @Override
    public List<SysSubstationInfo> selectSysSubstationInfoList(SysSubstationInfo sysSubstationInfo)
    {
        return sysSubstationInfoMapper.selectSysSubstationInfoList(sysSubstationInfo);
    }

    /**
     * 新增变电站信息
     * 
     * @param sysSubstationInfo 变电站信息
     * @return 结果
     */
    @Override
    public int insertSysSubstationInfo(SysSubstationInfo sysSubstationInfo)
    {
        sysSubstationInfo.setCreateTime(DateUtils.getNowDate());
        return sysSubstationInfoMapper.insertSysSubstationInfo(sysSubstationInfo);
    }

    /**
     * 修改变电站信息
     * 
     * @param sysSubstationInfo 变电站信息
     * @return 结果
     */
    @Override
    public int updateSysSubstationInfo(SysSubstationInfo sysSubstationInfo)
    {
        sysSubstationInfo.setUpdateTime(DateUtils.getNowDate());
        return sysSubstationInfoMapper.updateSysSubstationInfo(sysSubstationInfo);
    }

    /**
     * 批量删除变电站信息
     * 
     * @param ids 需要删除的变电站信息主键
     * @return 结果
     */
    @Override
    public int deleteSysSubstationInfoByIds(Long[] ids)
    {
        return sysSubstationInfoMapper.deleteSysSubstationInfoByIds(ids);
    }

    /**
     * 删除变电站信息信息
     * 
     * @param id 变电站信息主键
     * @return 结果
     */
    @Override
    public int deleteSysSubstationInfoById(Long id)
    {
        return sysSubstationInfoMapper.deleteSysSubstationInfoById(id);
    }
}
