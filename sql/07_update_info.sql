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

