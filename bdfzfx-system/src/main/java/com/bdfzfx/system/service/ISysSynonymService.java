package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysSynonym;

/**
 * 同义词库Service接口
 * 
 * @author admin
 * @date 2025-08-19
 */
public interface ISysSynonymService 
{
    /**
     * 查询同义词库
     * 
     * @param id 同义词库主键
     * @return 同义词库
     */
    public SysSynonym selectSysSynonymById(Long id);

    /**
     * 查询同义词库列表
     * 
     * @param sysSynonym 同义词库
     * @return 同义词库集合
     */
    public List<SysSynonym> selectSysSynonymList(SysSynonym sysSynonym);

    /**
     * 新增同义词库
     * 
     * @param sysSynonym 同义词库
     * @return 结果
     */
    public int insertSysSynonym(SysSynonym sysSynonym);

    /**
     * 修改同义词库
     * 
     * @param sysSynonym 同义词库
     * @return 结果
     */
    public int updateSysSynonym(SysSynonym sysSynonym);

    /**
     * 批量删除同义词库
     * 
     * @param ids 需要删除的同义词库主键集合
     * @return 结果
     */
    public int deleteSysSynonymByIds(Long[] ids);

    /**
     * 删除同义词库信息
     * 
     * @param id 同义词库主键
     * @return 结果
     */
    public int deleteSysSynonymById(Long id);
}
