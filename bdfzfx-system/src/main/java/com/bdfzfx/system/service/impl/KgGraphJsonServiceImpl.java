package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.KgGraphJsonMapper;
import com.bdfzfx.system.domain.KgGraphJson;
import com.bdfzfx.system.service.IKgGraphJsonService;

/**
 * 知识图谱JSON存储Service业务层处理
 * 
 * @author admin
 * @date 2025-08-26
 */
@Service
public class KgGraphJsonServiceImpl implements IKgGraphJsonService 
{
    @Autowired
    private KgGraphJsonMapper kgGraphJsonMapper;

    /**
     * 查询知识图谱JSON存储
     * 
     * @param id 知识图谱JSON存储主键
     * @return 知识图谱JSON存储
     */
    @Override
    public KgGraphJson selectKgGraphJsonById(Long id)
    {
        return kgGraphJsonMapper.selectKgGraphJsonById(id);
    }

    /**
     * 查询知识图谱JSON存储列表
     * 
     * @param kgGraphJson 知识图谱JSON存储
     * @return 知识图谱JSON存储
     */
    @Override
    public List<KgGraphJson> selectKgGraphJsonList(KgGraphJson kgGraphJson)
    {
        return kgGraphJsonMapper.selectKgGraphJsonList(kgGraphJson);
    }

    /**
     * 新增知识图谱JSON存储
     * 
     * @param kgGraphJson 知识图谱JSON存储
     * @return 结果
     */
    @Override
    public int insertKgGraphJson(KgGraphJson kgGraphJson)
    {
        kgGraphJson.setCreateTime(DateUtils.getNowDate());
        return kgGraphJsonMapper.insertKgGraphJson(kgGraphJson);
    }

    /**
     * 修改知识图谱JSON存储
     * 
     * @param kgGraphJson 知识图谱JSON存储
     * @return 结果
     */
    @Override
    public int updateKgGraphJson(KgGraphJson kgGraphJson)
    {
        kgGraphJson.setUpdateTime(DateUtils.getNowDate());
        return kgGraphJsonMapper.updateKgGraphJson(kgGraphJson);
    }

    /**
     * 批量删除知识图谱JSON存储
     * 
     * @param ids 需要删除的知识图谱JSON存储主键
     * @return 结果
     */
    @Override
    public int deleteKgGraphJsonByIds(Long[] ids)
    {
        return kgGraphJsonMapper.deleteKgGraphJsonByIds(ids);
    }

    /**
     * 删除知识图谱JSON存储信息
     * 
     * @param id 知识图谱JSON存储主键
     * @return 结果
     */
    @Override
    public int deleteKgGraphJsonById(Long id)
    {
        return kgGraphJsonMapper.deleteKgGraphJsonById(id);
    }
}
