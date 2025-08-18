package com.bdfzfx.web.controller.system;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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
import com.bdfzfx.system.domain.SysYxInfoAll;
import com.bdfzfx.system.service.ISysYxInfoAllService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 样本库Controller
 * 
 * @author xx
 * @date 2025-08-18
 */
@RestController
@RequestMapping("/system/all")
@Api("样本库管理")
public class SysYxInfoAllController extends BaseController
{
    @Autowired
    private ISysYxInfoAllService sysYxInfoAllService;

    /**
     * 查询样本库列表
     */
    @PreAuthorize("@ss.hasPermi('system:all:list')")
    @GetMapping("/list")
    @ApiOperation("获取样本库列表")
    public TableDataInfo list(SysYxInfoAll sysYxInfoAll)
    {
        startPage();
        List<SysYxInfoAll> list = sysYxInfoAllService.selectSysYxInfoAllList(sysYxInfoAll);
        return getDataTable(list);
    }

    /**
     * 导出样本库列表
     */
    @PreAuthorize("@ss.hasPermi('system:all:export')")
    @Log(title = "样本库", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出样本库列表")
    public void export(HttpServletResponse response, SysYxInfoAll sysYxInfoAll)
    {
        List<SysYxInfoAll> list = sysYxInfoAllService.selectSysYxInfoAllList(sysYxInfoAll);
        ExcelUtil<SysYxInfoAll> util = new ExcelUtil<SysYxInfoAll>(SysYxInfoAll.class);
        util.exportExcel(response, list, "样本库数据");
    }

    /**
     * 获取样本库详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:all:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取样本库详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysYxInfoAllService.selectSysYxInfoAllById(id));
    }

    /**
     * 新增样本库
     */
    @PreAuthorize("@ss.hasPermi('system:all:add')")
    @ApiOperation("新增样本库")
    @Log(title = "样本库", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysYxInfoAll sysYxInfoAll)
    {
        return toAjax(sysYxInfoAllService.insertSysYxInfoAll(sysYxInfoAll));
    }

    /**
     * 修改样本库
     */
    @PreAuthorize("@ss.hasPermi('system:all:edit')")
    @Log(title = "样本库", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改样本库")
    public AjaxResult edit(@RequestBody SysYxInfoAll sysYxInfoAll)
    {
        return toAjax(sysYxInfoAllService.updateSysYxInfoAll(sysYxInfoAll));
    }

    /**
     * 删除样本库
     */
    @PreAuthorize("@ss.hasPermi('system:all:remove')")
    @Log(title = "样本库", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除样本库")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysYxInfoAllService.deleteSysYxInfoAllByIds(ids));
    }
}
