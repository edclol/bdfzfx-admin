package com.bdfzfx.system.service.impl;

import java.util.List;
import com.bdfzfx.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.bdfzfx.system.mapper.SysStopWordMapper;
import com.bdfzfx.system.domain.SysStopWord;
import com.bdfzfx.system.service.ISysStopWordService;

/**
 * 停用语料库Service业务层处理
 * 
 * @author admin
 * @date 2025-08-21
 */
@Service
public class SysStopWordServiceImpl implements ISysStopWordService 
{
    @Autowired
    private SysStopWordMapper sysStopWordMapper;

    /**
     * 查询停用语料库
     * 
     * @param id 停用语料库主键
     * @return 停用语料库
     */
    @Override
    public SysStopWord selectSysStopWordById(Long id)
    {
        return sysStopWordMapper.selectSysStopWordById(id);
    }

    /**
     * 查询停用语料库列表
     * 
     * @param sysStopWord 停用语料库
     * @return 停用语料库
     */
    @Override
    public List<SysStopWord> selectSysStopWordList(SysStopWord sysStopWord)
    {
        return sysStopWordMapper.selectSysStopWordList(sysStopWord);
    }

    /**
     * 新增停用语料库
     * 
     * @param sysStopWord 停用语料库
     * @return 结果
     */
    @Override
    public int insertSysStopWord(SysStopWord sysStopWord)
    {
        sysStopWord.setCreateTime(DateUtils.getNowDate());
        return sysStopWordMapper.insertSysStopWord(sysStopWord);
    }

    /**
     * 修改停用语料库
     * 
     * @param sysStopWord 停用语料库
     * @return 结果
     */
    @Override
    public int updateSysStopWord(SysStopWord sysStopWord)
    {
        sysStopWord.setUpdateTime(DateUtils.getNowDate());
        return sysStopWordMapper.updateSysStopWord(sysStopWord);
    }

    /**
     * 批量删除停用语料库
     * 
     * @param ids 需要删除的停用语料库主键
     * @return 结果
     */
    @Override
    public int deleteSysStopWordByIds(Long[] ids)
    {
        return sysStopWordMapper.deleteSysStopWordByIds(ids);
    }

    /**
     * 删除停用语料库信息
     * 
     * @param id 停用语料库主键
     * @return 结果
     */
    @Override
    public int deleteSysStopWordById(Long id)
    {
        return sysStopWordMapper.deleteSysStopWordById(id);
    }
}
