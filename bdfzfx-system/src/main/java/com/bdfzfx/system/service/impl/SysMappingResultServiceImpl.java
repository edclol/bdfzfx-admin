package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysMappingResultMapper;
import com.bdfzfx.system.domain.SysMappingResult;
import com.bdfzfx.system.service.ISysMappingResultService;

/**
 * 映射结果Service业务层处理
 * 
 * @author admin
 * @date 2025-09-05
 */
@Service
public class SysMappingResultServiceImpl implements ISysMappingResultService 
{
    @Autowired
    private SysMappingResultMapper sysMappingResultMapper;

    /**
     * 查询映射结果
     * 
     * @param id 映射结果主键
     * @return 映射结果
     */
    @Override
    public SysMappingResult selectSysMappingResultById(Long id)
    {
        return sysMappingResultMapper.selectSysMappingResultById(id);
    }

    /**
     * 查询映射结果列表
     * 
     * @param sysMappingResult 映射结果
     * @return 映射结果
     */
    @Override
    public List<SysMappingResult> selectSysMappingResultList(SysMappingResult sysMappingResult)
    {
        return sysMappingResultMapper.selectSysMappingResultList(sysMappingResult);
    }

    /**
     * 新增映射结果
     * 
     * @param sysMappingResult 映射结果
     * @return 结果
     */
    @Override
    public int insertSysMappingResult(SysMappingResult sysMappingResult)
    {
        sysMappingResult.setCreateTime(DateUtils.getNowDate());
        return sysMappingResultMapper.insertSysMappingResult(sysMappingResult);
    }

    /**
     * 修改映射结果
     * 
     * @param sysMappingResult 映射结果
     * @return 结果
     */
    @Override
    public int updateSysMappingResult(SysMappingResult sysMappingResult)
    {
        sysMappingResult.setUpdateTime(DateUtils.getNowDate());
        return sysMappingResultMapper.updateSysMappingResult(sysMappingResult);
    }

    /**
     * 批量删除映射结果
     * 
     * @param ids 需要删除的映射结果主键
     * @return 结果
     */
    @Override
    public int deleteSysMappingResultByIds(Long[] ids)
    {
        return sysMappingResultMapper.deleteSysMappingResultByIds(ids);
    }

    /**
     * 删除映射结果信息
     * 
     * @param id 映射结果主键
     * @return 结果
     */
    @Override
    public int deleteSysMappingResultById(Long id)
    {
        return sysMappingResultMapper.deleteSysMappingResultById(id);
    }
}
