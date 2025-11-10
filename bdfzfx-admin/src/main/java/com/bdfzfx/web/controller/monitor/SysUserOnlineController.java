package com.bdfzfx.web.controller.monitor;

import com.bdfzfx.common.annotation.Log;
import com.bdfzfx.common.constant.CacheConstants;
import com.bdfzfx.common.core.controller.BaseController;
import com.bdfzfx.common.core.domain.AjaxResult;
import com.bdfzfx.common.core.domain.model.LoginUser;
import com.bdfzfx.common.core.page.TableDataInfo;
import com.bdfzfx.common.core.redis.RedisCache;
import com.bdfzfx.common.enums.BusinessType;
import com.bdfzfx.common.utils.StringUtils;
import com.bdfzfx.system.domain.SysUserOnline;
import com.bdfzfx.system.service.ISysUserOnlineService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

/**
 * 在线用户监控
 * 
 *  
 */
@RestController
@RequestMapping("/monitor/online")
@Api(tags = "在线用户监控")
public class SysUserOnlineController extends BaseController
{
    @Autowired
    private ISysUserOnlineService userOnlineService;

    @Autowired
    private RedisCache redisCache;

    @PreAuthorize("@ss.hasPermi('monitor:online:list')")
    @GetMapping("/list")
    @ApiOperation("获取在线用户列表")
    public TableDataInfo list(String ipaddr, String userName)
    {
        Collection<String> keys = redisCache.keys(CacheConstants.LOGIN_TOKEN_KEY + "*");
        List<SysUserOnline> userOnlineList = new ArrayList<SysUserOnline>();
        for (String key : keys)
        {
            // 修复类型转换问题
            Object userObj = redisCache.getCacheObject(key);
            LoginUser user = null;
            if (userObj != null) {
                if (userObj instanceof LoginUser) {
                    user = (LoginUser) userObj;
                } else if (userObj instanceof com.alibaba.fastjson2.JSONObject) {
                    // 将JSONObject转换为LoginUser
                    user = ((com.alibaba.fastjson2.JSONObject) userObj).toJavaObject(LoginUser.class);
                } else {
                    // 其他情况使用JSON反序列化
                    user = com.alibaba.fastjson2.JSON.parseObject(com.alibaba.fastjson2.JSON.toJSONString(userObj), LoginUser.class);
                }
            }

            if (user != null) {
                if (StringUtils.isNotEmpty(ipaddr) && StringUtils.isNotEmpty(userName))
                {
                    userOnlineList.add(userOnlineService.selectOnlineByInfo(ipaddr, userName, user));
                }
                else if (StringUtils.isNotEmpty(ipaddr))
                {
                    userOnlineList.add(userOnlineService.selectOnlineByIpaddr(ipaddr, user));
                }
                else if (StringUtils.isNotEmpty(userName) && StringUtils.isNotNull(user.getUser()))
                {
                    userOnlineList.add(userOnlineService.selectOnlineByUserName(userName, user));
                }
                else
                {
                    userOnlineList.add(userOnlineService.loginUserToUserOnline(user));
                }
            }
        }
        Collections.reverse(userOnlineList);
        userOnlineList.removeAll(Collections.singleton(null));
        return getDataTable(userOnlineList);
    }


    /**
     * 强退用户
     */
    @PreAuthorize("@ss.hasPermi('monitor:online:forceLogout')")
    @Log(title = "在线用户", businessType = BusinessType.FORCE)
    @DeleteMapping("/{tokenId}")
    @ApiOperation("强退用户")
    public AjaxResult forceLogout(@PathVariable String tokenId)
    {
        redisCache.deleteObject(CacheConstants.LOGIN_TOKEN_KEY + tokenId);
        return success();
    }
}