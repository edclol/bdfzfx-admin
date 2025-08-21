USE app;
SET NAMES utf8mb4;
SET character_set_database = utf8mb4;
SET collation_database = utf8mb4_0900_ai_ci;


-- 处理所有带.0后缀的数值字符串
UPDATE sys_yx_info_all
SET yx_type = CAST(CAST(yx_type AS DECIMAL) AS CHAR)
WHERE yx_type REGEXP '^[0-9]+\\.0$';



-- ----------------------------
-- 1、样本标注任务表
-- ----------------------------
drop table if exists sys_label_task;
create table sys_label_task
(
    task_id         bigint(20)   not null auto_increment comment '任务ID',
    task_name       varchar(100) not null comment '任务名称',
    sample_count    int(11)      default 0 comment '样本总数',
    completed_count int(11)      default 0 comment '已完成标注数量',
    handler         varchar(50)  default null comment '处理人姓名',
    status          char(1)      not null comment '任务状态（0已发布 1进行中 2已完成 3已回收）',
    create_by       varchar(64)  default '' comment '创建者',
    create_time     datetime comment '创建时间',
    update_by       varchar(64)  default '' comment '更新者',
    update_time     datetime comment '更新时间',
    remark          varchar(500) default null comment '备注信息',
    primary key (task_id),
    key idx_task_name (task_name),
    key idx_status (status),
    key idx_create_time (create_time),
    key idx_handler (handler)
) engine = innodb  comment = '样本标注任务表';

-- ----------------------------
-- 初始化-样本标注任务表数据
-- ----------------------------
insert into sys_label_task values(1, '样本标注任务1', 200, 0, null, '0', 'admin', sysdate(), '', null, '');
insert into sys_label_task values(2, '样本标注任务2', 100, 50, '张三', '1', 'admin', sysdate(), '', null, '');
insert into sys_label_task values(3, '样本标注任务3', 200, 200, '李四', '2', 'admin', sysdate(), '', null, '');
insert into sys_label_task values(4, '样本标注任务4', 100, 0, null, '0', 'admin', sysdate(), '', null, '');
insert into sys_label_task values(5, '样本标注任务5', 200, 0, null, '0', 'admin', sysdate(), '', null, '');
insert into sys_label_task values(6, '样本标注任务5', 100, 0, null, '0', 'admin', sysdate(), '', null, '');


-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本标注任务', '1', '1', 'task', 'system/task/index', 1, 0, 'C', '0', '0', 'system:task:edit', 'build', 'admin', sysdate(), '', null, '样本标注任务菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本标注任务查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:task:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本标注任务新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:task:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本标注任务修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:task:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本标注任务删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:task:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本标注任务导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:task:export',       '#', 'admin', sysdate(), '', null, '');


