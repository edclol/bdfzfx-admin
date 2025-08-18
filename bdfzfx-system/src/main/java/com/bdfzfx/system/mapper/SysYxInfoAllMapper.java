package com.bdfzfx.system.mapper;

import java.util.List;
import com.bdfzfx.system.domain.SysYxInfoAll;

/**
 * 样本库Mapper接口
 * 
 * @author xx
 * @date 2025-08-18
 */
public interface SysYxInfoAllMapper 
{
    /**
     * 查询样本库
     * 
     * @param id 样本库主键
     * @return 样本库
     */
    public SysYxInfoAll selectSysYxInfoAllById(Long id);

    /**
     * 查询样本库列表
     * 
     * @param sysYxInfoAll 样本库
     * @return 样本库集合
     */
    public List<SysYxInfoAll> selectSysYxInfoAllList(SysYxInfoAll sysYxInfoAll);

    /**
     * 新增样本库
     * 
     * @param sysYxInfoAll 样本库
     * @return 结果
     */
    public int insertSysYxInfoAll(SysYxInfoAll sysYxInfoAll);

    /**
     * 修改样本库
     * 
     * @param sysYxInfoAll 样本库
     * @return 结果
     */
    public int updateSysYxInfoAll(SysYxInfoAll sysYxInfoAll);

    /**
     * 删除样本库
     * 
     * @param id 样本库主键
     * @return 结果
     */
    public int deleteSysYxInfoAllById(Long id);

    /**
     * 批量删除样本库
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysYxInfoAllByIds(Long[] ids);
}
