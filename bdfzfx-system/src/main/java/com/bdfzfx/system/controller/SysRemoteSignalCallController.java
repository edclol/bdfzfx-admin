package com.bdfzfx.system.controller;

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
import com.bdfzfx.system.domain.SysRemoteSignalCall;
import com.bdfzfx.system.service.ISysRemoteSignalCallService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 遥信调用记录Controller
 * 
 * @author ruoyi
 * @date 2025-08-17
 */
@RestController
@RequestMapping("/system/call")
public class SysRemoteSignalCallController extends BaseController
{
    @Autowired
    private ISysRemoteSignalCallService sysRemoteSignalCallService;

    /**
     * 查询遥信调用记录列表
     */
    @PreAuthorize("@ss.hasPermi('system:call:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysRemoteSignalCall sysRemoteSignalCall)
    {
        startPage();
        List<SysRemoteSignalCall> list = sysRemoteSignalCallService.selectSysRemoteSignalCallList(sysRemoteSignalCall);
        return getDataTable(list);
    }

    /**
     * 导出遥信调用记录列表
     */
    @PreAuthorize("@ss.hasPermi('system:call:export')")
    @Log(title = "遥信调用记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysRemoteSignalCall sysRemoteSignalCall)
    {
        List<SysRemoteSignalCall> list = sysRemoteSignalCallService.selectSysRemoteSignalCallList(sysRemoteSignalCall);
        ExcelUtil<SysRemoteSignalCall> util = new ExcelUtil<SysRemoteSignalCall>(SysRemoteSignalCall.class);
        util.exportExcel(response, list, "遥信调用记录数据");
    }

    /**
     * 获取遥信调用记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:call:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysRemoteSignalCallService.selectSysRemoteSignalCallById(id));
    }

    /**
     * 新增遥信调用记录
     */
    @PreAuthorize("@ss.hasPermi('system:call:add')")
    @Log(title = "遥信调用记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysRemoteSignalCall sysRemoteSignalCall)
    {
        return toAjax(sysRemoteSignalCallService.insertSysRemoteSignalCall(sysRemoteSignalCall));
    }

    /**
     * 修改遥信调用记录
     */
    @PreAuthorize("@ss.hasPermi('system:call:edit')")
    @Log(title = "遥信调用记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysRemoteSignalCall sysRemoteSignalCall)
    {
        return toAjax(sysRemoteSignalCallService.updateSysRemoteSignalCall(sysRemoteSignalCall));
    }

    /**
     * 删除遥信调用记录
     */
    @PreAuthorize("@ss.hasPermi('system:call:remove')")
    @Log(title = "遥信调用记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysRemoteSignalCallService.deleteSysRemoteSignalCallByIds(ids));
    }
}