drop table if exists sys_yx_data_version;
CREATE TABLE `sys_yx_data_version`
(
    `id`             int         NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `version_number` varchar(10) NOT NULL COMMENT '版本号',
    `change_time`    datetime    NOT NULL COMMENT '变更时间',
    `change_content` varchar(255) DEFAULT NULL COMMENT '变更内容',
    `operation`      varchar(50)  DEFAULT NULL COMMENT '操作',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB COMMENT ='样本数据版本管理表';

insert into sys_yx_data_version values(1, 'v1.0.0', sysdate(), '初始化版本', '初始化');
insert into sys_yx_data_version values(2, 'v1.0.1', sysdate(), '修复bug', '修复bug');
insert into sys_yx_data_version values(3, 'v1.0.2', sysdate(), '修复bug', '修复bug');
insert into sys_yx_data_version values(4, 'v1.0.3', sysdate(), '修复bug', '修复bug');
insert into sys_yx_data_version values(5, 'v1.0.4', sysdate(), '修复bug', '修复bug');
insert into sys_yx_data_version values(6, 'v1.0.5', sysdate(), '修复bug', '修复bug');
insert into sys_yx_data_version values(7, 'v1.0.6', sysdate(), '修复bug', '修复bug');

-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本数据版本管理', '1', '1', 'version', 'system/version/index', 1, 0, 'C', '0', '0', 'system:version:list', 'build', 'admin', sysdate(), '', null, '样本数据版本管理菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本数据版本管理查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:version:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本数据版本管理新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:version:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本数据版本管理修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:version:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本数据版本管理删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:version:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('样本数据版本管理导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:version:export',       '#', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 同义词库表
-- ----------------------------
DROP TABLE IF EXISTS sys_synonym;
CREATE TABLE sys_synonym
(
    id          BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    word        VARCHAR(100) NOT NULL COMMENT '原始词汇（如：过流Ⅰ段）',
    synonym     VARCHAR(100) NOT NULL COMMENT '统一理解为的标准词（如：过流 I 段）',
    create_by   varchar(64)  default '' comment '创建者',
    create_time datetime comment '创建时间',
    update_by   varchar(64)  default '' comment '更新者',
    update_time datetime comment '更新时间',
    remark      varchar(500) default null comment '备注信息',
    PRIMARY KEY (id),
    UNIQUE KEY uk_word (word)
) ENGINE = InnoDB COMMENT = '同义词库表';



-- 插入标准同义词映射数据
INSERT INTO sys_synonym (word, synonym, create_by, create_time) VALUES
-- 过流相关
('过流Ⅰ段', '过流 I 段', '系统管理员', '2024-12-12 10:00:00'),
('过流1段', '过流 I 段', '系统管理员', '2024-12-12 10:00:00'),
('过流一段', '过流 I 段', '系统管理员', '2024-12-12 10:00:00'),

('零序过流Ⅰ段', '零序过流 I 段', '系统管理员', '2024-12-12 10:00:00'),
('零序过流1段', '零序过流 I 段', '系统管理员', '2024-12-12 10:00:00'),
('零序过流一段', '零序过流 I 段', '系统管理员', '2024-12-12 10:00:00'),

('距离Ⅰ段', '距离 I 段', '系统管理员', '2024-12-12 10:00:00'),
('距离1段', '距离 I 段', '系统管理员', '2024-12-12 10:00:00'),
('距离一段', '距离 I 段', '系统管理员', '2024-12-12 10:00:00'),

-- 告警/保护类
('过负荷告警', '过载告警', '系统管理员', '2024-12-12 10:00:00'),
('过载告警', '过载告警', '系统管理员', '2024-12-12 10:00:00'),
('过载报警', '过载告警', '系统管理员', '2024-12-12 10:00:00'),

('低电压保护', '欠压保护', '系统管理员', '2024-12-12 10:00:00'),
('欠压保护', '欠压保护', '系统管理员', '2024-12-12 10:00:00'),
('低压保护', '欠压保护', '系统管理员', '2024-12-12 10:00:00'),

('过电压保护', '过压保护', '系统管理员', '2024-12-12 10:00:00'),
('过压保护', '过压保护', '系统管理员', '2024-12-12 10:00:00'),
('高压保护', '过压保护', '系统管理员', '2024-12-12 10:00:00'),

('差动速断', '差动Ⅰ段', '系统管理员', '2024-12-12 10:00:00'),
('差动Ⅰ段', '差动Ⅰ段', '系统管理员', '2024-12-12 10:00:00'),
('差动一段', '差动Ⅰ段', '系统管理员', '2024-12-12 10:00:00'),

('重合闸后加速', '后加速保护', '系统管理员', '2024-12-12 10:00:00'),
('后加速保护', '后加速保护', '系统管理员', '2024-12-12 10:00:00'),
('重合后加速', '后加速保护', '系统管理员', '2024-12-12 10:00:00'),

('PT断线告警', '电压互感器断线报警', '系统管理员', '2024-12-12 10:00:00'),
('电压互感器断线报警', '电压互感器断线报警', '系统管理员', '2024-12-12 10:00:00'),
('PT失压报警', '电压互感器断线报警', '系统管理员', '2024-12-12 10:00:00'),

('CT断线闭锁', '电流互感器断线闭锁', '系统管理员', '2024-12-12 10:00:00'),
('电流互感器断线闭锁', '电流互感器断线闭锁', '系统管理员', '2024-12-12 10:00:00'),
('CT失效闭锁', '电流互感器断线闭锁', '系统管理员', '2024-12-12 10:00:00'),

('低频减载', '低频保护', '系统管理员', '2024-12-12 10:00:00'),
('低频保护', '低频保护', '系统管理员', '2024-12-12 10:00:00'),
('低周减载', '低频保护', '系统管理员', '2024-12-12 10:00:00'),

('过频保护', '高周保护', '系统管理员', '2024-12-12 10:00:00'),
('高周保护', '高周保护', '系统管理员', '2024-12-12 10:00:00'),
('超频保护', '高周保护', '系统管理员', '2024-12-12 10:00:00'),

('非电量保护', '开入量保护', '系统管理员', '2024-12-12 10:00:00'),
('开入量保护', '开入量保护', '系统管理员', '2024-12-12 10:00:00'),
('辅助保护', '开入量保护', '系统管理员', '2024-12-12 10:00:00'),

('失灵启动', '断路器失灵启动', '系统管理员', '2024-12-12 10:00:00'),
('断路器失灵启动', '断路器失灵启动', '系统管理员', '2024-12-12 10:00:00'),
('失灵保护触发', '断路器失灵启动', '系统管理员', '2024-12-12 10:00:00'),

('小电流接地选线', '接地故障选线', '系统管理员', '2024-12-12 10:00:00'),
('接地故障选线', '接地故障选线', '系统管理员', '2024-12-12 10:00:00'),
('零序选线', '接地故障选线', '系统管理员', '2024-12-12 10:00:00'),

('过流Ⅱ段', '过流 II 段', '系统管理员', '2024-12-12 10:00:00'),
('过流2段', '过流 II 段', '系统管理员', '2024-12-12 10:00:00'),
('过流二段', '过流 II 段', '系统管理员', '2024-12-12 10:00:00'),

('零序过流Ⅱ段', '零序过流 II 段', '系统管理员', '2024-12-12 10:00:00'),
('零序过流2段', '零序过流 II 段', '系统管理员', '2024-12-12 10:00:00'),
('零序过流二段', '零序过流 II 段', '系统管理员', '2024-12-12 10:00:00'),

('距离Ⅱ段', '距离 II 段', '系统管理员', '2024-12-12 10:00:00'),
('距离2段', '距离 II 段', '系统管理员', '2024-12-12 10:00:00'),
('距离二段', '距离 II 段', '系统管理员', '2024-12-12 10:00:00'),

('过流Ⅲ段', '过流 III 段', '系统管理员', '2024-12-12 10:00:00'),
('过流3段', '过流 III 段', '系统管理员', '2024-12-12 10:00:00'),
('过流三段', '过流 III 段', '系统管理员', '2024-12-12 10:00:00'),

('零序过流Ⅲ段', '零序过流 III 段', '系统管理员', '2024-12-12 10:00:00'),
('零序过流3段', '零序过流 III 段', '系统管理员', '2024-12-12 10:00:00'),
('零序过流三段', '零序过流 III 段', '系统管理员', '2024-12-12 10:00:00'),

('距离Ⅲ段', '距离 III 段', '系统管理员', '2024-12-12 10:00:00'),
('距离3段', '距离 III 段', '系统管理员', '2024-12-12 10:00:00'),
('距离三段', '距离 III 段', '系统管理员', '2024-12-12 10:00:00'),

('反时限过流', '反时限保护', '系统管理员', '2024-12-12 10:00:00'),
('反时限保护', '反时限保护', '系统管理员', '2024-12-12 10:00:00'),
('I-t特性保护', '反时限保护', '系统管理员', '2024-12-12 10:00:00'),

('重合闸前加速', '前加速保护', '系统管理员', '2024-12-12 10:00:00'),
('前加速保护', '前加速保护', '系统管理员', '2024-12-12 10:00:00'),
('瞬时加速', '前加速保护', '系统管理员', '2024-12-12 10:00:00'),

('检同期重合', '同期检定重合', '系统管理员', '2024-12-12 10:00:00'),
('同期检定重合', '同期检定重合', '系统管理员', '2024-12-12 10:00:00'),
('同步检查重合', '同期检定重合', '系统管理员', '2024-12-12 10:00:00'),

('检无压重合', '无压检定重合', '系统管理员', '2024-12-12 10:00:00'),
('无压检定重合', '无压检定重合', '系统管理员', '2024-12-12 10:00:00'),
('电压闭锁重合', '无压检定重合', '系统管理员', '2024-12-12 10:00:00'),

('母线充电保护', '母充保护', '系统管理员', '2024-12-12 10:00:00'),
('母充保护', '母充保护', '系统管理员', '2024-12-12 10:00:00'),
('充电短时过流', '母充保护', '系统管理员', '2024-12-12 10:00:00'),

('冷负荷启动', '冷载启动', '系统管理员', '2024-12-12 10:00:00'),
('冷载启动', '冷载启动', '系统管理员', '2024-12-12 10:00:00'),
('负荷突投保护', '冷载启动', '系统管理员', '2024-12-12 10:00:00'),

('频率异常', '频偏保护', '系统管理员', '2024-12-12 10:00:00'),
('频偏保护', '频偏保护', '系统管理员', '2024-12-12 10:00:00'),
('系统频率越限', '频偏保护', '系统管理员', '2024-12-12 10:00:00'),

('电压越限告警', '电压超限报警', '系统管理员', '2024-12-12 10:00:00'),
('电压超限报警', '电压超限报警', '系统管理员', '2024-12-12 10:00:00'),
('越压报警', '电压超限报警', '系统管理员', '2024-12-12 10:00:00'),

('电流越限告警', '电流超限报警', '系统管理员', '2024-12-12 10:00:00'),
('电流超限报警', '电流超限报警', '系统管理员', '2024-12-12 10:00:00'),
('过流预警', '电流超限报警', '系统管理员', '2024-12-12 10:00:00'),

('功率振荡闭锁', '振荡闭锁', '系统管理员', '2024-12-12 10:00:00'),
('振荡闭锁', '振荡闭锁', '系统管理员', '2024-12-12 10:00:00'),
('失步闭锁', '振荡闭锁', '系统管理员', '2024-12-12 10:00:00'),

('TA断线告警', 'CT二次断线报警', '系统管理员', '2024-12-12 10:00:00'),
('CT二次断线报警', 'CT二次断线报警', '系统管理员', '2024-12-12 10:00:00'),
('电流回路异常', 'CT二次断线报警', '系统管理员', '2024-12-12 10:00:00'),

('TV断线告警', 'PT二次断线报警', '系统管理员', '2024-12-12 10:00:00'),
('PT二次断线报警', 'PT二次断线报警', '系统管理员', '2024-12-12 10:00:00'),
('电压回路异常', 'PT二次断线报警', '系统管理员', '2024-12-12 10:00:00'),

('控制回路断线', '控回断线', '系统管理员', '2024-12-12 10:00:00'),
('控回断线', '控回断线', '系统管理员', '2024-12-12 10:00:00'),
('操作电源消失', '控回断线', '系统管理员', '2024-12-12 10:00:00'),

('弹簧未储能', '储能超时', '系统管理员', '2024-12-12 10:00:00'),
('储能超时', '储能超时', '系统管理员', '2024-12-12 10:00:00');

-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('同义词库', '1', '1', 'synonym', 'system/synonym/index', 1, 0, 'C', '0', '0', 'system:synonym:list', 'build', 'admin', sysdate(), '', null, '同义词库菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('同义词库查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:synonym:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('同义词库新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:synonym:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('同义词库修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:synonym:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('同义词库删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:synonym:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('同义词库导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:synonym:export',       '#', 'admin', sysdate(), '', null, '');


DROP TABLE IF EXISTS sys_typical_monitor_info;
CREATE TABLE sys_typical_monitor_info
(
    id                     BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    device_type            VARCHAR(50)  NOT NULL COMMENT '设备类型，如：开关保护、线路保护',
    device_principle       VARCHAR(100) NOT NULL COMMENT '设备原理，如：带过压远跳功能',
    info_name              TEXT         NOT NULL COMMENT '信息名称，格式为：[电压等级][间隔名称][设备编号][保护（型号）] 光纤通道一软压板',
    voltage_level          VARCHAR(50)  DEFAULT NULL COMMENT '通用电压等级，如：550/220kV',
    alarm_status           VARCHAR(20)  DEFAULT NULL COMMENT '告警状态，如：告警、动作、异常',
    alarm_level            varchar(10)  DEFAULT NULL COMMENT '告警等级，如：4级',
    send_to_monitor        varchar(10)  DEFAULT '0' COMMENT '是否上送监控（0否，1是）',
    reference_basis        VARCHAR(50)  DEFAULT NULL COMMENT '参考依据，如：新一代、2020企标',
    collection_requirement VARCHAR(100) DEFAULT NULL COMMENT '采集要求，如：实时采集、定时采集',
    target_device          VARCHAR(100) DEFAULT NULL COMMENT '指向设备，如：线路保护装置、开关',
    source_device          VARCHAR(100) DEFAULT NULL COMMENT '采集源设备，如：线路保护装置',
    integration_device     VARCHAR(100) DEFAULT NULL COMMENT '数据集成设备，如：线路保护装置',
    update_time            DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_by              VARCHAR(64)  DEFAULT '' COMMENT '创建者',
    create_time            DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by              VARCHAR(64)  DEFAULT '' COMMENT '更新者',
    remark                 VARCHAR(500) DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (id),
    KEY idx_device_type (device_type),
    KEY idx_voltage_level (voltage_level),
    KEY idx_alarm_level (alarm_level),
    KEY idx_info_name (info_name(255)),
    KEY idx_update_time (update_time)
) ENGINE = InnoDB COMMENT = '典型监控信息管理表';


INSERT INTO sys_typical_monitor_info (device_type, device_principle, info_name, voltage_level, alarm_status,
                                      alarm_level,
                                      send_to_monitor, reference_basis, collection_requirement, target_device,
                                      source_device, integration_device, create_by)
VALUES ('开关保护', '通用', '[电压等级] [间隔名称] [设备编号] 保护（型号）光纤通道一软压板', '550/220kV', '告警', 4, 1,
        '新一代', '实时采集', '线路保护装置', '线路保护装置', '线路保护装置', 'admin'),
       ('线路保护（220kV及以上）', '带过压远跳功能', '[电压等级] [间隔名称] [设备编号] 保护（型号）光纤通道二软压板',
        '500kV', '告警', 4, 1, '新一代', '实时采集', '线路保护装置', '线路保护装置', '线路保护装置', 'admin'),
       ('线路保护（220kV及以上）', '带过压远跳功能', '[电压等级] [间隔名称] [设备编号] 保护（型号）沟通三跳软压板', '220kV',
        '告警', 4, 1, '新一代', '实时采集', '线路保护装置', '线路保护装置', '线路保护装置', 'admin'),
       ('开关保护', '通用', '[电压等级] [间隔名称] [设备编号] 保护出口', '550/220kV', '告警', 4, 1, '2020企标',
        '实时采集', '线路', '线路保护装置', '线路保护装置', 'admin'),
       ('开关保护', '通用', '[电压等级] [间隔名称] [设备编号] 保护（型号）远方其他保护出口', '550/220kV', '告警', 4, 1,
        '2020企标', '实时采集', '线路', '线路保护装置', '线路保护装置', 'admin'),
       ('线路保护（220kV及以上）', '通用', '[电压等级] [间隔名称] [设备编号] 保护（型号）沟通三跳软压板', '550/220kV',
        '告警', 4, 1, '2020企标', '实时采集', '开关', '线路保护装置', '线路保护装置', 'admin');


-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('典型监控信息管理', '1', '1', 'monitor', 'system/monitor/index', 1, 0, 'C', '0', '0', 'system:monitor:list', 'build', 'admin', sysdate(), '', null, '典型监控信息管理菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('典型监控信息管理查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:monitor:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('典型监控信息管理新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:monitor:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('典型监控信息管理修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:monitor:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('典型监控信息管理删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:monitor:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('典型监控信息管理导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:monitor:export',       '#', 'admin', sysdate(), '', null, '');

-- 停用词表
DROP TABLE IF EXISTS sys_stop_word;
CREATE TABLE sys_stop_word
(
    id          BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    stop_word   VARCHAR(100) NOT NULL COMMENT '停用词内容（如：的、-4、空格、& 等）',
    create_by   VARCHAR(64)  DEFAULT '' COMMENT '添加人',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by   VARCHAR(64)  DEFAULT '' COMMENT '更新人',
    update_time DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark      VARCHAR(500) DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (id),
    UNIQUE KEY uk_stop_word (stop_word),
    KEY idx_create_time (create_time)
) ENGINE = InnoDB COMMENT = '停用语料库表';


INSERT INTO sys_stop_word (stop_word, create_by, remark)
VALUES ('的', '李四', '常见虚词'),
       ('-4', '张三', '无效数值'),
       ('空格', '李四', '空白字符'),
       ('&', '李四', '特殊符号'),
       ('...', '李四', '省略号');

-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('停用语料库', '1', '1', 'word', 'system/word/index', 1, 0, 'C', '0', '0', 'system:word:list', 'build', 'admin', sysdate(), '', null, '停用语料库菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('停用语料库查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:word:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('停用语料库新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:word:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('停用语料库修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:word:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('停用语料库删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:word:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('停用语料库导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:word:export',       '#', 'admin', sysdate(), '', null, '');




