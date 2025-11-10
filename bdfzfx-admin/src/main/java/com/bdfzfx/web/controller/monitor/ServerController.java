package com.bdfzfx.web.controller.monitor;

import com.bdfzfx.common.core.domain.AjaxResult;
import com.bdfzfx.framework.web.domain.Server;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 服务器监控
 * 
 *
 */
@RestController
@RequestMapping("/monitor/server")
@Api(tags = "服务器监控")
public class ServerController
{
    @PreAuthorize("@ss.hasPermi('monitor:server:list')")
    @GetMapping()
    @ApiOperation("获取服务器监控信息")
    public AjaxResult getInfo() throws Exception
    {
        Server server = new Server();
        server.copyTo();
        return AjaxResult.success(server);
    }
}