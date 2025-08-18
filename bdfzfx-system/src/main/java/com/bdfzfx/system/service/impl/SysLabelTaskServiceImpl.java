package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysLabelTaskMapper;
import com.bdfzfx.system.domain.SysLabelTask;
import com.bdfzfx.system.service.ISysLabelTaskService;

/**
 * 样本标注任务Service业务层处理
 * 
 * @author admin
 * @date 2025-08-18
 */
@Service
public class SysLabelTaskServiceImpl implements ISysLabelTaskService 
{
    @Autowired
    private SysLabelTaskMapper sysLabelTaskMapper;

    /**
     * 查询样本标注任务
     * 
     * @param taskId 样本标注任务主键
     * @return 样本标注任务
     */
    @Override
    public SysLabelTask selectSysLabelTaskByTaskId(Long taskId)
    {
        return sysLabelTaskMapper.selectSysLabelTaskByTaskId(taskId);
    }

    /**
     * 查询样本标注任务列表
     * 
     * @param sysLabelTask 样本标注任务
     * @return 样本标注任务
     */
    @Override
    public List<SysLabelTask> selectSysLabelTaskList(SysLabelTask sysLabelTask)
    {
        return sysLabelTaskMapper.selectSysLabelTaskList(sysLabelTask);
    }

    /**
     * 新增样本标注任务
     * 
     * @param sysLabelTask 样本标注任务
     * @return 结果
     */
    @Override
    public int insertSysLabelTask(SysLabelTask sysLabelTask)
    {
        sysLabelTask.setCreateTime(DateUtils.getNowDate());
        return sysLabelTaskMapper.insertSysLabelTask(sysLabelTask);
    }

    /**
     * 修改样本标注任务
     * 
     * @param sysLabelTask 样本标注任务
     * @return 结果
     */
    @Override
    public int updateSysLabelTask(SysLabelTask sysLabelTask)
    {
        sysLabelTask.setUpdateTime(DateUtils.getNowDate());
        return sysLabelTaskMapper.updateSysLabelTask(sysLabelTask);
    }

    /**
     * 批量删除样本标注任务
     * 
     * @param taskIds 需要删除的样本标注任务主键
     * @return 结果
     */
    @Override
    public int deleteSysLabelTaskByTaskIds(Long[] taskIds)
    {
        return sysLabelTaskMapper.deleteSysLabelTaskByTaskIds(taskIds);
    }

    /**
     * 删除样本标注任务信息
     * 
     * @param taskId 样本标注任务主键
     * @return 结果
     */
    @Override
    public int deleteSysLabelTaskByTaskId(Long taskId)
    {
        return sysLabelTaskMapper.deleteSysLabelTaskByTaskId(taskId);
    }
}
