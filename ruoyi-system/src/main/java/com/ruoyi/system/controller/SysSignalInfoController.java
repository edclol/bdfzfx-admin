package com.ruoyi.system.controller;

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
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.SysSignalInfo;
import com.ruoyi.system.service.ISysSignalInfoService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 信号信息Controller
 * 
 * @author ruoyi
 * @date 2025-08-16
 */
@RestController
@RequestMapping("/system/info")
public class SysSignalInfoController extends BaseController
{
    @Autowired
    private ISysSignalInfoService sysSignalInfoService;

    /**
     * 查询信号信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:info:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysSignalInfo sysSignalInfo)
    {
        startPage();
        List<SysSignalInfo> list = sysSignalInfoService.selectSysSignalInfoList(sysSignalInfo);
        return getDataTable(list);
    }

    /**
     * 导出信号信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:info:export')")
    @Log(title = "信号信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysSignalInfo sysSignalInfo)
    {
        List<SysSignalInfo> list = sysSignalInfoService.selectSysSignalInfoList(sysSignalInfo);
        ExcelUtil<SysSignalInfo> util = new ExcelUtil<SysSignalInfo>(SysSignalInfo.class);
        util.exportExcel(response, list, "信号信息数据");
    }

    /**
     * 获取信号信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:info:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysSignalInfoService.selectSysSignalInfoById(id));
    }

    /**
     * 新增信号信息
     */
    @PreAuthorize("@ss.hasPermi('system:info:add')")
    @Log(title = "信号信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysSignalInfo sysSignalInfo)
    {
        return toAjax(sysSignalInfoService.insertSysSignalInfo(sysSignalInfo));
    }

    /**
     * 修改信号信息
     */
    @PreAuthorize("@ss.hasPermi('system:info:edit')")
    @Log(title = "信号信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysSignalInfo sysSignalInfo)
    {
        return toAjax(sysSignalInfoService.updateSysSignalInfo(sysSignalInfo));
    }

    /**
     * 删除信号信息
     */
    @PreAuthorize("@ss.hasPermi('system:info:remove')")
    @Log(title = "信号信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysSignalInfoService.deleteSysSignalInfoByIds(ids));
    }
}
