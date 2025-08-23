package com.bdfzfx.web.controller.system;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.bdfzfx.common.annotation.Log;
import com.bdfzfx.common.core.controller.BaseController;
import com.bdfzfx.common.core.domain.AjaxResult;
import com.bdfzfx.common.enums.BusinessType;
import com.bdfzfx.system.domain.SysStopWord;
import com.bdfzfx.system.service.ISysStopWordService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 停用语料库Controller
 * 
 * @author admin
 * @date 2025-08-21
 */
@RestController
@RequestMapping("/system/word")
@Api(tags = "停用语料库")
public class SysStopWordController extends BaseController
{
    @Autowired
    private ISysStopWordService sysStopWordService;

    /**
     * 查询停用语料库列表
     */
    @PreAuthorize("@ss.hasPermi('system:word:list')")
    @GetMapping("/list")
    @ApiOperation("查询停用语料库列表")
    public TableDataInfo list(SysStopWord sysStopWord)
    {
        startPage();
        List<SysStopWord> list = sysStopWordService.selectSysStopWordList(sysStopWord);
        return getDataTable(list);
    }

    /**
     * 导出停用语料库列表
     */
    @PreAuthorize("@ss.hasPermi('system:word:export')")
    @Log(title = "停用语料库", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出停用语料库列表")
    public void export(HttpServletResponse response, SysStopWord sysStopWord)
    {
        List<SysStopWord> list = sysStopWordService.selectSysStopWordList(sysStopWord);
        ExcelUtil<SysStopWord> util = new ExcelUtil<SysStopWord>(SysStopWord.class);
        util.exportExcel(response, list, "停用语料库数据");
    }

    /**
     * 获取停用语料库详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:word:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取停用语料库详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysStopWordService.selectSysStopWordById(id));
    }

    /**
     * 新增停用语料库
     */
    @PreAuthorize("@ss.hasPermi('system:word:add')")
    @Log(title = "停用语料库", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增停用语料库")
    public AjaxResult add(@RequestBody SysStopWord sysStopWord)
    {
        return toAjax(sysStopWordService.insertSysStopWord(sysStopWord));
    }

    /**
     * 修改停用语料库
     */
    @PreAuthorize("@ss.hasPermi('system:word:edit')")
    @Log(title = "停用语料库", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改停用语料库")
    public AjaxResult edit(@RequestBody SysStopWord sysStopWord)
    {
        return toAjax(sysStopWordService.updateSysStopWord(sysStopWord));
    }

    /**
     * 删除停用语料库
     */
    @PreAuthorize("@ss.hasPermi('system:word:remove')")
    @Log(title = "停用语料库", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除停用语料库")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysStopWordService.deleteSysStopWordByIds(ids));
    }
}
