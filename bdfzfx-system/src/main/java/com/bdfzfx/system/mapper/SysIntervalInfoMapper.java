package com.bdfzfx.system.mapper;

import java.util.List;
import com.bdfzfx.system.domain.SysIntervalInfo;

/**
 * 间隔信息管理Mapper接口
 * 
 * @author admin
 * @date 2025-09-26
 */
public interface SysIntervalInfoMapper 
{
    /**
     * 查询间隔信息管理
     * 
     * @param id 间隔信息管理主键
     * @return 间隔信息管理
     */
    public SysIntervalInfo selectSysIntervalInfoById(Long id);

    /**
     * 查询间隔信息管理列表
     * 
     * @param sysIntervalInfo 间隔信息管理
     * @return 间隔信息管理集合
     */
    public List<SysIntervalInfo> selectSysIntervalInfoList(SysIntervalInfo sysIntervalInfo);

    /**
     * 新增间隔信息管理
     * 
     * @param sysIntervalInfo 间隔信息管理
     * @return 结果
     */
    public int insertSysIntervalInfo(SysIntervalInfo sysIntervalInfo);

    /**
     * 修改间隔信息管理
     * 
     * @param sysIntervalInfo 间隔信息管理
     * @return 结果
     */
    public int updateSysIntervalInfo(SysIntervalInfo sysIntervalInfo);

    /**
     * 删除间隔信息管理
     * 
     * @param id 间隔信息管理主键
     * @return 结果
     */
    public int deleteSysIntervalInfoById(Long id);

    /**
     * 批量删除间隔信息管理
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysIntervalInfoByIds(Long[] ids);
}
