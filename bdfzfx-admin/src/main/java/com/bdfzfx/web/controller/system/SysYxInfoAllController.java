package com.bdfzfx.web.controller.system;

import java.util.*;
import javax.servlet.http.HttpServletResponse;

import com.bdfzfx.common.core.domain.model.LoginUser;
import com.bdfzfx.common.utils.ServletUtils;
import com.bdfzfx.framework.web.service.TokenService;
import com.bdfzfx.system.domain.StatItem;
import com.bdfzfx.system.domain.SysYxInfoStatResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.cache.annotation.Cacheable;
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
import com.bdfzfx.system.domain.SysYxInfoAll;
import com.bdfzfx.system.service.ISysYxInfoAllService;
import com.bdfzfx.common.utils.poi.ExcelUtil;
import com.bdfzfx.common.core.page.TableDataInfo;
import org.springframework.web.multipart.MultipartFile;

/**
 * 样本库Controller
 * 
 * @author xx
 * @date 2025-08-18
 */
@RestController
@RequestMapping("/system/all")
@Api(tags = "样本库管理")
public class SysYxInfoAllController extends BaseController
{
    @Autowired
    private ISysYxInfoAllService sysYxInfoAllService;

    @Autowired
    private TokenService tokenService;

    /**
     *  样本版本管理
     */
    @PreAuthorize("@ss.hasPermi('system:all:list')")
    @ApiOperation("样本版本管理")
    @GetMapping("/version")
    public AjaxResult getVersion()
    {
        return success(sysYxInfoAllService.getVersion());
    }


    /**
     * 样本上传导入接口
     *
     */
    @Log(title = "样本上传导入", businessType = BusinessType.IMPORT)
    @PreAuthorize("@ss.hasPermi('system:all:edit')")
    @PostMapping("/importData")
    @ApiOperation("样本上传导入")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception
    {
        ExcelUtil<SysYxInfoAll> util = new ExcelUtil<SysYxInfoAll>(SysYxInfoAll.class);
        List<SysYxInfoAll> userList = util.importExcel(file.getInputStream());
        LoginUser loginUser = tokenService.getLoginUser(ServletUtils.getRequest());
        String operName = loginUser.getUsername();
        String message = sysYxInfoAllService.importYxInfo(userList, updateSupport, operName);
        return AjaxResult.success(message);
    }

    /**
     * 导入模板下载
     *
     */
    @PreAuthorize("@ss.hasPermi('system:all:list')")
    @GetMapping("/importTemplate")
    @ApiOperation("样本导入模板下载")
    public AjaxResult importTemplate()
    {
        ExcelUtil<SysYxInfoAll> util = new ExcelUtil<SysYxInfoAll>(SysYxInfoAll.class);
        return util.importTemplateExcel("样本数据");
    }
    
    /**
     * 获取样本库数据统计信息
     */
    @PreAuthorize("@ss.hasPermi('system:all:list')")
    @ApiOperation("获取样本库数据统计")
    @GetMapping("/stat")
    @Cacheable(value = "sysYxInfoStat", key = "'stat'", unless = "#result == null")
    public AjaxResult getStat() {
        // 获取各类设备的数量
        Integer yici = sysYxInfoAllService.countByType("一次设备");
        Integer erci = sysYxInfoAllService.countByType("二次设备");
        Integer zidong = sysYxInfoAllService.countByType("自动装置");
        Integer jiaozhliu = sysYxInfoAllService.countByType("站用交直流");
        Integer gongyong = sysYxInfoAllService.countByType("公用设备");
        Integer fukong = sysYxInfoAllService.countByType("辅控装置");

        // 计算总量
        Integer total = yici + erci + zidong + jiaozhliu + gongyong + fukong;

        // 构建统计结果
        List<StatItem> categories = Arrays.asList(
                new StatItem("一次设备", yici),
                new StatItem("二次设备", erci),
                new StatItem("自动装置", zidong),
                new StatItem("站用交直流", jiaozhliu),
                new StatItem("公用设备", gongyong),
                new StatItem("辅控装置", fukong)
        );

        SysYxInfoStatResult result = new SysYxInfoStatResult(total, categories);

        return success(result);
    }



