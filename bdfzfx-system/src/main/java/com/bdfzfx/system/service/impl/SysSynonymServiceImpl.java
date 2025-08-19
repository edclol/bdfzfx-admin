package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysSynonymMapper;
import com.bdfzfx.system.domain.SysSynonym;
import com.bdfzfx.system.service.ISysSynonymService;

/**
 * 同义词库Service业务层处理
 * 
 * @author admin
 * @date 2025-08-19
 */
@Service
public class SysSynonymServiceImpl implements ISysSynonymService 
{
    @Autowired
    private SysSynonymMapper sysSynonymMapper;

    /**
     * 查询同义词库
     * 
     * @param id 同义词库主键
     * @return 同义词库
     */
    @Override
    public SysSynonym selectSysSynonymById(Long id)
    {
        return sysSynonymMapper.selectSysSynonymById(id);
    }

    /**
     * 查询同义词库列表
     * 
     * @param sysSynonym 同义词库
     * @return 同义词库
     */
    @Override
    public List<SysSynonym> selectSysSynonymList(SysSynonym sysSynonym)
    {
        return sysSynonymMapper.selectSysSynonymList(sysSynonym);
    }

    /**
     * 新增同义词库
     * 
     * @param sysSynonym 同义词库
     * @return 结果
     */
    @Override
    public int insertSysSynonym(SysSynonym sysSynonym)
    {
        sysSynonym.setCreateTime(DateUtils.getNowDate());
        return sysSynonymMapper.insertSysSynonym(sysSynonym);
    }

    /**
     * 修改同义词库
     * 
     * @param sysSynonym 同义词库
     * @return 结果
     */
    @Override
    public int updateSysSynonym(SysSynonym sysSynonym)
    {
        sysSynonym.setUpdateTime(DateUtils.getNowDate());
        return sysSynonymMapper.updateSysSynonym(sysSynonym);
    }

    /**
     * 批量删除同义词库
     * 
     * @param ids 需要删除的同义词库主键
     * @return 结果
     */
    @Override
    public int deleteSysSynonymByIds(Long[] ids)
    {
        return sysSynonymMapper.deleteSysSynonymByIds(ids);
    }

    /**
     * 删除同义词库信息
     * 
     * @param id 同义词库主键
     * @return 结果
     */
    @Override
    public int deleteSysSynonymById(Long id)
    {
        return sysSynonymMapper.deleteSysSynonymById(id);
    }
}
