package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysLabelTask;

/**
 * 样本标注任务Service接口
 * 
 * @author admin
 * @date 2025-08-18
 */
public interface ISysLabelTaskService 
{
    /**
     * 查询样本标注任务
     * 
     * @param taskId 样本标注任务主键
     * @return 样本标注任务
     */
    public SysLabelTask selectSysLabelTaskByTaskId(Long taskId);

    /**
     * 查询样本标注任务列表
     * 
     * @param sysLabelTask 样本标注任务
     * @return 样本标注任务集合
     */
    public List<SysLabelTask> selectSysLabelTaskList(SysLabelTask sysLabelTask);

    /**
     * 新增样本标注任务
     * 
     * @param sysLabelTask 样本标注任务
     * @return 结果
     */
    public int insertSysLabelTask(SysLabelTask sysLabelTask);

    /**
     * 修改样本标注任务
     * 
     * @param sysLabelTask 样本标注任务
     * @return 结果
     */
    public int updateSysLabelTask(SysLabelTask sysLabelTask);

    /**
     * 批量删除样本标注任务
     * 
     * @param taskIds 需要删除的样本标注任务主键集合
     * @return 结果
     */
    public int deleteSysLabelTaskByTaskIds(Long[] taskIds);

    /**
     * 删除样本标注任务信息
     * 
     * @param taskId 样本标注任务主键
     * @return 结果
     */
    public int deleteSysLabelTaskByTaskId(Long taskId);

    /**
     * 插入样本标注任务返回主键
     * @param sysLabelTask
     * @return
     */
    public  Long insertSysLabelTaskAndGetId(SysLabelTask sysLabelTask);
}