    /**
     * 查询样本库列表
     */
    @PreAuthorize("@ss.hasPermi('system:all:list')")
    @GetMapping("/list")
    @ApiOperation("获取样本库列表")
    public TableDataInfo list(SysYxInfoAll sysYxInfoAll)
    {
        startPage();
        List<SysYxInfoAll> list = sysYxInfoAllService.selectSysYxInfoAllList(sysYxInfoAll);
        return getDataTable(list);
    }

    /**
     * 查询随机样本库列表
     */
    @PreAuthorize("@ss.hasPermi('system:all:list')")
    @GetMapping("/list/random")
    @ApiOperation("获取随机样本库列表")
    public TableDataInfo listRandom(SysYxInfoAll sysYxInfoAll)
    {
        startPage();
        List<SysYxInfoAll> list = sysYxInfoAllService.selectSysYxInfoAllList(sysYxInfoAll);
        // 随机获取1000个样本
        if (list.size() >= 1000) {
            Collections.shuffle(list);
            list = list.subList(0, 1000);
        }
        return getDataTable(list);
    }

    /**
     * 导出样本库列表
     */
    @PreAuthorize("@ss.hasPermi('system:all:export')")
    @Log(title = "样本库", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出样本库列表")
    public void export(HttpServletResponse response, SysYxInfoAll sysYxInfoAll)
    {
        List<SysYxInfoAll> list = sysYxInfoAllService.selectSysYxInfoAllList(sysYxInfoAll);
        ExcelUtil<SysYxInfoAll> util = new ExcelUtil<SysYxInfoAll>(SysYxInfoAll.class);
        util.exportExcel(response, list, "样本库数据");
    }
    /**
     * 导出1000样本库列表
     */
    @PreAuthorize("@ss.hasPermi('system:all:export')")
    @Log(title = "样本库", businessType = BusinessType.EXPORT)
    @PostMapping("/export/random")
    @ApiOperation("导出样本库列表")
    public void exportRandom(HttpServletResponse response, SysYxInfoAll sysYxInfoAll)
    {
        List<SysYxInfoAll> list = sysYxInfoAllService.selectSysYxInfoAllList(sysYxInfoAll);
        // 随机获取1000个样本
        if (list.size() >= 1000) {
            Collections.shuffle(list);
            list = list.subList(0, 1000);
        }
        ExcelUtil<SysYxInfoAll> util = new ExcelUtil<SysYxInfoAll>(SysYxInfoAll.class);
        util.exportExcel(response, list, "样本库数据");
    }

    /**
     * 获取样本库详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:all:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取样本库详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(sysYxInfoAllService.selectSysYxInfoAllById(id));
    }

    /**
     * 新增样本库
     */
    @PreAuthorize("@ss.hasPermi('system:all:add')")
    @ApiOperation("新增样本库")
    @Log(title = "样本库", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysYxInfoAll sysYxInfoAll)
    {
        return toAjax(sysYxInfoAllService.insertSysYxInfoAll(sysYxInfoAll));
    }

    /**
     * 修改样本库
     */
    @PreAuthorize("@ss.hasPermi('system:all:edit')")
    @Log(title = "样本库", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改样本库")
    public AjaxResult edit(@RequestBody SysYxInfoAll sysYxInfoAll)
    {
        return toAjax(sysYxInfoAllService.updateSysYxInfoAll(sysYxInfoAll));
    }

    /**
     * 删除样本库
     */
    @PreAuthorize("@ss.hasPermi('system:all:remove')")
    @Log(title = "样本库", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除样本库")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sysYxInfoAllService.deleteSysYxInfoAllByIds(ids));
    }
}
