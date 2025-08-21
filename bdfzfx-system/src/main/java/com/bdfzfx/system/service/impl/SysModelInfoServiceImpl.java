package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysModelInfoMapper;
import com.bdfzfx.system.domain.SysModelInfo;
import com.bdfzfx.system.service.ISysModelInfoService;

/**
 * 模型信息Service业务层处理
 * 
 * @author admin
 * @date 2025-08-21
 */
@Service
public class SysModelInfoServiceImpl implements ISysModelInfoService 
{
    @Autowired
    private SysModelInfoMapper sysModelInfoMapper;

    /**
     * 查询模型信息
     * 
     * @param id 模型信息主键
     * @return 模型信息
     */
    @Override
    public SysModelInfo selectSysModelInfoById(Long id)
    {
        return sysModelInfoMapper.selectSysModelInfoById(id);
    }

    /**
     * 查询模型信息列表
     * 
     * @param sysModelInfo 模型信息
     * @return 模型信息
     */
    @Override
    public List<SysModelInfo> selectSysModelInfoList(SysModelInfo sysModelInfo)
    {
        return sysModelInfoMapper.selectSysModelInfoList(sysModelInfo);
    }

    /**
     * 新增模型信息
     * 
     * @param sysModelInfo 模型信息
     * @return 结果
     */
    @Override
    public int insertSysModelInfo(SysModelInfo sysModelInfo)
    {
        sysModelInfo.setCreateTime(DateUtils.getNowDate());
        return sysModelInfoMapper.insertSysModelInfo(sysModelInfo);
    }

    /**
     * 修改模型信息
     * 
     * @param sysModelInfo 模型信息
     * @return 结果
     */
    @Override
    public int updateSysModelInfo(SysModelInfo sysModelInfo)
    {
        sysModelInfo.setUpdateTime(DateUtils.getNowDate());
        return sysModelInfoMapper.updateSysModelInfo(sysModelInfo);
    }

    /**
     * 批量删除模型信息
     * 
     * @param ids 需要删除的模型信息主键
     * @return 结果
     */
    @Override
    public int deleteSysModelInfoByIds(Long[] ids)
    {
        return sysModelInfoMapper.deleteSysModelInfoByIds(ids);
    }

    /**
     * 删除模型信息信息
     * 
     * @param id 模型信息主键
     * @return 结果
     */
    @Override
    public int deleteSysModelInfoById(Long id)
    {
        return sysModelInfoMapper.deleteSysModelInfoById(id);
    }
}
