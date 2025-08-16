package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SysSignalInfo;

/**
 * 信号信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-08-16
 */
public interface SysSignalInfoMapper 
{
    /**
     * 查询信号信息
     * 
     * @param id 信号信息主键
     * @return 信号信息
     */
    public SysSignalInfo selectSysSignalInfoById(Long id);

    /**
     * 查询信号信息列表
     * 
     * @param sysSignalInfo 信号信息
     * @return 信号信息集合
     */
    public List<SysSignalInfo> selectSysSignalInfoList(SysSignalInfo sysSignalInfo);

    /**
     * 新增信号信息
     * 
     * @param sysSignalInfo 信号信息
     * @return 结果
     */
    public int insertSysSignalInfo(SysSignalInfo sysSignalInfo);

    /**
     * 修改信号信息
     * 
     * @param sysSignalInfo 信号信息
     * @return 结果
     */
    public int updateSysSignalInfo(SysSignalInfo sysSignalInfo);

    /**
     * 删除信号信息
     * 
     * @param id 信号信息主键
     * @return 结果
     */
    public int deleteSysSignalInfoById(Long id);

    /**
     * 批量删除信号信息
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysSignalInfoByIds(Long[] ids);
}
