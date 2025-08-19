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
import com.bdfzfx.system.domain.SysTypicalMonitorInfo;
import com.bdfzfx.system.service.ISysTypicalMonitorInfoService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 典型监控信息管理Controller
 * 
 * @author admin
 * @date 2025-08-19
 */
@RestController
@RequestMapping("/system/monitor")
@Api(tags = "典型监控信息管理")
public class SysTypicalMonitorInfoController extends BaseController
{
    @Autowired
    private ISysTypicalMonitorInfoService sysTypicalMonitorInfoService;

    /**
     * 查询典型监控信息管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:monitor:list')")
    @GetMapping("/list")
    @ApiOperation("查询典型监控信息管理列表")
    public TableDataInfo list(SysTypicalMonitorInfo sysTypicalMonitorInfo)
    {
        startPage();
        List<SysTypicalMonitorInfo> list = sysTypicalMonitorInfoService.selectSysTypicalMonitorInfoList(sysTypicalMonitorInfo);
        return getDataTable(list);
    }

    /**
     * 导出典型监控信息管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:monitor:export')")
    @Log(title = "典型监控信息管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出典型监控信息管理列表")
    public void export(HttpServletResponse response, SysTypicalMonitorInfo sysTypicalMonitorInfo)
    {
        List<SysTypicalMonitorInfo> list = sysTypicalMonitorInfoService.selectSysTypicalMonitorInfoList(sysTypicalMonitorInfo);
        ExcelUtil<SysTypicalMonitorInfo> util = new ExcelUtil<SysTypicalMonitorInfo>(SysTypicalMonitorInfo.class);
        util.exportExcel(response, list, "典型监控信息管理数据");
    }

    /**
     * 获取典型监控信息管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:monitor:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取典型监控信息管理详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysTypicalMonitorInfoService.selectSysTypicalMonitorInfoById(id));
    }

    /**
     * 新增典型监控信息管理
     */
    @PreAuthorize("@ss.hasPermi('system:monitor:add')")
    @Log(title = "典型监控信息管理", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增典型监控信息管理")
    public AjaxResult add(@RequestBody SysTypicalMonitorInfo sysTypicalMonitorInfo)
    {
        return toAjax(sysTypicalMonitorInfoService.insertSysTypicalMonitorInfo(sysTypicalMonitorInfo));
    }

    /**
     * 修改典型监控信息管理
     */
    @PreAuthorize("@ss.hasPermi('system:monitor:edit')")
    @Log(title = "典型监控信息管理", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改典型监控信息管理")
    public AjaxResult edit(@RequestBody SysTypicalMonitorInfo sysTypicalMonitorInfo)
    {
        return toAjax(sysTypicalMonitorInfoService.updateSysTypicalMonitorInfo(sysTypicalMonitorInfo));
    }

    /**
     * 删除典型监控信息管理
     */
    @PreAuthorize("@ss.hasPermi('system:monitor:remove')")
    @Log(title = "典型监控信息管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除典型监控信息管理")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysTypicalMonitorInfoService.deleteSysTypicalMonitorInfoByIds(ids));
    }
}
