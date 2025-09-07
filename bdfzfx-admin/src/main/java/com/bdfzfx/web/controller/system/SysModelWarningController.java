package com.bdfzfx.web.controller.system;

import com.bdfzfx.common.annotation.Log;
import com.bdfzfx.common.core.controller.BaseController;
import com.bdfzfx.common.core.domain.AjaxResult;
import com.bdfzfx.common.core.page.TableDataInfo;
import com.bdfzfx.common.enums.BusinessType;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.system.domain.SysModelWarning;
import com.bdfzfx.system.service.ISysModelWarningService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 模型预警Controller
 * 
 * @author admin
 * @date 2025-09-07
 */
@RestController
@RequestMapping("/system/warning")
@Api(tags = "模型预警")
public class SysModelWarningController extends BaseController
{
    @Autowired
    private ISysModelWarningService sysModelWarningService;

    /**
     * 查询模型预警列表
     */
    @PreAuthorize("@ss.hasPermi('system:warning:list')")
    @GetMapping("/list")
    @ApiOperation("查询模型预警列表")
    public TableDataInfo list(SysModelWarning sysModelWarning)
    {
        startPage();
        List<SysModelWarning> list = sysModelWarningService.selectSysModelWarningList(sysModelWarning);
        return getDataTable(list);
    }

    /**
     * 导出模型预警列表
     */
    @PreAuthorize("@ss.hasPermi('system:warning:export')")
    @Log(title = "模型预警", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出模型预警列表")
    public void export(HttpServletResponse response, SysModelWarning sysModelWarning)
    {
        List<SysModelWarning> list = sysModelWarningService.selectSysModelWarningList(sysModelWarning);
        ExcelUtil<SysModelWarning> util = new ExcelUtil<SysModelWarning>(SysModelWarning.class);
        util.exportExcel(response, list, "模型预警数据");
    }

    /**
     * 获取模型预警详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:warning:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取模型预警详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysModelWarningService.selectSysModelWarningById(id));
    }

    /**
     * 新增模型预警
     */
    @PreAuthorize("@ss.hasPermi('system:warning:add')")
    @Log(title = "模型预警", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增模型预警")
    public AjaxResult add(@RequestBody SysModelWarning sysModelWarning)
    {
        return toAjax(sysModelWarningService.insertSysModelWarning(sysModelWarning));
    }

    /**
     * 修改模型预警
     */
    @PreAuthorize("@ss.hasPermi('system:warning:edit')")
    @Log(title = "模型预警", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改模型预警")
    public AjaxResult edit(@RequestBody SysModelWarning sysModelWarning)
    {
        return toAjax(sysModelWarningService.updateSysModelWarning(sysModelWarning));
    }

    /**
     * 删除模型预警
     */
    @PreAuthorize("@ss.hasPermi('system:warning:remove')")
    @Log(title = "模型预警", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除模型预警")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysModelWarningService.deleteSysModelWarningByIds(ids));
    }
}
