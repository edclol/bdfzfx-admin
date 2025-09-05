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
import com.bdfzfx.system.domain.SysMappingResult;
import com.bdfzfx.system.service.ISysMappingResultService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 映射结果Controller
 * 
 * @author admin
 * @date 2025-09-05
 */
@RestController
@RequestMapping("/system/mpresult")
@Api(tags = "映射结果")
public class SysMappingResultController extends BaseController
{
    @Autowired
    private ISysMappingResultService sysMappingResultService;

    /**
     * 查询映射结果列表
     */
    @PreAuthorize("@ss.hasPermi('system:mpresult:list')")
    @GetMapping("/list")
    @ApiOperation("查询映射结果列表")
    public TableDataInfo list(SysMappingResult sysMappingResult)
    {
        startPage();
        List<SysMappingResult> list = sysMappingResultService.selectSysMappingResultList(sysMappingResult);
        return getDataTable(list);
    }

    /**
     * 导出映射结果列表
     */
    @PreAuthorize("@ss.hasPermi('system:mpresult:export')")
    @Log(title = "映射结果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出映射结果列表")
    public void export(HttpServletResponse response, SysMappingResult sysMappingResult)
    {
        List<SysMappingResult> list = sysMappingResultService.selectSysMappingResultList(sysMappingResult);
        ExcelUtil<SysMappingResult> util = new ExcelUtil<SysMappingResult>(SysMappingResult.class);
        util.exportExcel(response, list, "映射结果数据");
    }

    /**
     * 获取映射结果详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:mpresult:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取映射结果详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysMappingResultService.selectSysMappingResultById(id));
    }

    /**
     * 新增映射结果
     */
    @PreAuthorize("@ss.hasPermi('system:mpresult:add')")
    @Log(title = "映射结果", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增映射结果")
    public AjaxResult add(@RequestBody SysMappingResult sysMappingResult)
    {
        return toAjax(sysMappingResultService.insertSysMappingResult(sysMappingResult));
    }

    /**
     * 修改映射结果
     */
    @PreAuthorize("@ss.hasPermi('system:mpresult:edit')")
    @Log(title = "映射结果", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改映射结果")
    public AjaxResult edit(@RequestBody SysMappingResult sysMappingResult)
    {
        return toAjax(sysMappingResultService.updateSysMappingResult(sysMappingResult));
    }

    /**
     * 删除映射结果
     */
    @PreAuthorize("@ss.hasPermi('system:mpresult:remove')")
    @Log(title = "映射结果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除映射结果")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysMappingResultService.deleteSysMappingResultByIds(ids));
    }
}
