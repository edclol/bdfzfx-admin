package com.bdfzfx.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;


/**
 * 模拟CAS服务器控制器
 */
@RestController
public class CommonController {
    private static final Logger log = LoggerFactory.getLogger(CommonController.class);


    @GetMapping("/isc_sso/login")
    public void fileDownload(@RequestParam String service, HttpServletResponse response, HttpServletRequest request) throws IOException {
        log.info("service: {}", service);
        
        // 生成随机ticket
        String ticket = "ST-" + UUID.randomUUID().toString();
        log.info("生成的ticket: {}", ticket);
        
        // 重定向到service页面并附带ticket参数
        String redirectUrl = service + (service.contains("?") ? "&" : "?") + "ticket=" + ticket;
        response.sendRedirect(redirectUrl);

    }
    
    @GetMapping("/isc_sso/serviceValidate")
    public void serviceValidate(@RequestParam String service, @RequestParam String ticket, HttpServletResponse response, HttpServletRequest request) throws IOException {
        log.info("service: {}, ticket: {}", service, ticket);

        // 验证ticket（这里简化处理，实际应该检查ticket是否存在且有效）
        boolean isValidTicket = ticket.startsWith("ST-");
        
        // 构造CAS验证响应
        StringBuilder xmlResponse = new StringBuilder();
        xmlResponse.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        xmlResponse.append("<cas:serviceResponse xmlns:cas='http://www.yale.edu/tp/cas'>\n");
        
        if (isValidTicket) {
            // 返回默认用户信息
            xmlResponse.append("  <cas:authenticationSuccess>\n");
            xmlResponse.append("    <cas:user>admin</cas:user>\n"); // 默认用户名
            xmlResponse.append("    <cas:attributes>\n");
            xmlResponse.append("      <cas:userid>1</cas:userid>\n");
            xmlResponse.append("      <cas:name>管理员</cas:name>\n");
            xmlResponse.append("      <cas:email>admin@example.com</cas:email>\n");
            xmlResponse.append("    </cas:attributes>\n");
            xmlResponse.append("  </cas:authenticationSuccess>\n");
        } else {
            xmlResponse.append("  <cas:authenticationFailure code=\"INVALID_TICKET\">Ticket验证失败</cas:authenticationFailure>\n");
        }
        
        xmlResponse.append("</cas:serviceResponse>");
        
        // 设置响应头和内容
        response.setContentType("application/xml;charset=UTF-8");
        response.getWriter().write(xmlResponse.toString());
        response.getWriter().flush();
    }
}