package com.bdfzfx.web.controller.system;

import java.util.Date;
import java.util.List;
import java.util.Set;

import com.sgcc.isc.ualogin.client.util.IscSSOResourceUtil;
import com.sgcc.isc.ualogin.client.vo.IscSSOUserBean;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.bdfzfx.common.constant.Constants;
import com.bdfzfx.common.core.domain.AjaxResult;
import com.bdfzfx.common.core.domain.entity.SysMenu;
import com.bdfzfx.common.core.domain.entity.SysUser;
import com.bdfzfx.common.core.domain.model.LoginBody;
import com.bdfzfx.common.core.domain.model.LoginUser;
import com.bdfzfx.common.core.text.Convert;
import com.bdfzfx.common.utils.DateUtils;
import com.bdfzfx.common.utils.SecurityUtils;
import com.bdfzfx.common.utils.StringUtils;
import com.bdfzfx.framework.web.service.SysLoginService;
import com.bdfzfx.framework.web.service.SysPermissionService;
import com.bdfzfx.framework.web.service.TokenService;
import com.bdfzfx.system.service.ISysConfigService;
import com.bdfzfx.system.service.ISysMenuService;

import javax.servlet.http.HttpServletRequest;

/**
 * 登录验证
 * 
 *
 */
@Api(tags = "登录验证")
@RestController
public class SysLoginController
{
    private static final Logger logger = LoggerFactory.getLogger(SysLoginController.class);
    
    @Autowired
    private SysLoginService loginService;

    @Autowired
    private ISysMenuService menuService;

    @Autowired
    private SysPermissionService permissionService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private UserDetailsService userDetailsService;

    /**
     * 用户名密码登录方法
     * 
     * @param loginBody 登录信息
     * @return 结果
     */
    @PostMapping("/login")
    @ApiOperation("用户名密码登录")
    public AjaxResult login(@RequestBody LoginBody loginBody)
    {
        AjaxResult ajax = AjaxResult.success();
        // 生成令牌
        String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(), loginBody.getCode(),
                loginBody.getUuid());
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }

    /**
     * SSO登录方法
     * 
     * @return 结果
     */
    @GetMapping("/isc/callback")
    @ApiOperation("SSO登录")
    public AjaxResult ssoLogin(HttpServletRequest request) {
        logger.debug("SSO登录开始");
        AjaxResult ajax = AjaxResult.success();
        try {
            logger.debug("SSO登录请求参数: {}", request.getQueryString());
            IscSSOUserBean userBean = IscSSOResourceUtil.getIscUserBean(request);
            logger.debug("从SSO获取到的用户信息: {}", userBean);
            
            if (userBean == null || StringUtils.isEmpty(userBean.getName())) {
                logger.warn("SSO登录失败，无法获取用户信息，请求参数: {}", request.getQueryString());
                return AjaxResult.error("SSO登录失败，无法获取用户信息");
            }
            
            logger.debug("准备通过SSO用户名获取本地用户详情，用户名: {}", userBean.getName());

            // 通过SSO用户信息获取本地用户详情
            UserDetails userDetails = userDetailsService.loadUserByUsername(userBean.getName());
            logger.debug("获取到的本地用户详情: {}", userDetails);
            
            if (userDetails == null) {
                logger.warn("SSO登录失败，用户不存在，用户名: {}", userBean.getName());
                return AjaxResult.error("SSO登录失败，用户不存在");
            }
            
            logger.debug("准备为用户生成令牌，用户名: {}", userDetails.getUsername());
            // 生成令牌
            String token = loginService.login(userDetails.getUsername(), userDetails.getPassword(), "",
                    "");
            logger.debug("成功为用户生成令牌，用户名: {}", userDetails.getUsername());
            ajax.put(Constants.TOKEN, token);
            return ajax;
        } catch (Exception e) {
            logger.error("SSO登录异常，错误信息: {}", e.getMessage(), e);
            return AjaxResult.error("SSO登录异常: " + e.getMessage());
        }
    }

    /**
     * 获取用户信息
     * 
     * @return 用户信息
     */
    @GetMapping("getInfo")
    @ApiOperation("获取用户信息")
    public AjaxResult getInfo()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        SysUser user = loginUser.getUser();
        // 角色集合
        Set<String> roles = permissionService.getRolePermission(user);
        // 权限集合
        Set<String> permissions = permissionService.getMenuPermission(user);
        if (!loginUser.getPermissions().equals(permissions))
        {
            loginUser.setPermissions(permissions);
            tokenService.refreshToken(loginUser);
        }
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", user);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        ajax.put("isDefaultModifyPwd", initPasswordIsModify(user.getPwdUpdateDate()));
        ajax.put("isPasswordExpired", passwordIsExpiration(user.getPwdUpdateDate()));
        return ajax;
    }

    /**
     * 获取路由信息
     * 
     * @return 路由信息
     */
    @GetMapping("getRouters")
    @ApiOperation("获取路由信息")
    public AjaxResult getRouters()
    {
        Long userId = SecurityUtils.getUserId();
        List<SysMenu> menus = menuService.selectMenuTreeByUserId(userId);
        return AjaxResult.success(menuService.buildMenus(menus));
    }
    
    // 检查初始密码是否提醒修改
    public boolean initPasswordIsModify(Date pwdUpdateDate)
    {
        Integer initPasswordModify = Convert.toInt(configService.selectConfigByKey("sys.account.initPasswordModify"));
        return initPasswordModify != null && initPasswordModify == 1 && pwdUpdateDate == null;
    }

    // 检查密码是否过期
    public boolean passwordIsExpiration(Date pwdUpdateDate)
    {
        Integer passwordValidateDays = Convert.toInt(configService.selectConfigByKey("sys.account.passwordValidateDays"));
        if (passwordValidateDays != null && passwordValidateDays > 0)
        {
            if (StringUtils.isNull(pwdUpdateDate))
            {
                // 如果从未修改过初始密码，直接提醒过期
                return true;
            }
            Date nowDate = DateUtils.getNowDate();
            return DateUtils.differentDaysByMillisecond(nowDate, pwdUpdateDate) > passwordValidateDays;
        }
        return false;
    }
}