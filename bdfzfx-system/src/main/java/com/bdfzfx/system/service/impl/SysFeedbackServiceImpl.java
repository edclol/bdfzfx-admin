package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysFeedbackMapper;
import com.bdfzfx.system.domain.SysFeedback;
import com.bdfzfx.system.service.ISysFeedbackService;

/**
 * 意见反馈Service业务层处理
 * 
 * @author admin
 * @date 2025-09-04
 */
@Service
public class SysFeedbackServiceImpl implements ISysFeedbackService 
{
    @Autowired
    private SysFeedbackMapper sysFeedbackMapper;

    /**
     * 查询意见反馈
     * 
     * @param id 意见反馈主键
     * @return 意见反馈
     */
    @Override
    public SysFeedback selectSysFeedbackById(Long id)
    {
        return sysFeedbackMapper.selectSysFeedbackById(id);
    }

    /**
     * 查询意见反馈列表
     * 
     * @param sysFeedback 意见反馈
     * @return 意见反馈
     */
    @Override
    public List<SysFeedback> selectSysFeedbackList(SysFeedback sysFeedback)
    {
        return sysFeedbackMapper.selectSysFeedbackList(sysFeedback);
    }

    /**
     * 新增意见反馈
     * 
     * @param sysFeedback 意见反馈
     * @return 结果
     */
    @Override
    public int insertSysFeedback(SysFeedback sysFeedback)
    {
        sysFeedback.setCreateTime(DateUtils.getNowDate());
        return sysFeedbackMapper.insertSysFeedback(sysFeedback);
    }

    /**
     * 修改意见反馈
     * 
     * @param sysFeedback 意见反馈
     * @return 结果
     */
    @Override
    public int updateSysFeedback(SysFeedback sysFeedback)
    {
        sysFeedback.setUpdateTime(DateUtils.getNowDate());
        return sysFeedbackMapper.updateSysFeedback(sysFeedback);
    }

    /**
     * 批量删除意见反馈
     * 
     * @param ids 需要删除的意见反馈主键
     * @return 结果
     */
    @Override
    public int deleteSysFeedbackByIds(Long[] ids)
    {
        return sysFeedbackMapper.deleteSysFeedbackByIds(ids);
    }

    /**
     * 删除意见反馈信息
     * 
     * @param id 意见反馈主键
     * @return 结果
     */
    @Override
    public int deleteSysFeedbackById(Long id)
    {
        return sysFeedbackMapper.deleteSysFeedbackById(id);
    }
}
