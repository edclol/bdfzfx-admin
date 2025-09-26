package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysIntervalInfoMapper;
import com.bdfzfx.system.domain.SysIntervalInfo;
import com.bdfzfx.system.service.ISysIntervalInfoService;

/**
 * 间隔信息管理Service业务层处理
 * 
 * @author admin
 * @date 2025-09-26
 */
@Service
public class SysIntervalInfoServiceImpl implements ISysIntervalInfoService 
{
    @Autowired
    private SysIntervalInfoMapper sysIntervalInfoMapper;

    /**
     * 查询间隔信息管理
     * 
     * @param id 间隔信息管理主键
     * @return 间隔信息管理
     */
    @Override
    public SysIntervalInfo selectSysIntervalInfoById(Long id)
    {
        return sysIntervalInfoMapper.selectSysIntervalInfoById(id);
    }

    /**
     * 查询间隔信息管理列表
     * 
     * @param sysIntervalInfo 间隔信息管理
     * @return 间隔信息管理
     */
    @Override
    public List<SysIntervalInfo> selectSysIntervalInfoList(SysIntervalInfo sysIntervalInfo)
    {
        return sysIntervalInfoMapper.selectSysIntervalInfoList(sysIntervalInfo);
    }

    /**
     * 新增间隔信息管理
     * 
     * @param sysIntervalInfo 间隔信息管理
     * @return 结果
     */
    @Override
    public int insertSysIntervalInfo(SysIntervalInfo sysIntervalInfo)
    {
        sysIntervalInfo.setCreateTime(DateUtils.getNowDate());
        return sysIntervalInfoMapper.insertSysIntervalInfo(sysIntervalInfo);
    }

    /**
     * 修改间隔信息管理
     * 
     * @param sysIntervalInfo 间隔信息管理
     * @return 结果
     */
    @Override
    public int updateSysIntervalInfo(SysIntervalInfo sysIntervalInfo)
    {
        sysIntervalInfo.setUpdateTime(DateUtils.getNowDate());
        return sysIntervalInfoMapper.updateSysIntervalInfo(sysIntervalInfo);
    }

    /**
     * 批量删除间隔信息管理
     * 
     * @param ids 需要删除的间隔信息管理主键
     * @return 结果
     */
    @Override
    public int deleteSysIntervalInfoByIds(Long[] ids)
    {
        return sysIntervalInfoMapper.deleteSysIntervalInfoByIds(ids);
    }

    /**
     * 删除间隔信息管理信息
     * 
     * @param id 间隔信息管理主键
     * @return 结果
     */
    @Override
    public int deleteSysIntervalInfoById(Long id)
    {
        return sysIntervalInfoMapper.deleteSysIntervalInfoById(id);
    }
}
