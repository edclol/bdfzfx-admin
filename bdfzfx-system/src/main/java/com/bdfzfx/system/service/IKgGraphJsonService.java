package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.KgGraphJson;

/**
 * 知识图谱JSON存储Service接口
 * 
 * @author admin
 * @date 2025-08-26
 */
public interface IKgGraphJsonService 
{
    /**
     * 查询知识图谱JSON存储
     * 
     * @param id 知识图谱JSON存储主键
     * @return 知识图谱JSON存储
     */
    public KgGraphJson selectKgGraphJsonById(Long id);

    /**
     * 查询知识图谱JSON存储列表
     * 
     * @param kgGraphJson 知识图谱JSON存储
     * @return 知识图谱JSON存储集合
     */
    public List<KgGraphJson> selectKgGraphJsonList(KgGraphJson kgGraphJson);

    /**
     * 新增知识图谱JSON存储
     * 
     * @param kgGraphJson 知识图谱JSON存储
     * @return 结果
     */
    public int insertKgGraphJson(KgGraphJson kgGraphJson);

    /**
     * 修改知识图谱JSON存储
     * 
     * @param kgGraphJson 知识图谱JSON存储
     * @return 结果
     */
    public int updateKgGraphJson(KgGraphJson kgGraphJson);

    /**
     * 批量删除知识图谱JSON存储
     * 
     * @param ids 需要删除的知识图谱JSON存储主键集合
     * @return 结果
     */
    public int deleteKgGraphJsonByIds(Long[] ids);

    /**
     * 删除知识图谱JSON存储信息
     * 
     * @param id 知识图谱JSON存储主键
     * @return 结果
     */
    public int deleteKgGraphJsonById(Long id);
}
