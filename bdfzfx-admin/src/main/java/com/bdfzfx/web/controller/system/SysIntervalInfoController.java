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
import com.bdfzfx.system.domain.SysIntervalInfo;
import com.bdfzfx.system.service.ISysIntervalInfoService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 间隔信息管理Controller
 * 
 * @author admin
 * @date 2025-09-26
 */
@RestController
@RequestMapping("/system/jginfo")
@Api(tags = "间隔信息管理")
public class SysIntervalInfoController extends BaseController
{
    @Autowired
    private ISysIntervalInfoService sysIntervalInfoService;

    /**
     * 查询间隔信息管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:jginfo:list')")
    @GetMapping("/list")
    @ApiOperation("查询间隔信息管理列表")
    public TableDataInfo list(SysIntervalInfo sysIntervalInfo)
    {
        startPage();
        List<SysIntervalInfo> list = sysIntervalInfoService.selectSysIntervalInfoList(sysIntervalInfo);
        return getDataTable(list);
    }

    /**
     * 导出间隔信息管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:jginfo:export')")
    @Log(title = "间隔信息管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出间隔信息管理列表")
    public void export(HttpServletResponse response, SysIntervalInfo sysIntervalInfo)
    {
        List<SysIntervalInfo> list = sysIntervalInfoService.selectSysIntervalInfoList(sysIntervalInfo);
        ExcelUtil<SysIntervalInfo> util = new ExcelUtil<SysIntervalInfo>(SysIntervalInfo.class);
        util.exportExcel(response, list, "间隔信息管理数据");
    }

    /**
     * 获取间隔信息管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:jginfo:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取间隔信息管理详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysIntervalInfoService.selectSysIntervalInfoById(id));
    }

    /**
     * 新增间隔信息管理
     */
    @PreAuthorize("@ss.hasPermi('system:jginfo:add')")
    @Log(title = "间隔信息管理", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增间隔信息管理")
    public AjaxResult add(@RequestBody SysIntervalInfo sysIntervalInfo)
    {
        return toAjax(sysIntervalInfoService.insertSysIntervalInfo(sysIntervalInfo));
    }

    /**
     * 修改间隔信息管理
     */
    @PreAuthorize("@ss.hasPermi('system:jginfo:edit')")
    @Log(title = "间隔信息管理", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改间隔信息管理")
    public AjaxResult edit(@RequestBody SysIntervalInfo sysIntervalInfo)
    {
        return toAjax(sysIntervalInfoService.updateSysIntervalInfo(sysIntervalInfo));
    }

    /**
     * 删除间隔信息管理
     */
    @PreAuthorize("@ss.hasPermi('system:jginfo:remove')")
    @Log(title = "间隔信息管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除间隔信息管理")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysIntervalInfoService.deleteSysIntervalInfoByIds(ids));
    }
}
