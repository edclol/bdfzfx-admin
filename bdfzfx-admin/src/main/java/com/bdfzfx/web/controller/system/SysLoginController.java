package com.bdfzfx.web.controller.system;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.List;
import java.util.Set;

import com.bdfzfx.common.exception.user.UserNotExistsException;
import com.bdfzfx.system.service.ISysUserService;
import com.sgcc.isc.ualogin.client.IscServiceTicketValidator;
import com.sgcc.isc.ualogin.client.util.IscSSOResourceUtil;
import com.sgcc.isc.ualogin.client.vo.IscSSOUserBean;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.jasig.cas.client.javafilter.validation.TicketValidationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;
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

// 添加FastJSON2的导入
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;

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

    @Value("${isc.sso.sso-server-validate-url}")
    private String casValidateUrl;

    @Autowired
    private ISysUserService userService;
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
    public AjaxResult ssoLogin(HttpServletRequest request, @RequestParam String ticket) {
        logger.debug("SSO登录开始，ticket: {}", ticket);
        AjaxResult ajax = AjaxResult.success();
        IscSSOUserBean userBean = null;

        try {
            // 方式1：CAS票据解析获取用户信息
            try {
                IscServiceTicketValidator ticketValidator = new IscServiceTicketValidator();
                ticketValidator.setCasValidateUrl(casValidateUrl);
                ticketValidator.setServiceTicket(ticket);
                ticketValidator.validate();

                String userJsonStr = ticketValidator.getUser();
                logger.debug("CAS票据解析获取用户原始信息: {}", userJsonStr);
                if (StringUtils.isNotBlank(userJsonStr)) {
                    String userStr = URLDecoder.decode(userJsonStr, StandardCharsets.UTF_8.name());
                    JSONObject jsonObject = JSON.parseObject(userStr);
                    userBean = jsonObject.toJavaObject(IscSSOUserBean.class);
                    logger.debug("解析出用户信息: {}", userBean);
                }
            } catch (Exception e) {
                logger.warn("CAS票据解析获取用户信息失败，原因: {}", e.getMessage(), e);
                // 仅记录异常，不中断，继续执行方式2
            }

            // 方式2：Request兜底获取（仅方式1失败/无数据时执行）
            if (userBean == null || StringUtils.isEmpty(userBean.getName())) {
                try {
                    logger.debug("尝试从Request中获取用户信息");
                    userBean = IscSSOResourceUtil.getIscUserBean(request);
                    logger.debug("从Request获取的用户信息: {}", userBean);
                } catch (Exception e) {
                    logger.warn("从Request获取用户信息失败，原因: {}", e.getMessage(), e);
                }
            }

            // 最终用户信息校验
            if (userBean == null || StringUtils.isEmpty(userBean.getName())) {
                String requestParams = request.getQueryString();
                logger.warn("SSO登录失败：所有方式均未获取到有效用户信息，请求参数: {}", requestParams);
                return AjaxResult.error("SSO登录失败，无法获取用户信息");
            }

            // 本地用户校验 + 令牌生成
            logger.debug("通过SSO用户名[{}]查询本地用户信息", userBean);
            SysUser userDetails = userService.selectUserByUserName(userBean.getName());
            if (userDetails == null) {
                logger.warn("SSO登录失败：本地系统无该用户，用户名: {}", userBean.getName());
                return AjaxResult.error("SSO登录失败，用户未在本系统注册，请联系管理员");
            }

            String token = loginService.login(userDetails.getUserName(), "yunjian123", "", "");
            logger.debug("用户[{}]SSO登录成功，生成令牌: {}", userBean.getName(), token);
            ajax.put(Constants.TOKEN, token);

        } catch (UserNotExistsException e) {
            logger.error("SSO登录失败：本地用户不存在", e);
            return AjaxResult.error("SSO登录失败，用户未在本系统注册，请联系管理员");
        } catch (Exception e) {
            logger.error("SSO登录异常", e);
            return AjaxResult.error("SSO登录异常: " + e.getMessage());
        }
        return ajax;
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