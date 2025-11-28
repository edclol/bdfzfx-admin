package com.bdfzfx.framework.web.service;

import com.sgcc.isc.ualogin.client.vo.IscSSOUserBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.bdfzfx.common.core.domain.entity.SysUser;
import com.bdfzfx.common.core.domain.model.LoginUser;
import com.bdfzfx.common.enums.UserStatus;
import com.bdfzfx.common.exception.ServiceException;
import com.bdfzfx.common.utils.MessageUtils;
import com.bdfzfx.common.utils.StringUtils;
import com.bdfzfx.system.service.ISysUserService;

/**
 * 用户验证处理
 *
 *  
 */
@Service
public class UserDetailsServiceImpl implements UserDetailsService
{
    private static final Logger log = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

    @Autowired
    private ISysUserService userService;
    
    @Autowired
    private SysPasswordService passwordService;

    @Autowired
    private SysPermissionService permissionService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException
    {
        SysUser user = userService.selectUserByUserName(username);
        if (StringUtils.isNull(user))
        {
            log.info("登录用户：{} 不存在.", username);
            throw new ServiceException(MessageUtils.message("user.not.exists"));
        }
        else if (UserStatus.DELETED.getCode().equals(user.getDelFlag()))
        {
            log.info("登录用户：{} 已被删除.", username);
            throw new ServiceException(MessageUtils.message("user.password.delete"));
        }
        else if (UserStatus.DISABLE.getCode().equals(user.getStatus()))
        {
            log.info("登录用户：{} 已被停用.", username);
            throw new ServiceException(MessageUtils.message("user.blocked"));
        }

        passwordService.validate(user);

        return createLoginUser(user);
    }

    /**
     * 构建登录用户对象
     * 
     * @param user 用户信息
     * @return LoginUser 登录用户
     */
    public LoginUser createLoginUser(SysUser user)
    {
        return new LoginUser(user.getUserId(), user.getDeptId(), user, permissionService.getMenuPermission(user));
    }
    
    /**
     * 通过SSO用户信息创建本地用户（如果不存在则创建）
     * 
     * @param ssoUser SSO用户信息
     * @return LoginUser 登录用户
     */
    public LoginUser createLoginUserFromSSO(IscSSOUserBean ssoUser) {
        // 查找本地是否存在该用户
        SysUser user = userService.selectUserByUserName(ssoUser.getName());
        
        // 如果本地不存在该用户，可以选择创建一个新用户或者抛出异常
        if (StringUtils.isNull(user)) {
            // 这里可以根据实际需求决定是否自动创建用户
            // 暂时我们抛出异常，要求用户必须在本地系统中存在
            throw new ServiceException("用户 " + ssoUser.getName() + " 在本地系统中不存在，请联系管理员");
        }
        
        // 检查用户状态
        if (UserStatus.DELETED.getCode().equals(user.getDelFlag())) {
            throw new ServiceException(MessageUtils.message("user.password.delete"));
        } else if (UserStatus.DISABLE.getCode().equals(user.getStatus())) {
            throw new ServiceException(MessageUtils.message("user.blocked"));
        }
        
        return createLoginUser(user);
    }
}