package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysModelWarning;

/**
 * 模型预警Service接口
 * 
 * @author admin
 * @date 2025-09-07
 */
public interface ISysModelWarningService 
{
    /**
     * 查询模型预警
     * 
     * @param id 模型预警主键
     * @return 模型预警
     */
    public SysModelWarning selectSysModelWarningById(Long id);

    /**
     * 查询模型预警列表
     * 
     * @param sysModelWarning 模型预警
     * @return 模型预警集合
     */
    public List<SysModelWarning> selectSysModelWarningList(SysModelWarning sysModelWarning);

    /**
     * 新增模型预警
     * 
     * @param sysModelWarning 模型预警
     * @return 结果
     */
    public int insertSysModelWarning(SysModelWarning sysModelWarning);

    /**
     * 修改模型预警
     * 
     * @param sysModelWarning 模型预警
     * @return 结果
     */
    public int updateSysModelWarning(SysModelWarning sysModelWarning);

    /**
     * 批量删除模型预警
     * 
     * @param ids 需要删除的模型预警主键集合
     * @return 结果
     */
    public int deleteSysModelWarningByIds(Long[] ids);

    /**
     * 删除模型预警信息
     * 
     * @param id 模型预警主键
     * @return 结果
     */
    public int deleteSysModelWarningById(Long id);
}
