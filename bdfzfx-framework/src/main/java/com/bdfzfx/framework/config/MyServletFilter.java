package com.bdfzfx.framework.config;

import com.sgcc.isc.ualogin.client.util.IscSSOResourceUtil;
import com.sgcc.isc.ualogin.client.vo.IscSSOUserBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class MyServletFilter implements Filter {
    private static final Logger log = LoggerFactory.getLogger(MyServletFilter.class);

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {


        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String requestUrl = httpRequest.getRequestURI();

        log.debug("执行 Servlet Filter，请求URL：{}", requestUrl);
        try {
            IscSSOUserBean userBean = IscSSOResourceUtil.getIscUserBean(httpRequest);
            log.debug("SSO登录 userBean: {}", userBean);
        } catch (Exception e) {
            log.error("SSO登录异常", e);
        }


        chain.doFilter(request, response);
    }
}