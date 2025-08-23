package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysModelTrainRecordMapper;
import com.bdfzfx.system.domain.SysModelTrainRecord;
import com.bdfzfx.system.service.ISysModelTrainRecordService;

/**
 * 模型训练记录Service业务层处理
 * 
 * @author admin
 * @date 2025-08-21
 */
@Service
public class SysModelTrainRecordServiceImpl implements ISysModelTrainRecordService 
{
    @Autowired
    private SysModelTrainRecordMapper sysModelTrainRecordMapper;

    /**
     * 查询模型训练记录
     * 
     * @param id 模型训练记录主键
     * @return 模型训练记录
     */
    @Override
    public SysModelTrainRecord selectSysModelTrainRecordById(Long id)
    {
        return sysModelTrainRecordMapper.selectSysModelTrainRecordById(id);
    }

    /**
     * 查询模型训练记录列表
     * 
     * @param sysModelTrainRecord 模型训练记录
     * @return 模型训练记录
     */
    @Override
    public List<SysModelTrainRecord> selectSysModelTrainRecordList(SysModelTrainRecord sysModelTrainRecord)
    {
        return sysModelTrainRecordMapper.selectSysModelTrainRecordList(sysModelTrainRecord);
    }

    /**
     * 新增模型训练记录
     * 
     * @param sysModelTrainRecord 模型训练记录
     * @return 结果
     */
    @Override
    public int insertSysModelTrainRecord(SysModelTrainRecord sysModelTrainRecord)
    {
        sysModelTrainRecord.setCreateTime(DateUtils.getNowDate());
        return sysModelTrainRecordMapper.insertSysModelTrainRecord(sysModelTrainRecord);
    }

    /**
     * 修改模型训练记录
     * 
     * @param sysModelTrainRecord 模型训练记录
     * @return 结果
     */
    @Override
    public int updateSysModelTrainRecord(SysModelTrainRecord sysModelTrainRecord)
    {
        sysModelTrainRecord.setUpdateTime(DateUtils.getNowDate());
        return sysModelTrainRecordMapper.updateSysModelTrainRecord(sysModelTrainRecord);
    }

    /**
     * 批量删除模型训练记录
     * 
     * @param ids 需要删除的模型训练记录主键
     * @return 结果
     */
    @Override
    public int deleteSysModelTrainRecordByIds(Long[] ids)
    {
        return sysModelTrainRecordMapper.deleteSysModelTrainRecordByIds(ids);
    }

    /**
     * 删除模型训练记录信息
     * 
     * @param id 模型训练记录主键
     * @return 结果
     */
    @Override
    public int deleteSysModelTrainRecordById(Long id)
    {
        return sysModelTrainRecordMapper.deleteSysModelTrainRecordById(id);
    }
}
