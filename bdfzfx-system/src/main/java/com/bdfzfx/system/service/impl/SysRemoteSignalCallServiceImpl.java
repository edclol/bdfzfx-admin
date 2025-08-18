package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysRemoteSignalCallMapper;
import com.bdfzfx.system.domain.SysRemoteSignalCall;
import com.bdfzfx.system.service.ISysRemoteSignalCallService;

/**
 * 遥信调用记录Service业务层处理
 * 
 *
 * @date 2025-08-17
 */
@Service
public class SysRemoteSignalCallServiceImpl implements ISysRemoteSignalCallService 
{
    @Autowired
    private SysRemoteSignalCallMapper sysRemoteSignalCallMapper;

    /**
     * 查询遥信调用记录
     * 
     * @param id 遥信调用记录主键
     * @return 遥信调用记录
     */
    @Override
    public SysRemoteSignalCall selectSysRemoteSignalCallById(Long id)
    {
        return sysRemoteSignalCallMapper.selectSysRemoteSignalCallById(id);
    }

    /**
     * 查询遥信调用记录列表
     * 
     * @param sysRemoteSignalCall 遥信调用记录
     * @return 遥信调用记录
     */
    @Override
    public List<SysRemoteSignalCall> selectSysRemoteSignalCallList(SysRemoteSignalCall sysRemoteSignalCall)
    {
        return sysRemoteSignalCallMapper.selectSysRemoteSignalCallList(sysRemoteSignalCall);
    }

    /**
     * 新增遥信调用记录
     * 
     * @param sysRemoteSignalCall 遥信调用记录
     * @return 结果
     */
    @Override
    public int insertSysRemoteSignalCall(SysRemoteSignalCall sysRemoteSignalCall)
    {
        sysRemoteSignalCall.setCreateTime(DateUtils.getNowDate());
        return sysRemoteSignalCallMapper.insertSysRemoteSignalCall(sysRemoteSignalCall);
    }

    /**
     * 修改遥信调用记录
     * 
     * @param sysRemoteSignalCall 遥信调用记录
     * @return 结果
     */
    @Override
    public int updateSysRemoteSignalCall(SysRemoteSignalCall sysRemoteSignalCall)
    {
        sysRemoteSignalCall.setUpdateTime(DateUtils.getNowDate());
        return sysRemoteSignalCallMapper.updateSysRemoteSignalCall(sysRemoteSignalCall);
    }

    /**
     * 批量删除遥信调用记录
     * 
     * @param ids 需要删除的遥信调用记录主键
     * @return 结果
     */
    @Override
    public int deleteSysRemoteSignalCallByIds(Long[] ids)
    {
        return sysRemoteSignalCallMapper.deleteSysRemoteSignalCallByIds(ids);
    }

    /**
     * 删除遥信调用记录信息
     * 
     * @param id 遥信调用记录主键
     * @return 结果
     */
    @Override
    public int deleteSysRemoteSignalCallById(Long id)
    {
        return sysRemoteSignalCallMapper.deleteSysRemoteSignalCallById(id);
    }
}
