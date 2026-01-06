package com.bdfzfx;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 *
 *
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class CasMockApp {
    public static void main(String[] args) {
        SpringApplication.run(CasMockApp.class, args);
        System.out.println("JDK 版本: " + System.getProperty("java.version"));
        System.out.println("启动成功！👌👌👌");
    }
}
