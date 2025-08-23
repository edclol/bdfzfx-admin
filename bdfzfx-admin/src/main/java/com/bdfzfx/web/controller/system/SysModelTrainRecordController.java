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
import com.bdfzfx.system.domain.SysModelTrainRecord;
import com.bdfzfx.system.service.ISysModelTrainRecordService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 模型训练记录Controller
 * 
 * @author admin
 * @date 2025-08-21
 */
@RestController
@RequestMapping("/system/record")
@Api(tags = "模型训练记录")
public class SysModelTrainRecordController extends BaseController
{
    @Autowired
    private ISysModelTrainRecordService sysModelTrainRecordService;

    /**
     * 查询模型训练记录列表
     */
    @PreAuthorize("@ss.hasPermi('system:record:list')")
    @GetMapping("/list")
    @ApiOperation("查询模型训练记录列表")
    public TableDataInfo list(SysModelTrainRecord sysModelTrainRecord)
    {
        startPage();
        List<SysModelTrainRecord> list = sysModelTrainRecordService.selectSysModelTrainRecordList(sysModelTrainRecord);
        return getDataTable(list);
    }

    /**
     * 导出模型训练记录列表
     */
    @PreAuthorize("@ss.hasPermi('system:record:export')")
    @Log(title = "模型训练记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出模型训练记录列表")
    public void export(HttpServletResponse response, SysModelTrainRecord sysModelTrainRecord)
    {
        List<SysModelTrainRecord> list = sysModelTrainRecordService.selectSysModelTrainRecordList(sysModelTrainRecord);
        ExcelUtil<SysModelTrainRecord> util = new ExcelUtil<SysModelTrainRecord>(SysModelTrainRecord.class);
        util.exportExcel(response, list, "模型训练记录数据");
    }

    /**
     * 获取模型训练记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:record:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取模型训练记录详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysModelTrainRecordService.selectSysModelTrainRecordById(id));
    }

    /**
     * 新增模型训练记录
     */
    @PreAuthorize("@ss.hasPermi('system:record:add')")
    @Log(title = "模型训练记录", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增模型训练记录")
    public AjaxResult add(@RequestBody SysModelTrainRecord sysModelTrainRecord)
    {
        return toAjax(sysModelTrainRecordService.insertSysModelTrainRecord(sysModelTrainRecord));
    }

    /**
     * 修改模型训练记录
     */
    @PreAuthorize("@ss.hasPermi('system:record:edit')")
    @Log(title = "模型训练记录", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改模型训练记录")
    public AjaxResult edit(@RequestBody SysModelTrainRecord sysModelTrainRecord)
    {
        return toAjax(sysModelTrainRecordService.updateSysModelTrainRecord(sysModelTrainRecord));
    }

    /**
     * 删除模型训练记录
     */
    @PreAuthorize("@ss.hasPermi('system:record:remove')")
    @Log(title = "模型训练记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除模型训练记录")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysModelTrainRecordService.deleteSysModelTrainRecordByIds(ids));
    }
}
