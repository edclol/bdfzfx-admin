package com.bdfzfx.system.mapper;

import java.util.List;
import com.bdfzfx.system.domain.SysLabelDetail;

/**
 * 样本标注详情Mapper接口
 * 
 * @author admin
 * @date 2025-08-26
 */
public interface SysLabelDetailMapper 
{
    /**
     * 查询样本标注详情
     * 
     * @param id 样本标注详情主键
     * @return 样本标注详情
     */
    public SysLabelDetail selectSysLabelDetailById(Long id);

    /**
     * 查询样本标注详情列表
     * 
     * @param sysLabelDetail 样本标注详情
     * @return 样本标注详情集合
     */
    public List<SysLabelDetail> selectSysLabelDetailList(SysLabelDetail sysLabelDetail);

    /**
     * 新增样本标注详情
     * 
     * @param sysLabelDetail 样本标注详情
     * @return 结果
     */
    public int insertSysLabelDetail(SysLabelDetail sysLabelDetail);

    /**
     * 修改样本标注详情
     * 
     * @param sysLabelDetail 样本标注详情
     * @return 结果
     */
    public int updateSysLabelDetail(SysLabelDetail sysLabelDetail);

    /**
     * 删除样本标注详情
     * 
     * @param id 样本标注详情主键
     * @return 结果
     */
    public int deleteSysLabelDetailById(Long id);

    /**
     * 批量删除样本标注详情
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysLabelDetailByIds(Long[] ids);
}
