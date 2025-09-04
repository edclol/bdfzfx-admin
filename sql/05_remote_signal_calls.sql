USE app;
SET NAMES utf8mb4;
SET character_set_database = utf8mb4;
SET collation_database = utf8mb4_0900_ai_ci;


-- 遥信调用记录表
drop table if exists sys_remote_signal_call;
create table if not exists sys_remote_signal_call
(
    id             int auto_increment primary key comment '主键',
    call_time      datetime     not null comment '调用时间',
    interface_name varchar(100) not null comment '接口名称',
    call_result    varchar(50)  not null comment '调用结果',
    response_time  varchar(20)  not null comment '响应时长',
    station_id     varchar(100) not null comment '厂站ID',
    station_name   varchar(50)  not null comment '厂站名称',
    device_name    varchar(100) comment '设备名称',
    device_type    varchar(50)  not null comment '设备类型',
    voltage_level  varchar(50)  not null comment '电压等级',
    operation      varchar(50)  not null comment '操作',
    create_by      varchar(64) default '' comment '创建者',
    create_time    datetime comment '创建时间',
    update_by      varchar(64) default '' comment '更新者',
    update_time    datetime comment '更新时间'
) engine = innodb comment ='遥信调用记录表';


-- 生成3000条随机数据
INSERT INTO sys_remote_signal_call (
    call_time,
    interface_name,
    call_result,
    response_time,
    station_id,
    station_name,
    device_name,
    device_type,
    voltage_level,
    operation,
    create_by,
    create_time,
    update_by,
    update_time
)
SELECT
    TIMESTAMPADD(
            SECOND,
            FLOOR(RAND() * 5256000),  -- 5256000秒 = 60天
            DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
    ) AS call_time,

    ELT(
            FLOOR(RAND() * 4) + 1,
            '单条遥信辅助分析同步调用',
            '单条遥信辅助分析异步调用',
            '遥信辅助分析异步调用结果查询',
            '批量文件调用遥信辅助分析异步'
    ) AS interface_name,

    CASE WHEN RAND() < 0.1 THEN 1 ELSE 0 END AS call_result,

    CASE
        WHEN RAND() < 0.3 THEN CONCAT(FLOOR(RAND() * 5) + 1, 's')
        ELSE CONCAT(FLOOR(RAND() * 500) + 500, 'ms')
        END AS response_time,

    ELT(
            station_idx,
            '草坝站', '汉源站', '黄岗站', '名山站', '顺河站',
            '天全站', '下坪站', '新棉站', '荥经站', '竹马站', '七盘站'
    ) AS station_id,
    ELT(
            station_idx,
            '草坝站', '汉源站', '黄岗站', '名山站', '顺河站',
            '天全站', '下坪站', '新棉站', '荥经站', '竹马站', '七盘站'
    ) AS station_name,

    ELT(
            device_type_idx,
            '自动装置', '公用设备', '一次设备', '二次设备', '站用交直流', '辅控装置'
    ) AS device_name,

    device_type_idx AS device_type,

    ELT(
            FLOOR(RAND() * 8) + 1,
            '1000kV', '800kV', '750kV', '500kV', '220kV',
            '110kV', '35kV', '10kV'
    ) AS voltage_level,

    '数据处理' AS operation,

    ELT(FLOOR(RAND() * 2) + 1, 'admin', 'operator') AS create_by,
    NOW() AS create_time,
    ELT(FLOOR(RAND() * 2) + 1, 'admin', 'operator') AS update_by,
    NOW() AS update_time

FROM (
         SELECT 1 AS station_idx UNION SELECT 2 UNION SELECT 3 UNION
         SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION
         SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11
     ) AS stations
         CROSS JOIN (
    SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
    SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) AS nums1
         CROSS JOIN (
    SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
    SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) AS nums2
         CROSS JOIN (
    SELECT 1 AS device_type_idx UNION SELECT 2 UNION SELECT 3 UNION
    SELECT 4 UNION SELECT 5 UNION SELECT 6
) AS device_types
LIMIT 3000;





drop table if exists sys_yx_info_all;
CREATE TABLE sys_yx_info_all
(
    id                      INT AUTO_INCREMENT PRIMARY KEY,
    yx_id                   VARCHAR(255) NOT NULL COMMENT '遥信ID',
    info_name               VARCHAR(255) COMMENT '信息名称',
    info_name_original      VARCHAR(255) COMMENT '原始信息名称',
    substation_id           VARCHAR(50) COMMENT '变电站ID',
    interval_id             VARCHAR(50) COMMENT '间隔ID',
    yx_type                 VARCHAR(50) COMMENT '遥信类型',
    device_type             VARCHAR(100) COMMENT '设备类型',
    part_type               VARCHAR(100) COMMENT '部件类型',
    device_principle        VARCHAR(255) COMMENT '设备原理',
    v_level                 VARCHAR(50) COMMENT '电压等级',
    alarm_type              VARCHAR(100) COMMENT '告警类型',
    alarm_level             VARCHAR(50) COMMENT '告警级别',
    need_push               VARCHAR(20) COMMENT '是否需要推送',
    reference               TEXT COMMENT '参考资料',
    requirement             TEXT COMMENT '要求',
    target_device           VARCHAR(255) COMMENT '目标设备',
    origin_device           VARCHAR(255) COMMENT '源设备',
    data_primary_device     VARCHAR(255) COMMENT '主数据设备',
    data_secondary_device   VARCHAR(255) COMMENT '从数据设备',
    is_include_curly_braces VARCHAR(20) COMMENT '是否包含花括号'
) ENGINE = InnoDB COMMENT ='遥信信息数据表';

