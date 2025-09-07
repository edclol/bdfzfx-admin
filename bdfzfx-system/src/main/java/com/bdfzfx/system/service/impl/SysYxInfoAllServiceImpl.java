package com.bdfzfx.system.service.impl;

import java.util.List;

import com.bdfzfx.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysYxInfoAllMapper;
import com.bdfzfx.system.domain.SysYxInfoAll;
import com.bdfzfx.system.service.ISysYxInfoAllService;

/**
 * 样本库Service业务层处理
 * 
 * @author xx
 * @date 2025-08-18
 */
@Service
public class SysYxInfoAllServiceImpl implements ISysYxInfoAllService 
{
    @Autowired
    private SysYxInfoAllMapper sysYxInfoAllMapper;

    @Override
    public Integer countByType(String type) {
        SysYxInfoAll sysYxInfoAll = new SysYxInfoAll();
        sysYxInfoAll.setYxType(type);
        return sysYxInfoAllMapper.selectSysYxInfoAllList(sysYxInfoAll).size();
    }


    /**
     * 查询样本库
     * 
     * @param id 样本库主键
     * @return 样本库
     */
    @Override
    public SysYxInfoAll selectSysYxInfoAllById(Long id)
    {
        return sysYxInfoAllMapper.selectSysYxInfoAllById(id);
    }

    /**
     * 查询样本库列表
     * 
     * @param sysYxInfoAll 样本库
     * @return 样本库
     */
    @Override
    public List<SysYxInfoAll> selectSysYxInfoAllList(SysYxInfoAll sysYxInfoAll)
    {
        return sysYxInfoAllMapper.selectSysYxInfoAllList(sysYxInfoAll);
    }

    /**
     * 新增样本库
     * 
     * @param sysYxInfoAll 样本库
     * @return 结果
     */
    @Override
    public int insertSysYxInfoAll(SysYxInfoAll sysYxInfoAll)
    {
        return sysYxInfoAllMapper.insertSysYxInfoAll(sysYxInfoAll);
    }

    /**
     * 修改样本库
     * 
     * @param sysYxInfoAll 样本库
     * @return 结果
     */
    @Override
    public int updateSysYxInfoAll(SysYxInfoAll sysYxInfoAll)
    {
        return sysYxInfoAllMapper.updateSysYxInfoAll(sysYxInfoAll);
    }

    /**
     * 批量删除样本库
     * 
     * @param ids 需要删除的样本库主键
     * @return 结果
     */
    @Override
    public int deleteSysYxInfoAllByIds(Long[] ids)
    {
        return sysYxInfoAllMapper.deleteSysYxInfoAllByIds(ids);
    }

    /**
     * 删除样本库信息
     * 
     * @param id 样本库主键
     * @return 结果
     */
    @Override
    public int deleteSysYxInfoAllById(Long id)
    {
        return sysYxInfoAllMapper.deleteSysYxInfoAllById(id);
    }

    @Override
    public String importYxInfo(List<SysYxInfoAll> sysYxInfoAlls, boolean updateSupport, String operName)
    {
        if (sysYxInfoAlls == null || sysYxInfoAlls.isEmpty())
        {
            throw new RuntimeException("导入数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (SysYxInfoAll sysYxInfoAll : sysYxInfoAlls)
        {
            try
            {
                SysYxInfoAll yxInfo = sysYxInfoAllMapper.selectSysYxInfoAllById(sysYxInfoAll.getId());
                if (StringUtils.isNull(yxInfo)) {
//                    sysYxInfoAllMapper.insertSysYxInfoAll(sysYxInfoAll);
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("、账号 ").append(sysYxInfoAll.getId()).append(" 导入成功");
                } else {
//                    sysYxInfoAllMapper.updateSysYxInfoAll(sysYxInfoAll);
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("、账号 ").append(sysYxInfoAll.getId()).append(" 更新成功");
                }
            }
            catch (Exception e)
            {
                failureNum++;
                String msg = "<br/>" + failureNum + "、账号 " + sysYxInfoAll.getId() + " 导入失败：";
                failureMsg.append(msg).append(e.getMessage());
            }
        }
        if (failureNum > 0)
        {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new RuntimeException(failureMsg.toString());
        }
        else
        {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
            return successMsg.toString();
        }
    }

    @Override
    public String getVersion() {
        return "";
    }

}
