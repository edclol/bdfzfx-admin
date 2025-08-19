package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysYxDataVersion;

/**
 * 样本数据版本管理Service接口
 * 
 * @author admin
 * @date 2025-08-19
 */
public interface ISysYxDataVersionService 
{
    /**
     * 查询样本数据版本管理
     * 
     * @param id 样本数据版本管理主键
     * @return 样本数据版本管理
     */
    public SysYxDataVersion selectSysYxDataVersionById(Long id);

    /**
     * 查询样本数据版本管理列表
     * 
     * @param sysYxDataVersion 样本数据版本管理
     * @return 样本数据版本管理集合
     */
    public List<SysYxDataVersion> selectSysYxDataVersionList(SysYxDataVersion sysYxDataVersion);

    /**
     * 新增样本数据版本管理
     * 
     * @param sysYxDataVersion 样本数据版本管理
     * @return 结果
     */
    public int insertSysYxDataVersion(SysYxDataVersion sysYxDataVersion);

    /**
     * 修改样本数据版本管理
     * 
     * @param sysYxDataVersion 样本数据版本管理
     * @return 结果
     */
    public int updateSysYxDataVersion(SysYxDataVersion sysYxDataVersion);

    /**
     * 批量删除样本数据版本管理
     * 
     * @param ids 需要删除的样本数据版本管理主键集合
     * @return 结果
     */
    public int deleteSysYxDataVersionByIds(Long[] ids);

    /**
     * 删除样本数据版本管理信息
     * 
     * @param id 样本数据版本管理主键
     * @return 结果
     */
    public int deleteSysYxDataVersionById(Long id);
}
