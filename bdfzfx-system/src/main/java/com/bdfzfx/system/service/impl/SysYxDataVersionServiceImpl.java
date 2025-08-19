package com.bdfzfx.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysYxDataVersionMapper;
import com.bdfzfx.system.domain.SysYxDataVersion;
import com.bdfzfx.system.service.ISysYxDataVersionService;

/**
 * 样本数据版本管理Service业务层处理
 * 
 * @author admin
 * @date 2025-08-19
 */
@Service
public class SysYxDataVersionServiceImpl implements ISysYxDataVersionService 
{
    @Autowired
    private SysYxDataVersionMapper sysYxDataVersionMapper;

    /**
     * 查询样本数据版本管理
     * 
     * @param id 样本数据版本管理主键
     * @return 样本数据版本管理
     */
    @Override
    public SysYxDataVersion selectSysYxDataVersionById(Long id)
    {
        return sysYxDataVersionMapper.selectSysYxDataVersionById(id);
    }

    /**
     * 查询样本数据版本管理列表
     * 
     * @param sysYxDataVersion 样本数据版本管理
     * @return 样本数据版本管理
     */
    @Override
    public List<SysYxDataVersion> selectSysYxDataVersionList(SysYxDataVersion sysYxDataVersion)
    {
        return sysYxDataVersionMapper.selectSysYxDataVersionList(sysYxDataVersion);
    }

    /**
     * 新增样本数据版本管理
     * 
     * @param sysYxDataVersion 样本数据版本管理
     * @return 结果
     */
    @Override
    public int insertSysYxDataVersion(SysYxDataVersion sysYxDataVersion)
    {
        return sysYxDataVersionMapper.insertSysYxDataVersion(sysYxDataVersion);
    }

    /**
     * 修改样本数据版本管理
     * 
     * @param sysYxDataVersion 样本数据版本管理
     * @return 结果
     */
    @Override
    public int updateSysYxDataVersion(SysYxDataVersion sysYxDataVersion)
    {
        return sysYxDataVersionMapper.updateSysYxDataVersion(sysYxDataVersion);
    }

    /**
     * 批量删除样本数据版本管理
     * 
     * @param ids 需要删除的样本数据版本管理主键
     * @return 结果
     */
    @Override
    public int deleteSysYxDataVersionByIds(Long[] ids)
    {
        return sysYxDataVersionMapper.deleteSysYxDataVersionByIds(ids);
    }

    /**
     * 删除样本数据版本管理信息
     * 
     * @param id 样本数据版本管理主键
     * @return 结果
     */
    @Override
    public int deleteSysYxDataVersionById(Long id)
    {
        return sysYxDataVersionMapper.deleteSysYxDataVersionById(id);
    }
}
