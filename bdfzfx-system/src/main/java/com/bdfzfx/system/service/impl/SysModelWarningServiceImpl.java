package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysModelWarningMapper;
import com.bdfzfx.system.domain.SysModelWarning;
import com.bdfzfx.system.service.ISysModelWarningService;

/**
 * 模型预警Service业务层处理
 * 
 * @author admin
 * @date 2025-09-07
 */
@Service
public class SysModelWarningServiceImpl implements ISysModelWarningService 
{
    @Autowired
    private SysModelWarningMapper sysModelWarningMapper;

    /**
     * 查询模型预警
     * 
     * @param id 模型预警主键
     * @return 模型预警
     */
    @Override
    public SysModelWarning selectSysModelWarningById(Long id)
    {
        return sysModelWarningMapper.selectSysModelWarningById(id);
    }

    /**
     * 查询模型预警列表
     * 
     * @param sysModelWarning 模型预警
     * @return 模型预警
     */
    @Override
    public List<SysModelWarning> selectSysModelWarningList(SysModelWarning sysModelWarning)
    {
        return sysModelWarningMapper.selectSysModelWarningList(sysModelWarning);
    }

    /**
     * 新增模型预警
     * 
     * @param sysModelWarning 模型预警
     * @return 结果
     */
    @Override
    public int insertSysModelWarning(SysModelWarning sysModelWarning)
    {
        sysModelWarning.setCreateTime(DateUtils.getNowDate());
        return sysModelWarningMapper.insertSysModelWarning(sysModelWarning);
    }

    /**
     * 修改模型预警
     * 
     * @param sysModelWarning 模型预警
     * @return 结果
     */
    @Override
    public int updateSysModelWarning(SysModelWarning sysModelWarning)
    {
        sysModelWarning.setUpdateTime(DateUtils.getNowDate());
        return sysModelWarningMapper.updateSysModelWarning(sysModelWarning);
    }

    /**
     * 批量删除模型预警
     * 
     * @param ids 需要删除的模型预警主键
     * @return 结果
     */
    @Override
    public int deleteSysModelWarningByIds(Long[] ids)
    {
        return sysModelWarningMapper.deleteSysModelWarningByIds(ids);
    }

    /**
     * 删除模型预警信息
     * 
     * @param id 模型预警主键
     * @return 结果
     */
    @Override
    public int deleteSysModelWarningById(Long id)
    {
        return sysModelWarningMapper.deleteSysModelWarningById(id);
    }
}
