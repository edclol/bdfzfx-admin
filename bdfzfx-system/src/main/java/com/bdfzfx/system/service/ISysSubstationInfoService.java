package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysSubstationInfo;

/**
 * 变电站信息Service接口
 * 
 * @author admin
 * @date 2025-09-05
 */
public interface ISysSubstationInfoService 
{
    /**
     * 查询变电站信息
     * 
     * @param id 变电站信息主键
     * @return 变电站信息
     */
    public SysSubstationInfo selectSysSubstationInfoById(Long id);

    /**
     * 查询变电站信息列表
     * 
     * @param sysSubstationInfo 变电站信息
     * @return 变电站信息集合
     */
    public List<SysSubstationInfo> selectSysSubstationInfoList(SysSubstationInfo sysSubstationInfo);

    /**
     * 新增变电站信息
     * 
     * @param sysSubstationInfo 变电站信息
     * @return 结果
     */
    public int insertSysSubstationInfo(SysSubstationInfo sysSubstationInfo);

    /**
     * 修改变电站信息
     * 
     * @param sysSubstationInfo 变电站信息
     * @return 结果
     */
    public int updateSysSubstationInfo(SysSubstationInfo sysSubstationInfo);

    /**
     * 批量删除变电站信息
     * 
     * @param ids 需要删除的变电站信息主键集合
     * @return 结果
     */
    public int deleteSysSubstationInfoByIds(Long[] ids);

    /**
     * 删除变电站信息信息
     * 
     * @param id 变电站信息主键
     * @return 结果
     */
    public int deleteSysSubstationInfoById(Long id);
}
