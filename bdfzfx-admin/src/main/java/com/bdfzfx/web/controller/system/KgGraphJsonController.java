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
import com.bdfzfx.system.domain.KgGraphJson;
import com.bdfzfx.system.service.IKgGraphJsonService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 知识图谱JSON存储Controller
 * 
 * @author admin
 * @date 2025-08-26
 */
@RestController
@RequestMapping("/system/kg")
@Api(tags = "知识图谱JSON存储")
public class KgGraphJsonController extends BaseController
{
    @Autowired
    private IKgGraphJsonService kgGraphJsonService;

    /**
     * 查询知识图谱JSON存储列表
     */
    @PreAuthorize("@ss.hasPermi('system:kg:list')")
    @GetMapping("/list")
    @ApiOperation("查询知识图谱JSON存储列表")
    public TableDataInfo list(KgGraphJson kgGraphJson)
    {
        startPage();
        List<KgGraphJson> list = kgGraphJsonService.selectKgGraphJsonList(kgGraphJson);
        return getDataTable(list);
    }

    /**
     * 导出知识图谱JSON存储列表
     */
    @PreAuthorize("@ss.hasPermi('system:kg:export')")
    @Log(title = "知识图谱JSON存储", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出知识图谱JSON存储列表")
    public void export(HttpServletResponse response, KgGraphJson kgGraphJson)
    {
        List<KgGraphJson> list = kgGraphJsonService.selectKgGraphJsonList(kgGraphJson);
        ExcelUtil<KgGraphJson> util = new ExcelUtil<KgGraphJson>(KgGraphJson.class);
        util.exportExcel(response, list, "知识图谱JSON存储数据");
    }

    /**
     * 获取知识图谱JSON存储详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:kg:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取知识图谱JSON存储详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(kgGraphJsonService.selectKgGraphJsonById(id));
    }

    /**
     * 新增知识图谱JSON存储
     */
    @PreAuthorize("@ss.hasPermi('system:kg:add')")
    @Log(title = "知识图谱JSON存储", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增知识图谱JSON存储")
    public AjaxResult add(@RequestBody KgGraphJson kgGraphJson)
    {
        return toAjax(kgGraphJsonService.insertKgGraphJson(kgGraphJson));
    }

    /**
     * 修改知识图谱JSON存储
     */
    @PreAuthorize("@ss.hasPermi('system:kg:edit')")
    @Log(title = "知识图谱JSON存储", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改知识图谱JSON存储")
    public AjaxResult edit(@RequestBody KgGraphJson kgGraphJson)
    {
        kgGraphJson.setId(1L);
        return toAjax(kgGraphJsonService.updateKgGraphJson(kgGraphJson));
    }

    /**
     * 删除知识图谱JSON存储
     */
    @PreAuthorize("@ss.hasPermi('system:kg:remove')")
    @Log(title = "知识图谱JSON存储", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除知识图谱JSON存储")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(kgGraphJsonService.deleteKgGraphJsonByIds(ids));
    }
}
