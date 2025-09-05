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
import com.bdfzfx.system.domain.SysSubstationInfo;
import com.bdfzfx.system.service.ISysSubstationInfoService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 变电站信息Controller
 * 
 * @author admin
 * @date 2025-09-05
 */
@RestController
@RequestMapping("/system/stinfo")
@Api(tags = "变电站信息")
public class SysSubstationInfoController extends BaseController
{
    @Autowired
    private ISysSubstationInfoService sysSubstationInfoService;

    /**
     * 查询变电站信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:stinfo:list')")
    @GetMapping("/list")
    @ApiOperation("查询变电站信息列表")
    public TableDataInfo list(SysSubstationInfo sysSubstationInfo)
    {
        startPage();
        List<SysSubstationInfo> list = sysSubstationInfoService.selectSysSubstationInfoList(sysSubstationInfo);
        return getDataTable(list);
    }

    /**
     * 导出变电站信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:stinfo:export')")
    @Log(title = "变电站信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出变电站信息列表")
    public void export(HttpServletResponse response, SysSubstationInfo sysSubstationInfo)
    {
        List<SysSubstationInfo> list = sysSubstationInfoService.selectSysSubstationInfoList(sysSubstationInfo);
        ExcelUtil<SysSubstationInfo> util = new ExcelUtil<SysSubstationInfo>(SysSubstationInfo.class);
        util.exportExcel(response, list, "变电站信息数据");
    }

    /**
     * 获取变电站信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:stinfo:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取变电站信息详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysSubstationInfoService.selectSysSubstationInfoById(id));
    }

    /**
     * 新增变电站信息
     */
    @PreAuthorize("@ss.hasPermi('system:stinfo:add')")
    @Log(title = "变电站信息", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增变电站信息")
    public AjaxResult add(@RequestBody SysSubstationInfo sysSubstationInfo)
    {
        return toAjax(sysSubstationInfoService.insertSysSubstationInfo(sysSubstationInfo));
    }

    /**
     * 修改变电站信息
     */
    @PreAuthorize("@ss.hasPermi('system:stinfo:edit')")
    @Log(title = "变电站信息", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改变电站信息")
    public AjaxResult edit(@RequestBody SysSubstationInfo sysSubstationInfo)
    {
        return toAjax(sysSubstationInfoService.updateSysSubstationInfo(sysSubstationInfo));
    }

    /**
     * 删除变电站信息
     */
    @PreAuthorize("@ss.hasPermi('system:stinfo:remove')")
    @Log(title = "变电站信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除变电站信息")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysSubstationInfoService.deleteSysSubstationInfoByIds(ids));
    }
}
