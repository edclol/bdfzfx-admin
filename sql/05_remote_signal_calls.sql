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

INSERT INTO sys_remote_signal_call
(call_time, interface_name, call_result, response_time, station_id, station_name, device_name, device_type,
 voltage_level, operation, create_by, create_time, update_by, update_time)
VALUES
-- 场景1：自动装置，同步调用成功
('2025-12-12 10:00:00', '单条遥信辅助分析同步调用', '0', '300ms', 'STATION_001', '厂站1', '装置A', '1',
 '550/220kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景2：公用设备，异步调用失败
('2025-12-12 10:00:00', '单条遥信辅助分析异步调用', '1', '100ms', 'STATION_001', '厂站1', '设备B', '2',
 '550kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景3：一次设备，异步结果查询成功
('2025-12-12 10:00:00', '遥信辅助分析异步调用结果查询', '0', '1s', 'STATION_001', '厂站1', '设备C', '3',
 '220kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景4：二次设备，批量文件调用成功
('2025-12-12 10:00:00', '批量文件调用遥信辅助分析异步', '0', '100ms', 'STATION_001', '厂站1', '设备D', '4',
 '550/220kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景5：自动装置，批量调用失败
('2025-12-12 10:00:00', '批量调用遥信辅助分析异步调用文件下载', '1', '220ms', 'STATION_001', '厂站1', '装置E',
 '1', '550kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景6：公用设备，同步调用成功（不同电压等级）
('2025-12-12 10:00:00', '单条遥信辅助分析同步调用', '0', '100ms', 'STATION_001', '厂站1', '设备F', '2',
 '220kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景7：新厂站测试，模拟不同厂站数据
('2025-12-13 09:30:00', '单条遥信辅助分析同步调用', '0', '200ms', 'STATION_002', '厂站2', '装置G', '1',
 '330/110kW', '数据处理', 'operator', NOW(), 'operator', NOW()),
-- 场景8：失败场景补充，长响应时间
('2025-12-13 14:15:00', '遥信辅助分析异步调用结果查询', '1', '2s', 'STATION_001', '厂站1', '设备H', '3',
 '110kW', '数据处理', 'admin', NOW(), 'admin', NOW());

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

