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
import com.bdfzfx.system.domain.SysSynonym;
import com.bdfzfx.system.service.ISysSynonymService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 同义词库Controller
 * 
 * @author admin
 * @date 2025-08-19
 */
@RestController
@RequestMapping("/system/synonym")
@Api(tags = "同义词库")
public class SysSynonymController extends BaseController
{
    @Autowired
    private ISysSynonymService sysSynonymService;

    /**
     * 查询同义词库列表
     */
    @PreAuthorize("@ss.hasPermi('system:synonym:list')")
    @GetMapping("/list")
    @ApiOperation("查询同义词库列表")
    public TableDataInfo list(SysSynonym sysSynonym)
    {
        startPage();
        List<SysSynonym> list = sysSynonymService.selectSysSynonymList(sysSynonym);
        return getDataTable(list);
    }

    /**
     * 导出同义词库列表
     */
    @PreAuthorize("@ss.hasPermi('system:synonym:export')")
    @Log(title = "同义词库", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出同义词库列表")
    public void export(HttpServletResponse response, SysSynonym sysSynonym)
    {
        List<SysSynonym> list = sysSynonymService.selectSysSynonymList(sysSynonym);
        ExcelUtil<SysSynonym> util = new ExcelUtil<SysSynonym>(SysSynonym.class);
        util.exportExcel(response, list, "同义词库数据");
    }

    /**
     * 获取同义词库详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:synonym:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取同义词库详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysSynonymService.selectSysSynonymById(id));
    }

    /**
     * 新增同义词库
     */
    @PreAuthorize("@ss.hasPermi('system:synonym:add')")
    @Log(title = "同义词库", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增同义词库")
    public AjaxResult add(@RequestBody SysSynonym sysSynonym)
    {
        return toAjax(sysSynonymService.insertSysSynonym(sysSynonym));
    }

    /**
     * 修改同义词库
     */
    @PreAuthorize("@ss.hasPermi('system:synonym:edit')")
    @Log(title = "同义词库", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改同义词库")
    public AjaxResult edit(@RequestBody SysSynonym sysSynonym)
    {
        return toAjax(sysSynonymService.updateSysSynonym(sysSynonym));
    }

    /**
     * 删除同义词库
     */
    @PreAuthorize("@ss.hasPermi('system:synonym:remove')")
    @Log(title = "同义词库", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除同义词库")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysSynonymService.deleteSysSynonymByIds(ids));
    }
}
