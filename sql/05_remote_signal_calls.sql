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

-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('遥信调用记录', '1', '1', 'call', 'system/call/index', 1, 0, 'C', '0', '0', 'system:call:edit', 'build', 'admin', sysdate(), '', null, '遥信调用记录菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('遥信调用记录查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:call:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('遥信调用记录新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:call:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('遥信调用记录修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:call:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('遥信调用记录删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:call:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('遥信调用记录导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:call:export',       '#', 'admin', sysdate(), '', null, '');

INSERT INTO sys_remote_signal_call
(call_time, interface_name, call_result, response_time, station_id, station_name, device_name, device_type,
 voltage_level, operation, create_by, create_time, update_by, update_time)
VALUES
-- 场景1：自动装置，同步调用成功
('2024-12-12 10:00:00', '单条遥信辅助分析同步调用', '0', '300ms', 'STATION_001', '厂站1', '装置A', '1',
 '550/220kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景2：公用设备，异步调用失败
('2024-12-12 10:00:00', '单条遥信辅助分析异步调用', '1', '100ms', 'STATION_001', '厂站1', '设备B', '2',
 '550kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景3：一次设备，异步结果查询成功
('2024-12-12 10:00:00', '遥信辅助分析异步调用结果查询', '0', '1s', 'STATION_001', '厂站1', '设备C', '3',
 '220kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景4：二次设备，批量文件调用成功
('2024-12-12 10:00:00', '批量文件调用遥信辅助分析异步', '0', '100ms', 'STATION_001', '厂站1', '设备D', '4',
 '550/220kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景5：自动装置，批量调用失败
('2024-12-12 10:00:00', '批量调用遥信辅助分析异步调用文件下载', '1', '220ms', 'STATION_001', '厂站1', '装置E',
 '1', '550kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景6：公用设备，同步调用成功（不同电压等级）
('2024-12-12 10:00:00', '单条遥信辅助分析同步调用', '0', '100ms', 'STATION_001', '厂站1', '设备F', '2',
 '220kW', '数据处理', 'admin', NOW(), 'admin', NOW()),
-- 场景7：新厂站测试，模拟不同厂站数据
('2024-12-13 09:30:00', '单条遥信辅助分析同步调用', '0', '200ms', 'STATION_002', '厂站2', '装置G', '1',
 '330/110kW', '数据处理', 'operator', NOW(), 'operator', NOW()),
-- 场景8：失败场景补充，长响应时间
('2024-12-13 14:15:00', '遥信辅助分析异步调用结果查询', '1', '2s', 'STATION_001', '厂站1', '设备H', '3',
 '110kW', '数据处理', 'admin', NOW(), 'admin', NOW());