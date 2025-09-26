package com.bdfzfx.quartz.task;

import com.bdfzfx.common.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * 定时任务调度测试
 */
@Component("Task")
public class Task {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private DataSource dataSource;

    public void multipleParams(String s, Boolean b, Long l, Double d, Integer i) {
        System.out.println(StringUtils.format("执行多参方法： 字符串类型{}，布尔类型{}，长整型{}，浮点型{}，整形{}", s, b, l, d, i));
    }

    public void params(String params) {
        System.out.println("执行有参方法：" + params);
    }

    public void noParams() {
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

    /**
     * 判断两个日期是否为同一天
     *
     * @param date1 日期1
     * @param date2 日期2
     * @return 是否为同一天
     */
    private boolean isSameDay(java.util.Date date1, java.util.Date date2) {
        java.util.Calendar cal1 = java.util.Calendar.getInstance();
        java.util.Calendar cal2 = java.util.Calendar.getInstance();
        cal1.setTime(date1);
        cal2.setTime(date2);
        return cal1.get(java.util.Calendar.YEAR) == cal2.get(java.util.Calendar.YEAR) &&
                cal1.get(java.util.Calendar.DAY_OF_YEAR) == cal2.get(java.util.Calendar.DAY_OF_YEAR);
    }

    /**
     * 定时更新操作日志的日期
     * <p>
     * 查询最新的操作日志的日期，如果最新日期不是今天，那么更新操作日志的日期加上今天减去最新日期的间隔
     */
    public void updateOperLogDates() {
        try (Connection connection = dataSource.getConnection()) {
            java.util.Date today = new java.util.Date();

            // 查询操作日志最新日期
            String maxOperateLogSql = "SELECT MAX(oper_time) FROM sys_oper_log";
            java.sql.Timestamp maxOperateTime = null;

            try (PreparedStatement operateStmt = connection.prepareStatement(maxOperateLogSql);
                 java.sql.ResultSet operateRs = operateStmt.executeQuery()) {
                if (operateRs.next()) {
                    maxOperateTime = operateRs.getTimestamp(1);
                }
            }

            // 如果存在操作日志且最新日期不是今天，则更新日期
            if (maxOperateTime != null) {
                java.util.Date maxOperateDate = new java.util.Date(maxOperateTime.getTime());
                // 检查最新日期是否不是今天
                if (!isSameDay(today, maxOperateDate)) {
                    long intervalMillis = today.getTime() - maxOperateDate.getTime();
                    long intervalDays = intervalMillis / (24 * 60 * 60 * 1000);

                    String updateOperateLogSql = "UPDATE sys_oper_log SET oper_time = DATE_ADD(oper_time, INTERVAL ? DAY)";

                    try (PreparedStatement updateStmt = connection.prepareStatement(updateOperateLogSql)) {
                        updateStmt.setLong(1, intervalDays);
                        int updatedRows = updateStmt.executeUpdate();
                        logger.info("更新了 {} 条操作日志记录，日期增加了 {} 天", updatedRows, intervalDays);
                    }
                } else {
                    logger.info("操作日志最新日期为今天，无需更新");
                }
            } else {
                logger.info("操作日志表中无数据");
            }

        } catch (Exception e) {
            logger.error("执行定时任务时发生错误: " + e.getMessage());
        }
    }

    /**
     * 定时更新登录日志的日期
     * <p>
     * 查询最新的登录日志的日期，如果最新日期不是今天，那么更新登录日志的日期加上今天减去最新日期的间隔
     */
    public void updateLoginLogDates() {
        try (Connection connection = dataSource.getConnection()) {
            java.util.Date today = new java.util.Date();

            // 查询登录日志最新日期
            String maxLoginLogSql = "SELECT MAX(login_time) FROM sys_logininfor";
            java.sql.Timestamp maxLoginTime = null;

            try (PreparedStatement loginStmt = connection.prepareStatement(maxLoginLogSql);
                 java.sql.ResultSet loginRs = loginStmt.executeQuery()) {
                if (loginRs.next()) {
                    maxLoginTime = loginRs.getTimestamp(1);
                }
            }

            // 如果存在登录日志且最新日期不是今天，则更新日期
            if (maxLoginTime != null) {
                java.util.Date maxLoginDate = new java.util.Date(maxLoginTime.getTime());
                // 检查最新日期是否不是今天
                if (!isSameDay(today, maxLoginDate)) {
                    long intervalMillis = today.getTime() - maxLoginDate.getTime();
                    long intervalDays = intervalMillis / (24 * 60 * 60 * 1000);

                    String updateLoginLogSql = "UPDATE sys_logininfor SET login_time = DATE_ADD(login_time, INTERVAL ? DAY)";

                    try (PreparedStatement updateStmt = connection.prepareStatement(updateLoginLogSql)) {
                        updateStmt.setLong(1, intervalDays);
                        int updatedRows = updateStmt.executeUpdate();
                        logger.info("更新了 {} 条登录日志记录，日期增加了 {} 天", updatedRows, intervalDays);
                    }
                } else {
                    logger.info("登录日志最新日期为今天，无需更新");
                }
            } else {
                logger.info("登录日志表中无数据");
            }

        } catch (Exception e) {
            logger.error("执行定时任务时发生错误: " + e.getMessage());
        }
    }


}
