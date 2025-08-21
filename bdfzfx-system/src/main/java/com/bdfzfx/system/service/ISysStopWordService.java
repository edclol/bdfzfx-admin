package com.bdfzfx.system.service;

import java.util.List;
import com.bdfzfx.system.domain.SysStopWord;

/**
 * 停用语料库Service接口
 * 
 * @author admin
 * @date 2025-08-21
 */
public interface ISysStopWordService 
{
    /**
     * 查询停用语料库
     * 
     * @param id 停用语料库主键
     * @return 停用语料库
     */
    public SysStopWord selectSysStopWordById(Long id);

    /**
     * 查询停用语料库列表
     * 
     * @param sysStopWord 停用语料库
     * @return 停用语料库集合
     */
    public List<SysStopWord> selectSysStopWordList(SysStopWord sysStopWord);

    /**
     * 新增停用语料库
     * 
     * @param sysStopWord 停用语料库
     * @return 结果
     */
    public int insertSysStopWord(SysStopWord sysStopWord);

    /**
     * 修改停用语料库
     * 
     * @param sysStopWord 停用语料库
     * @return 结果
     */
    public int updateSysStopWord(SysStopWord sysStopWord);

    /**
     * 批量删除停用语料库
     * 
     * @param ids 需要删除的停用语料库主键集合
     * @return 结果
     */
    public int deleteSysStopWordByIds(Long[] ids);

    /**
     * 删除停用语料库信息
     * 
     * @param id 停用语料库主键
     * @return 结果
     */
    public int deleteSysStopWordById(Long id);
}
