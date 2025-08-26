package com.bdfzfx.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysLabelDetailMapper;
import com.bdfzfx.system.domain.SysLabelDetail;
import com.bdfzfx.system.service.ISysLabelDetailService;

/**
 * 样本标注详情Service业务层处理
 * 
 * @author admin
 * @date 2025-08-26
 */
@Service
public class SysLabelDetailServiceImpl implements ISysLabelDetailService 
{
    @Autowired
    private SysLabelDetailMapper sysLabelDetailMapper;

    /**
     * 查询样本标注详情
     * 
     * @param id 样本标注详情主键
     * @return 样本标注详情
     */
    @Override
    public SysLabelDetail selectSysLabelDetailById(Long id)
    {
        return sysLabelDetailMapper.selectSysLabelDetailById(id);
    }

    /**
     * 查询样本标注详情列表
     * 
     * @param sysLabelDetail 样本标注详情
     * @return 样本标注详情
     */
    @Override
    public List<SysLabelDetail> selectSysLabelDetailList(SysLabelDetail sysLabelDetail)
    {
        return sysLabelDetailMapper.selectSysLabelDetailList(sysLabelDetail);
    }

    /**
     * 新增样本标注详情
     * 
     * @param sysLabelDetail 样本标注详情
     * @return 结果
     */
    @Override
    public int insertSysLabelDetail(SysLabelDetail sysLabelDetail)
    {
        return sysLabelDetailMapper.insertSysLabelDetail(sysLabelDetail);
    }

    /**
     * 修改样本标注详情
     * 
     * @param sysLabelDetail 样本标注详情
     * @return 结果
     */
    @Override
    public int updateSysLabelDetail(SysLabelDetail sysLabelDetail)
    {
        return sysLabelDetailMapper.updateSysLabelDetail(sysLabelDetail);
    }

    /**
     * 批量删除样本标注详情
     * 
     * @param ids 需要删除的样本标注详情主键
     * @return 结果
     */
    @Override
    public int deleteSysLabelDetailByIds(Long[] ids)
    {
        return sysLabelDetailMapper.deleteSysLabelDetailByIds(ids);
    }

    /**
     * 删除样本标注详情信息
     * 
     * @param id 样本标注详情主键
     * @return 结果
     */
    @Override
    public int deleteSysLabelDetailById(Long id)
    {
        return sysLabelDetailMapper.deleteSysLabelDetailById(id);
    }
}
