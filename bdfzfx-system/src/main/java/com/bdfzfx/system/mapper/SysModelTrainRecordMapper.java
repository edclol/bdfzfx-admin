package com.bdfzfx.system.mapper;

import java.util.List;
import com.bdfzfx.system.domain.SysModelTrainRecord;

/**
 * 模型训练记录Mapper接口
 * 
 * @author admin
 * @date 2025-08-21
 */
public interface SysModelTrainRecordMapper 
{
    /**
     * 查询模型训练记录
     * 
     * @param id 模型训练记录主键
     * @return 模型训练记录
     */
    public SysModelTrainRecord selectSysModelTrainRecordById(Long id);

    /**
     * 查询模型训练记录列表
     * 
     * @param sysModelTrainRecord 模型训练记录
     * @return 模型训练记录集合
     */
    public List<SysModelTrainRecord> selectSysModelTrainRecordList(SysModelTrainRecord sysModelTrainRecord);

    /**
     * 新增模型训练记录
     * 
     * @param sysModelTrainRecord 模型训练记录
     * @return 结果
     */
    public int insertSysModelTrainRecord(SysModelTrainRecord sysModelTrainRecord);

    /**
     * 修改模型训练记录
     * 
     * @param sysModelTrainRecord 模型训练记录
     * @return 结果
     */
    public int updateSysModelTrainRecord(SysModelTrainRecord sysModelTrainRecord);

    /**
     * 删除模型训练记录
     * 
     * @param id 模型训练记录主键
     * @return 结果
     */
    public int deleteSysModelTrainRecordById(Long id);

    /**
     * 批量删除模型训练记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysModelTrainRecordByIds(Long[] ids);
}
