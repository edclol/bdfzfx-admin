package com.bdfzfx.framework.config;

import com.sgcc.isc.ualogin.client.filter.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * SSO 认证配置类
 */
@Configuration
@ConditionalOnProperty(name = "isc.sso.enabled", havingValue = "true")
public class SSOConfig {

    // 从配置文件读取参数
    @Value("${isc.sso.appid:40288cd65fbf9021015fc2dc5ac500bc}")
    private String appid;

    @Value("${isc.sso.sso-server-url:http://host:prot/isc_sso/}")
    private String ssoServerUrl;

    @Value("${isc.sso.server-login-url:${isc.sso.sso-server-url}/login}")
    private String serverLoginUrl;

    @Value("${isc.sso.server-logout-url:${isc.sso.sso-server-url}/logout}")
    private String serverLogoutUrl;

    @Value("${isc.sso.server-url-prefix:${isc.sso.sso-server-url}}")
    private String serverUrlPrefix;

    @Value("${isc.sso.business-server-url:http://host:port}")
    private String businessServerUrl;

    @Value("${isc.sso.business-app-url:${isc.sso.business-server-url}/test_isc_mp}")
    private String businessAppUrl;

    /**
     * 单点登出过滤器 Bean
     */
    @Bean
    public FilterRegistrationBean<IscSingleSignOutFilter> iscSingleSignOutFilter() {
        FilterRegistrationBean<IscSingleSignOutFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new IscSingleSignOutFilter());
        registrationBean.addUrlPatterns("/isc/*");
        registrationBean.setName("IscSingleSignOutFilter");
        registrationBean.setOrder(1);
        return registrationBean;
    }

    /**
     * 认证过滤器 Bean
     */
    @Bean
    public FilterRegistrationBean<IscSSOAuthenticationFilter> authenticationFilter() {
        FilterRegistrationBean<IscSSOAuthenticationFilter> registrationBean = new FilterRegistrationBean<>();
        IscSSOAuthenticationFilter filter = new IscSSOAuthenticationFilter();

        // 设置过滤器初始化参数
        registrationBean.addInitParameter("serverLoginUrl", serverLoginUrl);
        registrationBean.addInitParameter("serverName", businessServerUrl);

        registrationBean.setFilter(filter);
        registrationBean.addUrlPatterns("/isc/*");
        registrationBean.setName("AuthenticationFilter");
        registrationBean.setOrder(2);
        return registrationBean;
    }

    /**
     * 票据验证过滤器 Bean
     */
    @Bean
    public FilterRegistrationBean<IscSSO20ProxyReceivingTicketValidationFilter> validationFilter() {
        FilterRegistrationBean<IscSSO20ProxyReceivingTicketValidationFilter> registrationBean = new FilterRegistrationBean<>();
        IscSSO20ProxyReceivingTicketValidationFilter filter = new IscSSO20ProxyReceivingTicketValidationFilter();

        // 设置过滤器初始化参数
        registrationBean.addInitParameter("serverUrlPrefix", serverUrlPrefix);
        registrationBean.addInitParameter("serverName", businessServerUrl);
        registrationBean.addInitParameter("redirectAfterValidation", "true");

        registrationBean.setFilter(filter);
        registrationBean.addUrlPatterns("/isc/*");
        registrationBean.setName("ValidationFilter");
        registrationBean.setOrder(3);
        return registrationBean;
    }

    /**
     * 请求包装过滤器 Bean
     */
    @Bean
    public FilterRegistrationBean<IscSSOHttpServletRequestWrapperFilter> httpServletRequestWrapperFilter() {
        FilterRegistrationBean<IscSSOHttpServletRequestWrapperFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new IscSSOHttpServletRequestWrapperFilter());
        registrationBean.addUrlPatterns("/isc/*");
        registrationBean.setName("HttpServletRequestWrapperFilter");
        registrationBean.setOrder(4);
        return registrationBean;
    }

    /**
     * 断言线程本地过滤器 Bean
     */
    @Bean
    public FilterRegistrationBean<IsoSSOAssertionThreadLocalFilter> assertionThreadLocalFilter() {
        FilterRegistrationBean<IsoSSOAssertionThreadLocalFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new IsoSSOAssertionThreadLocalFilter());
        registrationBean.addUrlPatterns("/isc/*");
        registrationBean.setName("AssertionThreadLocalFilter");
        registrationBean.setOrder(5);
        return registrationBean;
    }

    /**
     *
     */
    @Bean
    public FilterRegistrationBean<MyServletFilter> myServletFilter() {
        FilterRegistrationBean<MyServletFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new MyServletFilter());
        registrationBean.addUrlPatterns("/isc/isc/*");
        registrationBean.setName("MyServletFilter");
        registrationBean.setOrder(6);
        return registrationBean;
    }


}