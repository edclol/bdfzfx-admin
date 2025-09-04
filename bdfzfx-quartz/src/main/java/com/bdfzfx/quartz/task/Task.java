package com.bdfzfx.quartz.task;

import com.bdfzfx.common.annotation.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.bdfzfx.common.utils.StringUtils;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * 定时任务调度测试
 * 
 *
 */
@Component("Task")
public class Task
{
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private DataSource dataSource;

    public void multipleParams(String s, Boolean b, Long l, Double d, Integer i)
    {
        System.out.println(StringUtils.format("执行多参方法： 字符串类型{}，布尔类型{}，长整型{}，浮点型{}，整形{}", s, b, l, d, i));
    }

    public void params(String params)
    {
        System.out.println("执行有参方法：" + params);
    }

    public void noParams()
    {
        System.out.println("执行无参方法");
    }

    
    /**
     * 定时更新调用记录数据
     */
    public void updateCallRecord() {
        logger.info("开始更新调用记录数据");
        try {
            Connection connection = dataSource.getConnection();
            if (connection != null) {
                logger.info("开始连接数据库");
                // 先清空表数据
                String truncateSql = "TRUNCATE TABLE sys_remote_signal_call";
                try (PreparedStatement truncateStmt = connection.prepareStatement(truncateSql)) {
                    truncateStmt.executeUpdate();
                    logger.info("已清空 sys_remote_signal_call 表数据");
                }
                
                // 执行sql
                String sql = "INSERT INTO sys_remote_signal_call (" +
                    "call_time," +
                    "interface_name," +
                    "call_result," +
                    "response_time," +
                    "station_id," +
                    "station_name," +
                    "device_name," +
                    "device_type," +
                    "voltage_level," +
                    "operation," +
                    "create_by," +
                    "create_time," +
                    "update_by," +
                    "update_time" +
                ") " +
                "SELECT " +
                    "TIMESTAMPADD(" +
                            "SECOND," +
                            "FLOOR(RAND() * 5256000), " +
                            "DATE_SUB(CURDATE(), INTERVAL 2 MONTH)" +
                    ") AS call_time," +
                    "ELT(" +
                            "FLOOR(RAND() * 4) + 1," +
                            "'单条遥信辅助分析同步调用'," +
                            "'单条遥信辅助分析异步调用'," +
                            "'遥信辅助分析异步调用结果查询'," +
                            "'批量文件调用遥信辅助分析异步'" +
                    ") AS interface_name," +
                    "CASE WHEN RAND() < 0.1 THEN 1 ELSE 0 END AS call_result," +
                    "CASE " +
                        "WHEN RAND() < 0.3 THEN CONCAT(FLOOR(RAND() * 5) + 1, 's') " +
                        "ELSE CONCAT(FLOOR(RAND() * 500) + 500, 'ms') " +
                        "END AS response_time," +
                    "ELT(" +
                            "station_idx," +
                            "'草坝站', '汉源站', '黄岗站', '名山站', '顺河站'," +
                            "'天全站', '下坪站', '新棉站', '荥经站', '竹马站', '七盘站'" +
                    ") AS station_id," +
                    "ELT(" +
                            "station_idx," +
                            "'草坝站', '汉源站', '黄岗站', '名山站', '顺河站'," +
                            "'天全站', '下坪站', '新棉站', '荥经站', '竹马站', '七盘站'" +
                    ") AS station_name," +
                    "ELT(" +
                            "device_type_idx," +
                            "'自动装置', '公用设备', '一次设备', '二次设备', '站用交直流', '辅控装置'" +
                    ") AS device_name," +
                    "device_type_idx AS device_type," +
                    "ELT(" +
                            "FLOOR(RAND() * 8) + 1," +
                            "'1000kV', '800kV', '750kV', '500kV', '220kV'," +
                            "'110kV', '35kV', '10kV'" +
                    ") AS voltage_level," +
                    "'数据处理' AS operation," +
                    "ELT(FLOOR(RAND() * 2) + 1, 'admin', 'operator') AS create_by," +
                    "NOW() AS create_time," +
                    "ELT(FLOOR(RAND() * 2) + 1, 'admin', 'operator') AS update_by," +
                    "NOW() AS update_time " +
                "FROM (" +
                         "SELECT 1 AS station_idx UNION SELECT 2 UNION SELECT 3 UNION " +
                         "SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION " +
                         "SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 " +
                     ") AS stations " +
                         "CROSS JOIN (" +
                    "SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION " +
                    "SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 " +
                ") AS nums1 " +
                         "CROSS JOIN (" +
                    "SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION " +
                    "SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 " +
                ") AS nums2 " +
                         "CROSS JOIN (" +
                    "SELECT 1 AS device_type_idx UNION SELECT 2 UNION SELECT 3 UNION " +
                    "SELECT 4 UNION SELECT 5 UNION SELECT 6 " +
                ") AS device_types " +
                "LIMIT 3000";

                try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                    int rowsAffected = stmt.executeUpdate();
                    logger.info("已插入 " + rowsAffected + " 条记录");
                }
            }
        } catch (Exception e) {
            logger.error("执行定时任务时发生错误: " + e.getMessage());
        } finally {
            // 注意：通常不建议在方法中关闭连接，因为连接来自连接池
            // 这里保留原代码结构，实际项目中应该由连接池管理连接
        }
    }
}
