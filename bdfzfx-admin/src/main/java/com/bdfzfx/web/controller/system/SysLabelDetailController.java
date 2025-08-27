package com.bdfzfx.web.controller.system;

import com.bdfzfx.system.domain.SysLabelTask;
import com.bdfzfx.system.service.ISysLabelTaskService;
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
import com.bdfzfx.system.domain.SysLabelDetail;
import com.bdfzfx.system.service.ISysLabelDetailService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 样本标注详情
 * 
 * @author admin
 * @date 2025-08-26
 */
@RestController
@RequestMapping("/system/detail")
@Api(tags = "样本标注详情")
public class SysLabelDetailController extends BaseController
{
    @Autowired
    private ISysLabelDetailService sysLabelDetailService;

    @Autowired
    private ISysLabelTaskService sysLabelTaskService;

    /**
     * 查询样本标注详情列表
     */
    @PreAuthorize("@ss.hasPermi('system:detail:list')")
    @GetMapping("/list")
    @ApiOperation("查询样本标注详情列表")
    public TableDataInfo list(SysLabelDetail sysLabelDetail)
    {
        startPage();
        List<SysLabelDetail> list = sysLabelDetailService.selectSysLabelDetailList(sysLabelDetail);
        return getDataTable(list);
    }

    /**
     * 导出样本标注详情列表
     */
    @PreAuthorize("@ss.hasPermi('system:detail:export')")
    @Log(title = "样本标注详情", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出样本标注详情列表")
    public void export(HttpServletResponse response, SysLabelDetail sysLabelDetail)
    {
        List<SysLabelDetail> list = sysLabelDetailService.selectSysLabelDetailList(sysLabelDetail);
        ExcelUtil<SysLabelDetail> util = new ExcelUtil<SysLabelDetail>(SysLabelDetail.class);
        util.exportExcel(response, list, "样本标注详情数据");
    }

    /**
     * 获取样本标注详情详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:detail:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取样本标注详情详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysLabelDetailService.selectSysLabelDetailById(id));
    }

    /**
     * 新增样本标注详情
     */
    @PreAuthorize("@ss.hasPermi('system:detail:add')")
    @Log(title = "样本标注详情", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增样本标注详情")
    public AjaxResult add(@RequestBody SysLabelDetail sysLabelDetail)
    {
        return toAjax(sysLabelDetailService.insertSysLabelDetail(sysLabelDetail));
    }

    /**
     * 修改样本标注详情
     */
    @PreAuthorize("@ss.hasPermi('system:detail:edit')")
    @Log(title = "样本标注详情", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改样本标注详情")
    public AjaxResult edit(@RequestBody SysLabelDetail sysLabelDetail)
    {
        // 修改后更新标注任务表中已完成数量
        Long taskId = sysLabelDetail.getTaskId();
        if (taskId != null) {
            SysLabelDetail queryDetail = new SysLabelDetail();
            queryDetail.setTaskId(taskId);
            List<SysLabelDetail> sysLabelDetails = sysLabelDetailService.selectSysLabelDetailList(queryDetail);
            // 统计已完成数量 1 和 2 都认为是已完成
            long completedCount = sysLabelDetails.stream()
                    .filter(detail -> "1".equals(detail.getIsLabeled()) || "2".equals(detail.getIsLabeled()))
                    .count();
            SysLabelTask labelTask = sysLabelTaskService.selectSysLabelTaskByTaskId(taskId);
            if (labelTask != null) {
                labelTask.setCompletedCount(completedCount);
                labelTask.setSampleCount((long) sysLabelDetails.size());
                if (completedCount >= labelTask.getSampleCount()) {
                    labelTask.setStatus("2");
                }
                sysLabelTaskService.updateSysLabelTask(labelTask);
            }
        }

        return toAjax(sysLabelDetailService.updateSysLabelDetail(sysLabelDetail));
    }

    /**
     * 删除样本标注详情
     */
    @PreAuthorize("@ss.hasPermi('system:detail:remove')")
    @Log(title = "样本标注详情", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除样本标注详情")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysLabelDetailService.deleteSysLabelDetailByIds(ids));
    }
}
