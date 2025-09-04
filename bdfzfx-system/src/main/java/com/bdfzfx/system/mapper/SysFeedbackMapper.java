package com.bdfzfx.system.mapper;

import java.util.List;
import com.bdfzfx.system.domain.SysFeedback;

/**
 * 意见反馈Mapper接口
 * 
 * @author admin
 * @date 2025-09-04
 */
public interface SysFeedbackMapper 
{
    /**
     * 查询意见反馈
     * 
     * @param id 意见反馈主键
     * @return 意见反馈
     */
    public SysFeedback selectSysFeedbackById(Long id);

    /**
     * 查询意见反馈列表
     * 
     * @param sysFeedback 意见反馈
     * @return 意见反馈集合
     */
    public List<SysFeedback> selectSysFeedbackList(SysFeedback sysFeedback);

    /**
     * 新增意见反馈
     * 
     * @param sysFeedback 意见反馈
     * @return 结果
     */
    public int insertSysFeedback(SysFeedback sysFeedback);

    /**
     * 修改意见反馈
     * 
     * @param sysFeedback 意见反馈
     * @return 结果
     */
    public int updateSysFeedback(SysFeedback sysFeedback);

    /**
     * 删除意见反馈
     * 
     * @param id 意见反馈主键
     * @return 结果
     */
    public int deleteSysFeedbackById(Long id);

    /**
     * 批量删除意见反馈
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysFeedbackByIds(Long[] ids);
}
