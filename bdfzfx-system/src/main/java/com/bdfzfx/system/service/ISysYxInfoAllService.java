package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysYxInfoAll;

/**
 * 样本库Service接口
 * 
 * @author xx
 * @date 2025-08-18
 */
public interface ISysYxInfoAllService 
{

    /**
     * 根据类型统计数量
     */
    Integer countByType(String type);

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
     * 批量删除样本库
     * 
     * @param ids 需要删除的样本库主键集合
     * @return 结果
     */
    public int deleteSysYxInfoAllByIds(Long[] ids);

    /**
     * 删除样本库信息
     * 
     * @param id 样本库主键
     * @return 结果
     */
    public int deleteSysYxInfoAllById(Long id);
}
