package com.bdfzfx.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysYxInfoAllMapper;
import com.bdfzfx.system.domain.SysYxInfoAll;
import com.bdfzfx.system.service.ISysYxInfoAllService;

/**
 * 样本库Service业务层处理
 * 
 * @author xx
 * @date 2025-08-18
 */
@Service
public class SysYxInfoAllServiceImpl implements ISysYxInfoAllService 
{
    @Autowired
    private SysYxInfoAllMapper sysYxInfoAllMapper;

    /**
     * 查询样本库
     * 
     * @param id 样本库主键
     * @return 样本库
     */
    @Override
    public SysYxInfoAll selectSysYxInfoAllById(Long id)
    {
        return sysYxInfoAllMapper.selectSysYxInfoAllById(id);
    }

    /**
     * 查询样本库列表
     * 
     * @param sysYxInfoAll 样本库
     * @return 样本库
     */
    @Override
    public List<SysYxInfoAll> selectSysYxInfoAllList(SysYxInfoAll sysYxInfoAll)
    {
        return sysYxInfoAllMapper.selectSysYxInfoAllList(sysYxInfoAll);
    }

    /**
     * 新增样本库
     * 
     * @param sysYxInfoAll 样本库
     * @return 结果
     */
    @Override
    public int insertSysYxInfoAll(SysYxInfoAll sysYxInfoAll)
    {
        return sysYxInfoAllMapper.insertSysYxInfoAll(sysYxInfoAll);
    }

    /**
     * 修改样本库
     * 
     * @param sysYxInfoAll 样本库
     * @return 结果
     */
    @Override
    public int updateSysYxInfoAll(SysYxInfoAll sysYxInfoAll)
    {
        return sysYxInfoAllMapper.updateSysYxInfoAll(sysYxInfoAll);
    }

    /**
     * 批量删除样本库
     * 
     * @param ids 需要删除的样本库主键
     * @return 结果
     */
    @Override
    public int deleteSysYxInfoAllByIds(Long[] ids)
    {
        return sysYxInfoAllMapper.deleteSysYxInfoAllByIds(ids);
    }

    /**
     * 删除样本库信息
     * 
     * @param id 样本库主键
     * @return 结果
     */
    @Override
    public int deleteSysYxInfoAllById(Long id)
    {
        return sysYxInfoAllMapper.deleteSysYxInfoAllById(id);
    }
}
