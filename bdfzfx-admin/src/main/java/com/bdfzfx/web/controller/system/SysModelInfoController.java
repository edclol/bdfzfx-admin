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
import com.bdfzfx.system.domain.SysModelInfo;
import com.bdfzfx.system.service.ISysModelInfoService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 模型信息Controller
 * 
 * @author admin
 * @date 2025-08-21
 */
@RestController
@RequestMapping("/system/model")
@Api(tags = "模型信息")
public class SysModelInfoController extends BaseController
{
    @Autowired
    private ISysModelInfoService sysModelInfoService;

    /**
     * 查询模型信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:model:list')")
    @GetMapping("/list")
    @ApiOperation("查询模型信息列表")
    public TableDataInfo list(SysModelInfo sysModelInfo)
    {
        startPage();
        List<SysModelInfo> list = sysModelInfoService.selectSysModelInfoList(sysModelInfo);
        return getDataTable(list);
    }

    /**
     * 导出模型信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:model:export')")
    @Log(title = "模型信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出模型信息列表")
    public void export(HttpServletResponse response, SysModelInfo sysModelInfo)
    {
        List<SysModelInfo> list = sysModelInfoService.selectSysModelInfoList(sysModelInfo);
        ExcelUtil<SysModelInfo> util = new ExcelUtil<SysModelInfo>(SysModelInfo.class);
        util.exportExcel(response, list, "模型信息数据");
    }

    /**
     * 获取模型信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:model:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取模型信息详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysModelInfoService.selectSysModelInfoById(id));
    }

    /**
     * 新增模型信息
     */
    @PreAuthorize("@ss.hasPermi('system:model:add')")
    @Log(title = "模型信息", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增模型信息")
    public AjaxResult add(@RequestBody SysModelInfo sysModelInfo)
    {
        return toAjax(sysModelInfoService.insertSysModelInfo(sysModelInfo));
    }

    /**
     * 修改模型信息
     */
    @PreAuthorize("@ss.hasPermi('system:model:edit')")
    @Log(title = "模型信息", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改模型信息")
    public AjaxResult edit(@RequestBody SysModelInfo sysModelInfo)
    {
        return toAjax(sysModelInfoService.updateSysModelInfo(sysModelInfo));
    }

    /**
     * 删除模型信息
     */
    @PreAuthorize("@ss.hasPermi('system:model:remove')")
    @Log(title = "模型信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除模型信息")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysModelInfoService.deleteSysModelInfoByIds(ids));
    }
}
