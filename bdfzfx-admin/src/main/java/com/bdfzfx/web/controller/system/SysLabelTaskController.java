package com.bdfzfx.web.controller.system;

import java.util.Collections;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.bdfzfx.system.domain.SysLabelDetail;
import com.bdfzfx.system.domain.SysYxInfoAll;
import com.bdfzfx.system.service.ISysLabelDetailService;
import com.bdfzfx.system.service.ISysYxInfoAllService;
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
import com.bdfzfx.system.domain.SysLabelTask;
import com.bdfzfx.system.service.ISysLabelTaskService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;

/**
 * 样本标注任务Controller
 * 
 * @author admin
 * @date 2025-08-18
 */
@RestController
@RequestMapping("/system/task")
@Api(tags = "样本标注任务管理")
public class SysLabelTaskController extends BaseController
{
    @Autowired
    private ISysLabelTaskService sysLabelTaskService;


    @Autowired
    private ISysLabelDetailService sysLabelDetailService;

    @Autowired
    private ISysYxInfoAllService sysYxInfoAllService;

    /**
     * 查询样本标注任务列表
     */
    @PreAuthorize("@ss.hasPermi('system:task:list')")
    @GetMapping("/list")
    @ApiOperation("获取样本标注任务列表")
    public TableDataInfo list(SysLabelTask sysLabelTask)
    {
        startPage();
        List<SysLabelTask> list = sysLabelTaskService.selectSysLabelTaskList(sysLabelTask);
        return getDataTable(list);
    }

    /**
     * 导出样本标注任务列表
     */
    @PreAuthorize("@ss.hasPermi('system:task:export')")
    @Log(title = "样本标注任务", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出样本标注任务列表")
    public void export(HttpServletResponse response, SysLabelTask sysLabelTask)
    {
        List<SysLabelTask> list = sysLabelTaskService.selectSysLabelTaskList(sysLabelTask);
        ExcelUtil<SysLabelTask> util = new ExcelUtil<SysLabelTask>(SysLabelTask.class);
        util.exportExcel(response, list, "样本标注任务数据");
    }

    /**
     * 获取样本标注任务详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:task:query')")
    @GetMapping(value = "/{taskId}")
    @ApiOperation("获取样本标注任务详细信息")
    public AjaxResult getInfo(@PathVariable("taskId") Long taskId)
    {
        return success(sysLabelTaskService.selectSysLabelTaskByTaskId(taskId));
    }

    /**
     * 新增样本标注任务
     */
    @PreAuthorize("@ss.hasPermi('system:task:add')")
    @Log(title = "样本标注任务", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增样本标注任务")
    public AjaxResult add(@RequestBody SysLabelTask sysLabelTask)
    {
        sysLabelTaskService.insertSysLabelTaskAndGetId(sysLabelTask);
        // 添加数据
        List<SysYxInfoAll> list = sysYxInfoAllService.selectSysYxInfoAllList(new SysYxInfoAll());
        // 随机获取50个样本
        if (list.size() >= 50) {
            Collections.shuffle(list);
            list = list.subList(0, 50);
        }
        for (SysYxInfoAll sysYxInfoAll : list){
            SysLabelDetail sysLabelDetail = new SysLabelDetail();
            sysLabelDetail.setTaskId(sysLabelTask.getTaskId());
            sysLabelDetail.setRemoteSignalId(sysYxInfoAll.getYxId());
            sysLabelDetail.setMonitorId(sysYxInfoAll.getYxId());
            sysLabelDetail.setInfoName(sysYxInfoAll.getInfoName());
            sysLabelDetail.setSubstationId(sysYxInfoAll.getSubstationId());
            sysLabelDetail.setDeviceType(sysYxInfoAll.getDeviceType());
            sysLabelDetail.setDevicePrinciple(sysYxInfoAll.getDevicePrinciple());
            sysLabelDetail.setAlarmLevel(sysYxInfoAll.getAlarmLevel());
            sysLabelDetail.setIsLabeled("0");
            sysLabelDetail.setLabelUser("admin");
            sysLabelDetail.setSignalType("1");
            sysLabelDetail.setEntryTime(sysYxInfoAll.getCreateTime());
            sysLabelDetail.setMonitorContent("无");
            sysLabelDetailService.insertSysLabelDetail(sysLabelDetail);
        }

        return toAjax(1);
    }

    /**
     * 修改样本标注任务
     */
    @PreAuthorize("@ss.hasPermi('system:task:edit')")
    @Log(title = "样本标注任务", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改样本标注任务")
    public AjaxResult edit(@RequestBody SysLabelTask sysLabelTask)
    {
        return toAjax(sysLabelTaskService.updateSysLabelTask(sysLabelTask));
    }

    /**
     * 删除样本标注任务
     */
    @PreAuthorize("@ss.hasPermi('system:task:remove')")
    @Log(title = "样本标注任务", businessType = BusinessType.DELETE)
	@DeleteMapping("/{taskIds}")
    @ApiOperation("删除样本标注任务")
    public AjaxResult remove(@PathVariable Long[] taskIds)
    {
        return toAjax(sysLabelTaskService.deleteSysLabelTaskByTaskIds(taskIds));
    }
}
