package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysRemoteSignalCall;

/**
 * 遥信调用记录Service接口
 * 
 * @author ruoyi
 * @date 2025-08-17
 */
public interface ISysRemoteSignalCallService 
{
    /**
     * 查询遥信调用记录
     * 
     * @param id 遥信调用记录主键
     * @return 遥信调用记录
     */
    public SysRemoteSignalCall selectSysRemoteSignalCallById(Long id);

    /**
     * 查询遥信调用记录列表
     * 
     * @param sysRemoteSignalCall 遥信调用记录
     * @return 遥信调用记录集合
     */
    public List<SysRemoteSignalCall> selectSysRemoteSignalCallList(SysRemoteSignalCall sysRemoteSignalCall);

    /**
     * 新增遥信调用记录
     * 
     * @param sysRemoteSignalCall 遥信调用记录
     * @return 结果
     */
    public int insertSysRemoteSignalCall(SysRemoteSignalCall sysRemoteSignalCall);

    /**
     * 修改遥信调用记录
     * 
     * @param sysRemoteSignalCall 遥信调用记录
     * @return 结果
     */
    public int updateSysRemoteSignalCall(SysRemoteSignalCall sysRemoteSignalCall);

    /**
     * 批量删除遥信调用记录
     * 
     * @param ids 需要删除的遥信调用记录主键集合
     * @return 结果
     */
    public int deleteSysRemoteSignalCallByIds(Long[] ids);

    /**
     * 删除遥信调用记录信息
     * 
     * @param id 遥信调用记录主键
     * @return 结果
     */
    public int deleteSysRemoteSignalCallById(Long id);
}
