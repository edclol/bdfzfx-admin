package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysMappingResult;

/**
 * 映射结果Service接口
 * 
 * @author admin
 * @date 2025-09-05
 */
public interface ISysMappingResultService 
{
    /**
     * 查询映射结果
     * 
     * @param id 映射结果主键
     * @return 映射结果
     */
    public SysMappingResult selectSysMappingResultById(Long id);

    /**
     * 查询映射结果列表
     * 
     * @param sysMappingResult 映射结果
     * @return 映射结果集合
     */
    public List<SysMappingResult> selectSysMappingResultList(SysMappingResult sysMappingResult);

    /**
     * 新增映射结果
     * 
     * @param sysMappingResult 映射结果
     * @return 结果
     */
    public int insertSysMappingResult(SysMappingResult sysMappingResult);

    /**
     * 修改映射结果
     * 
     * @param sysMappingResult 映射结果
     * @return 结果
     */
    public int updateSysMappingResult(SysMappingResult sysMappingResult);

    /**
     * 批量删除映射结果
     * 
     * @param ids 需要删除的映射结果主键集合
     * @return 结果
     */
    public int deleteSysMappingResultByIds(Long[] ids);

    /**
     * 删除映射结果信息
     * 
     * @param id 映射结果主键
     * @return 结果
     */
    public int deleteSysMappingResultById(Long id);
}
