package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysModelInfo;

/**
 * 模型信息Service接口
 * 
 * @author admin
 * @date 2025-08-21
 */
public interface ISysModelInfoService 
{
    /**
     * 查询模型信息
     * 
     * @param id 模型信息主键
     * @return 模型信息
     */
    public SysModelInfo selectSysModelInfoById(Long id);

    /**
     * 查询模型信息列表
     * 
     * @param sysModelInfo 模型信息
     * @return 模型信息集合
     */
    public List<SysModelInfo> selectSysModelInfoList(SysModelInfo sysModelInfo);

    /**
     * 新增模型信息
     * 
     * @param sysModelInfo 模型信息
     * @return 结果
     */
    public int insertSysModelInfo(SysModelInfo sysModelInfo);

    /**
     * 修改模型信息
     * 
     * @param sysModelInfo 模型信息
     * @return 结果
     */
    public int updateSysModelInfo(SysModelInfo sysModelInfo);

    /**
     * 批量删除模型信息
     * 
     * @param ids 需要删除的模型信息主键集合
     * @return 结果
     */
    public int deleteSysModelInfoByIds(Long[] ids);

    /**
     * 删除模型信息信息
     * 
     * @param id 模型信息主键
     * @return 结果
     */
    public int deleteSysModelInfoById(Long id);
}
