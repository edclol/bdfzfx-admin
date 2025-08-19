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
import com.bdfzfx.system.domain.SysYxDataVersion;
import com.bdfzfx.system.service.ISysYxDataVersionService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 样本数据版本管理Controller
 * 
 * @author admin
 * @date 2025-08-19
 */
@RestController
@RequestMapping("/system/version")
@Api(tags = "样本数据版本管理")
public class SysYxDataVersionController extends BaseController
{
    @Autowired
    private ISysYxDataVersionService sysYxDataVersionService;

    /**
     * 查询样本数据版本管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:version:list')")
    @GetMapping("/list")
    @ApiOperation("获取样本数据版本列表")
    public TableDataInfo list(SysYxDataVersion sysYxDataVersion)
    {
        startPage();
        List<SysYxDataVersion> list = sysYxDataVersionService.selectSysYxDataVersionList(sysYxDataVersion);
        return getDataTable(list);
    }

    /**
     * 导出样本数据版本管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:version:export')")
    @Log(title = "样本数据版本管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出样本数据版本列表")
    public void export(HttpServletResponse response, SysYxDataVersion sysYxDataVersion)
    {
        List<SysYxDataVersion> list = sysYxDataVersionService.selectSysYxDataVersionList(sysYxDataVersion);
        ExcelUtil<SysYxDataVersion> util = new ExcelUtil<SysYxDataVersion>(SysYxDataVersion.class);
        util.exportExcel(response, list, "样本数据版本管理数据");
    }

    /**
     * 获取样本数据版本管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:version:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取样本数据")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysYxDataVersionService.selectSysYxDataVersionById(id));
    }

    /**
     * 新增样本数据版本管理
     */
    @PreAuthorize("@ss.hasPermi('system:version:add')")
    @Log(title = "样本数据版本管理", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增样本数据版本")
    public AjaxResult add(@RequestBody SysYxDataVersion sysYxDataVersion)
    {
        return toAjax(sysYxDataVersionService.insertSysYxDataVersion(sysYxDataVersion));
    }

    /**
     * 修改样本数据版本管理
     */
    @PreAuthorize("@ss.hasPermi('system:version:edit')")
    @Log(title = "样本数据版本管理", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改样本数据版本")
    public AjaxResult edit(@RequestBody SysYxDataVersion sysYxDataVersion)
    {
        return toAjax(sysYxDataVersionService.updateSysYxDataVersion(sysYxDataVersion));
    }

    /**
     * 删除样本数据版本管理
     */
    @PreAuthorize("@ss.hasPermi('system:version:remove')")
    @Log(title = "样本数据版本管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除样本数据版本")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysYxDataVersionService.deleteSysYxDataVersionByIds(ids));
    }
}
