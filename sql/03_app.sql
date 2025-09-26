USE app;
SET NAMES utf8mb4;
SET character_set_database = utf8mb4;
SET collation_database = utf8mb4_0900_ai_ci;
-- ----------------------------
-- 1、部门表
-- ----------------------------
drop table if exists sys_dept;
create table sys_dept (
  dept_id           bigint(20)      not null auto_increment    comment '部门id',
  parent_id         bigint(20)      default 0                  comment '父部门id',
  ancestors         varchar(50)     default ''                 comment '祖级列表',
  dept_name         varchar(30)     default ''                 comment '部门名称',
  order_num         int(4)          default 0                  comment '显示顺序',
  leader            varchar(20)     default null               comment '负责人',
  phone             varchar(11)     default null               comment '联系电话',
  email             varchar(50)     default null               comment '邮箱',
  status            char(1)         default '0'                comment '部门状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time 	    datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  primary key (dept_id)
) engine=innodb auto_increment=200 comment = '部门表';

-- ----------------------------
-- 初始化-部门表数据
-- ----------------------------
insert into sys_dept values(100,  0,   '0',          '雅安供电公司',   0,   'XX', '15888888888', 'xxx@sc.sgcc.com.cn', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(101,  100, '0,100',      '数字化部', 1,   'XX', '15888888888', 'xxx@sc.sgcc.com.cn', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(102,  100, '0,100',      '运检部', 2,   'XX', '15888888888', 'xxx@sc.sgcc.com.cn', '0', '0', 'admin', sysdate(), '', null);


-- ----------------------------
-- 2、用户信息表
-- ----------------------------
drop table if exists sys_user;
create table sys_user (
  user_id           bigint(20)      not null auto_increment    comment '用户ID',
  dept_id           bigint(20)      default null               comment '部门ID',
  user_name         varchar(30)     not null                   comment '用户账号',
  nick_name         varchar(30)     not null                   comment '用户昵称',
  user_type         varchar(2)      default '00'               comment '用户类型（00系统用户）',
  email             varchar(50)     default ''                 comment '用户邮箱',
  phonenumber       varchar(11)     default ''                 comment '手机号码',
  sex               char(1)         default '0'                comment '用户性别（0男 1女 2未知）',
  avatar            varchar(100)    default ''                 comment '头像地址',
  password          varchar(100)    default ''                 comment '密码',
  status            char(1)         default '0'                comment '账号状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  login_ip          varchar(128)    default ''                 comment '最后登录IP',
  login_date        datetime                                   comment '最后登录时间',
  pwd_update_date   datetime                                   comment '密码最后更新时间',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (user_id)
) engine=innodb auto_increment=100 comment = '用户信息表';

-- ----------------------------
-- 初始化-用户信息表数据
-- ----------------------------
insert into sys_user values(1,  101, 'admin','admin', '00', 'xxx@sc.sgcc.com.cn', '15888888888', '1', '', '$2a$10$bPN3m9ayxA.OMbqPmv30lO9EpIlsuTQQ2CdOsFbZM5ZDRYbm5eNBa', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '管理员');
insert into sys_user values(2,  101, 'shuzihua_1','shuzihua_1', '00', 'xxx@sc.sgcc.com.cn',  '15666666666', '1', '', '$2a$10$K6h.hRZ9dgawhHpqGDdBR.UsjFMu8NZPfSwoZOtpLp1y19ItfTZBa', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(3,  101, 'shuzihua_2','shuzihua_2', '00', 'xxx@sc.sgcc.com.cn',  '15666666666', '1', '', '$2a$10$K6h.hRZ9dgawhHpqGDdBR.UsjFMu8NZPfSwoZOtpLp1y19ItfTZBa', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(4,  101, 'shuzihua_3','shuzihua_3', '00', 'xxx@sc.sgcc.com.cn',  '15666666666', '1', '', '$2a$10$K6h.hRZ9dgawhHpqGDdBR.UsjFMu8NZPfSwoZOtpLp1y19ItfTZBa', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(5,  101, 'shuzihua_4','shuzihua_4', '00', 'xxx@sc.sgcc.com.cn',  '15666666666', '1', '', '$2a$10$K6h.hRZ9dgawhHpqGDdBR.UsjFMu8NZPfSwoZOtpLp1y19ItfTZBa', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(6,  101, 'shuzihua_5','shuzihua_5', '00', 'xxx@sc.sgcc.com.cn',  '15666666666', '1', '', '$2a$10$K6h.hRZ9dgawhHpqGDdBR.UsjFMu8NZPfSwoZOtpLp1y19ItfTZBa', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(7,  102, 'yunjian_1','yunjian_1', '00', 'xxx@sc.sgcc.com.cn',  '15677777777', '1', '', '$2a$10$fFKzolYkRetWITivS.sugO2Amky989v3T.DFD1WMd.1j1T3uUyZyy', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(8,  102, 'yunjian_2','yunjian_2', '00', 'xxx@sc.sgcc.com.cn',  '15677777777', '1', '', '$2a$10$fFKzolYkRetWITivS.sugO2Amky989v3T.DFD1WMd.1j1T3uUyZyy', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(9,  102, 'yunjian_3','yunjian_3', '00', 'xxx@sc.sgcc.com.cn',  '15677777777', '1', '', '$2a$10$fFKzolYkRetWITivS.sugO2Amky989v3T.DFD1WMd.1j1T3uUyZyy', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(10, 102, 'yunjian_4','yunjian_4', '00', 'xxx@sc.sgcc.com.cn',  '15677777777', '1', '', '$2a$10$fFKzolYkRetWITivS.sugO2Amky989v3T.DFD1WMd.1j1T3uUyZyy', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(11, 102, 'yunjian_5','yunjian_5', '00', 'xxx@sc.sgcc.com.cn',  '15677777777', '1', '', '$2a$10$fFKzolYkRetWITivS.sugO2Amky989v3T.DFD1WMd.1j1T3uUyZyy', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(12, 102, 'yunjian_6','yunjian_6', '00', 'xxx@sc.sgcc.com.cn',  '15677777777', '1', '', '$2a$10$fFKzolYkRetWITivS.sugO2Amky989v3T.DFD1WMd.1j1T3uUyZyy', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(13, 102, 'yunjian_7','yunjian_7', '00', 'xxx@sc.sgcc.com.cn',  '15677777777', '1', '', '$2a$10$fFKzolYkRetWITivS.sugO2Amky989v3T.DFD1WMd.1j1T3uUyZyy', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(14, 102, 'yunjian_8','yunjian_8', '00', 'xxx@sc.sgcc.com.cn',  '15677777777', '1', '', '$2a$10$fFKzolYkRetWITivS.sugO2Amky989v3T.DFD1WMd.1j1T3uUyZyy', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(15, 102, 'yunjian_9','yunjian_9', '00', 'xxx@sc.sgcc.com.cn',  '15677777777', '1', '', '$2a$10$fFKzolYkRetWITivS.sugO2Amky989v3T.DFD1WMd.1j1T3uUyZyy', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');
insert into sys_user values(16, 102, 'yunjian_10','yunjian_10', '00', 'xxx@sc.sgcc.com.cn',  '15677777777', '1', '', '$2a$10$fFKzolYkRetWITivS.sugO2Amky989v3T.DFD1WMd.1j1T3uUyZyy', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '专责');




-- ----------------------------
-- 3、岗位信息表
-- ----------------------------
drop table if exists sys_post;
create table sys_post
(
  post_id       bigint(20)      not null auto_increment    comment '岗位ID',
  post_code     varchar(64)     not null                   comment '岗位编码',
  post_name     varchar(50)     not null                   comment '岗位名称',
  post_sort     int(4)          not null                   comment '显示顺序',
  status        char(1)         not null                   comment '状态（0正常 1停用）',
  create_by     varchar(64)     default ''                 comment '创建者',
  create_time   datetime                                   comment '创建时间',
  update_by     varchar(64)     default ''			       comment '更新者',
  update_time   datetime                                   comment '更新时间',
  remark        varchar(500)    default null               comment '备注',
  primary key (post_id)
) engine=innodb comment = '岗位信息表';

-- ----------------------------
-- 初始化-岗位信息表数据
-- ----------------------------
insert into sys_post values(1, 'zhuanze',  '专责',    1, '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 4、角色信息表
-- ----------------------------
drop table if exists sys_role;
create table sys_role (
  role_id              bigint(20)      not null auto_increment    comment '角色ID',
  role_name            varchar(30)     not null                   comment '角色名称',
  role_key             varchar(100)    not null                   comment '角色权限字符串',
  role_sort            int(4)          not null                   comment '显示顺序',
  data_scope           char(1)         default '1'                comment '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  menu_check_strictly  tinyint(1)      default 1                  comment '菜单树选择项是否关联显示',
  dept_check_strictly  tinyint(1)      default 1                  comment '部门树选择项是否关联显示',
  status               char(1)         not null                   comment '角色状态（0正常 1停用）',
  del_flag             char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by            varchar(64)     default ''                 comment '创建者',
  create_time          datetime                                   comment '创建时间',
  update_by            varchar(64)     default ''                 comment '更新者',
  update_time          datetime                                   comment '更新时间',
  remark               varchar(500)    default null               comment '备注',
  primary key (role_id)
) engine=innodb auto_increment=100 comment = '角色信息表';

-- ----------------------------
-- 初始化-角色信息表数据
-- ----------------------------
insert into sys_role values('1', '管理员',  'admin',  1, 1, 1, 1, '0', '0', 'admin', sysdate(), '', null, '管理员');
insert into sys_role values('2', '普通角色',    'common', 2, 2, 1, 1, '0', '0', 'admin', sysdate(), '', null, '普通角色');


-- ----------------------------
-- 5、菜单权限表
-- ----------------------------
drop table if exists sys_menu;
create table sys_menu (
  menu_id           bigint(20)      not null auto_increment    comment '菜单ID',
  menu_name         varchar(50)     not null                   comment '菜单名称',
  parent_id         bigint(20)      default 0                  comment '父菜单ID',
  order_num         int(4)          default 0                  comment '显示顺序',
  path              varchar(200)    default ''                 comment '路由地址',
  component         varchar(255)    default null               comment '组件路径',
  query             varchar(255)    default null               comment '路由参数',
  route_name        varchar(50)     default ''                 comment '路由名称',
  is_frame          int(1)          default 1                  comment '是否为外链（0是 1否）',
  is_cache          int(1)          default 0                  comment '是否缓存（0缓存 1不缓存）',
  menu_type         char(1)         default ''                 comment '菜单类型（M目录 C菜单 F按钮）',
  visible           char(1)         default 0                  comment '菜单状态（0显示 1隐藏）',
  status            char(1)         default 0                  comment '菜单状态（0正常 1停用）',
  perms             varchar(100)    default null               comment '权限标识',
  icon              varchar(100)    default '#'                comment '菜单图标',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default ''                 comment '备注',
  primary key (menu_id)
) engine=innodb auto_increment=2000 comment = '菜单权限表';

-- ----------------------------
-- 初始化-菜单信息表数据
-- ----------------------------
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1, '综合管理', 0, 10, 'system', null, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-08-11 13:45:41', 'admin', '2025-09-04 02:50:33', '系统管理目录');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2, '状态监控', 1, 11, 'monitor', null, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-07-15 03:09:41', 'admin', '2025-09-18 02:08:08', '系统监控目录');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (3, '系统工具', 1, 11, 'tool', null, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-08-02 23:14:41', 'admin', '2025-09-04 02:50:03', '系统工具目录');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (100, '个人信息管理', 1, 9, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-07-19 06:52:41', 'admin', '2025-09-06 14:48:18', '用户管理菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (101, '角色管理', 1, 5, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-07-18 10:37:41', 'admin', '2025-09-06 14:14:30', '角色管理菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (102, '菜单管理', 1, 7, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-08-15 03:02:41', 'admin', '2025-09-06 14:16:30', '菜单管理菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (103, '部门管理', 1, 3, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-08-27 15:21:41', 'admin', '2025-09-06 14:14:17', '部门管理菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '1', '0', 'system:post:list', 'post', 'admin', '2025-07-31 09:14:41', 'admin', '2025-09-06 14:47:29', '岗位管理菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (105, '常用数据字典管理', 1, 21, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-07-11 09:13:41', 'admin', '2025-09-06 14:19:38', '字典管理菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '1', '0', 'system:config:list', 'edit', 'admin', '2025-07-20 17:17:41', 'admin', '2025-09-06 14:48:55', '参数设置菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '1', '0', 'system:notice:list', 'message', 'admin', '2025-09-04 02:35:41', 'admin', '2025-09-06 14:49:00', '通知公告菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (108, '日志管理', 1, 8, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-08-03 12:33:41', 'admin', '2025-09-06 14:16:37', '日志管理菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '1', '0', 'monitor:online:list', 'online', 'admin', '2025-09-03 15:37:41', 'admin', '2025-09-18 02:08:17', '在线用户菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (110, '定时任务', 0, 8, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-07-30 16:45:41', 'admin', '2025-09-18 02:10:06', '定时任务菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-08-08 12:04:41', '', '2025-08-08 20:30:30', '数据监控菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-07-29 10:29:41', '', '2025-08-09 23:44:29', '服务监控菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '1', '0', 'monitor:cache:list', 'redis', 'admin', '2025-07-21 08:27:41', 'admin', '2025-09-18 02:08:24', '缓存监控菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '1', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-08-15 22:35:41', 'admin', '2025-09-18 02:08:28', '缓存列表菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-08-04 11:55:41', '', '2025-08-14 12:34:31', '表单构建菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-08-12 12:44:41', '', '2025-08-26 00:21:55', '代码生成菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-08-25 03:24:41', '', '2025-09-03 21:24:23', '系统接口菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-08-15 18:48:41', '', '2025-08-22 21:41:45', '操作日志菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-08-06 11:17:41', '', '2025-08-14 20:59:03', '登录日志菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-07-31 19:20:41', '', '2025-08-14 09:31:03', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-08-25 02:21:41', '', '2025-08-25 14:10:02', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-08-30 01:03:41', '', '2025-08-30 16:36:10', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-08-07 21:04:41', '', '2025-08-17 05:34:31', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-08-21 14:22:41', '', '2025-08-26 15:51:38', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-07-08 14:11:41', '', '2025-08-16 05:41:49', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-09-05 05:22:41', '', '2025-09-05 13:34:08', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-07-17 08:48:41', '', '2025-08-07 15:08:49', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-07-22 15:37:41', '', '2025-08-03 23:22:17', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-08-24 16:39:41', '', '2025-08-25 22:14:07', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-08-14 10:15:41', '', '2025-08-29 23:52:23', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-09-02 11:47:41', '', '2025-09-02 20:05:25', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-07-29 06:27:41', '', '2025-08-14 05:48:56', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-07-25 01:47:41', '', '2025-08-27 19:15:34', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-07-23 07:03:41', '', '2025-08-22 05:52:22', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-08-29 10:32:41', '', '2025-09-06 08:22:26', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-07-14 13:40:41', '', '2025-09-02 12:15:40', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-08-14 18:30:41', '', '2025-08-30 06:39:37', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-08-24 00:44:41', '', '2025-09-01 13:36:27', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-09-02 18:26:41', '', '2025-09-03 05:30:37', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-08-10 14:36:41', '', '2025-08-29 21:03:13', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-08-19 02:33:41', '', '2025-08-23 00:16:09', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-08-15 07:30:41', '', '2025-09-04 12:34:39', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-08-26 17:19:41', '', '2025-09-05 15:03:10', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-08-19 14:32:41', '', '2025-09-04 02:19:25', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-07-20 23:12:41', '', '2025-08-17 02:41:49', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-07-27 12:11:41', '', '2025-08-07 01:07:36', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-08-28 18:06:41', '', '2025-09-02 18:01:04', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-07-26 23:03:41', '', '2025-07-30 16:02:32', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-08-26 05:56:41', '', '2025-09-03 10:49:43', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-08-25 12:42:41', '', '2025-08-30 02:15:47', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-07-17 16:56:41', '', '2025-08-23 05:14:36', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-07-31 22:55:41', '', '2025-08-17 09:19:56', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-07-08 22:37:41', '', '2025-07-14 10:20:23', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-07-21 00:33:41', '', '2025-07-26 07:20:13', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-08-09 18:02:41', '', '2025-08-17 12:23:50', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-08-20 04:15:41', '', '2025-08-21 07:39:08', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-08-08 15:19:41', '', '2025-08-22 18:26:08', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-07-26 00:44:41', '', '2025-08-05 16:39:09', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-08-15 00:31:41', '', '2025-09-01 16:30:29', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-07-16 10:09:41', '', '2025-07-25 17:10:02', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-07-27 13:10:41', '', '2025-08-18 09:03:23', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-08-14 02:49:41', '', '2025-08-17 04:05:23', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-07-09 00:28:41', '', '2025-07-12 04:50:20', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-08-03 21:31:41', '', '2025-09-02 07:25:32', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-08-24 23:24:41', '', '2025-08-27 16:46:35', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-07-25 19:35:41', '', '2025-08-14 12:14:27', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-07-26 08:08:41', '', '2025-08-22 22:16:42', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-08-30 11:38:41', '', '2025-09-05 16:54:48', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-07-31 23:48:41', '', '2025-08-18 10:22:31', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-08-30 04:27:41', '', '2025-09-04 11:23:46', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-07-29 03:36:41', '', '2025-08-05 13:38:00', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-08-13 16:16:41', '', '2025-08-31 23:58:37', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-08-25 12:20:41', '', '2025-08-28 21:19:46', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-07-21 05:24:41', '', '2025-07-25 23:38:50', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-07-16 00:43:41', '', '2025-08-19 13:08:25', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-09-04 21:22:41', '', '2025-09-06 11:12:59', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-07-21 06:14:41', '', '2025-09-04 20:48:24', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-08-27 04:27:41', '', '2025-09-05 02:13:18', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-08-29 03:10:41', '', '2025-09-01 16:38:11', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-08-26 02:43:41', '', '2025-09-01 05:20:14', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2000, '信息点表管理', 1, 4, 'info', 'system/info/index', null, '', 1, 0, 'C', '0', '0', 'system:info:edit', 'online', 'admin', '2025-08-23 21:08:41', 'admin', '2025-09-06 14:14:23', '信号信息菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2001, '信号信息查询', 2000, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:info:query', '#', 'admin', '2025-07-28 22:07:41', '', '2025-08-14 00:33:36', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2002, '信号信息新增', 2000, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:info:add', '#', 'admin', '2025-07-23 12:36:41', '', '2025-08-11 13:31:18', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2003, '信号信息修改', 2000, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:info:edit', '#', 'admin', '2025-07-30 18:45:41', '', '2025-09-02 13:48:24', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2004, '信号信息删除', 2000, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:info:remove', '#', 'admin', '2025-07-21 16:56:41', '', '2025-07-31 13:52:41', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2005, '信号信息导出', 2000, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:info:export', '#', 'admin', '2025-08-22 19:35:41', '', '2025-08-28 04:35:12', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2006, '调用管理', 0, 6, 'call', 'system/call/index', null, '', 1, 0, 'C', '0', '0', 'system:call:edit', 'redis-list', 'admin', '2025-08-14 12:19:41', 'admin', '2025-08-28 13:20:58', '遥信调用记录菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2007, '遥信调用记录查询', 2006, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:call:query', '#', 'admin', '2025-07-29 06:01:41', '', '2025-08-06 01:10:22', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2008, '遥信调用记录新增', 2006, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:call:add', '#', 'admin', '2025-08-20 01:54:41', '', '2025-09-04 15:38:48', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2009, '遥信调用记录修改', 2006, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:call:edit', '#', 'admin', '2025-07-13 22:58:41', '', '2025-08-30 18:26:13', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2010, '遥信调用记录删除', 2006, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:call:remove', '#', 'admin', '2025-08-25 07:25:41', '', '2025-09-02 20:02:53', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2011, '遥信调用记录导出', 2006, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:call:export', '#', 'admin', '2025-08-06 16:59:41', '', '2025-09-02 11:56:28', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2012, '变电站监控信息样本库管理', 0, 0, 'all', 'system/all/index', null, '', 1, 0, 'C', '0', '0', 'system:all:edit', 'documentation', 'admin', '2025-09-03 22:55:41', 'admin', '2025-09-04 14:12:26', '样本库菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2013, '样本库查询', 2012, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:all:query', '#', 'admin', '2025-07-27 11:45:41', '', '2025-08-22 23:44:34', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2014, '样本库新增', 2012, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:all:add', '#', 'admin', '2025-07-18 08:39:41', '', '2025-08-11 06:55:11', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2015, '样本库修改', 2012, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:all:edit', '#', 'admin', '2025-09-03 17:38:41', '', '2025-09-04 23:12:07', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2016, '样本库删除', 2012, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:all:remove', '#', 'admin', '2025-09-03 23:25:41', '', '2025-09-05 23:59:24', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2017, '样本库导出', 2012, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:all:export', '#', 'admin', '2025-08-22 01:36:41', '', '2025-09-01 15:55:45', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2018, '标注任务管理', 2061, 1, 'task', 'system/task/index', null, '', 1, 0, 'C', '0', '0', 'system:task:edit', 'code', 'admin', '2025-08-21 21:14:41', 'admin', '2025-09-04 02:20:43', '样本标注任务菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2019, '样本标注任务查询', 2018, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:task:query', '#', 'admin', '2025-07-08 17:06:41', '', '2025-07-09 19:02:27', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2020, '样本标注任务新增', 2018, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:task:add', '#', 'admin', '2025-08-05 15:18:41', '', '2025-08-06 13:15:20', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2021, '样本标注任务修改', 2018, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:task:edit', '#', 'admin', '2025-08-29 16:34:41', '', '2025-08-30 09:17:24', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2022, '样本标注任务删除', 2018, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:task:remove', '#', 'admin', '2025-08-18 18:17:41', '', '2025-08-25 12:17:20', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2023, '样本标注任务导出', 2018, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:task:export', '#', 'admin', '2025-08-02 14:45:41', '', '2025-08-21 06:02:40', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2024, '样本数据版本管理', 2061, 1, 'version', 'system/version/index', null, '', 1, 0, 'C', '1', '0', 'system:version:list', 'build', 'admin', '2025-08-17 11:14:41', 'admin', '2025-09-04 02:20:38', '样本数据版本管理菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2025, '样本数据版本管理查询', 2024, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:version:query', '#', 'admin', '2025-08-24 01:58:41', '', '2025-09-01 00:01:36', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2026, '样本数据版本管理新增', 2024, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:version:add', '#', 'admin', '2025-08-24 16:51:41', '', '2025-08-29 04:23:56', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2027, '样本数据版本管理修改', 2024, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:version:edit', '#', 'admin', '2025-08-28 04:09:41', '', '2025-09-06 07:14:54', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2028, '样本数据版本管理删除', 2024, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:version:remove', '#', 'admin', '2025-07-21 18:06:41', '', '2025-08-30 10:48:08', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2029, '样本数据版本管理导出', 2024, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:version:export', '#', 'admin', '2025-08-29 14:47:41', '', '2025-09-01 00:42:20', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2030, '同义词库配置', 2061, 2, 'synonym', 'system/synonym/index', null, '', 1, 0, 'C', '0', '0', 'system:synonym:list', 'build', 'admin', '2025-07-27 13:27:41', 'admin', '2025-09-06 14:13:30', '同义词库菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2031, '同义词库查询', 2030, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:synonym:query', '#', 'admin', '2025-08-05 15:23:41', '', '2025-09-05 23:58:47', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2032, '同义词库新增', 2030, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:synonym:add', '#', 'admin', '2025-08-28 20:00:41', '', '2025-08-28 20:46:33', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2033, '同义词库修改', 2030, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:synonym:edit', '#', 'admin', '2025-08-28 22:07:41', '', '2025-08-29 11:21:02', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2034, '同义词库删除', 2030, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:synonym:remove', '#', 'admin', '2025-08-12 10:45:41', '', '2025-08-20 05:24:04', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2035, '同义词库导出', 2030, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:synonym:export', '#', 'admin', '2025-07-21 19:34:41', '', '2025-08-07 14:47:16', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2036, '监控信息管理', 0, 4, 'system/monitor', 'system/monitor/index', null, '', 1, 0, 'C', '0', '0', 'system:monitor:list', 'build', 'admin', '2025-08-20 23:35:41', 'admin', '2025-08-28 13:20:43', '典型监控信息管理菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2037, '典型监控信息管理查询', 2036, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:monitor:query', '#', 'admin', '2025-07-29 01:34:41', '', '2025-09-01 06:53:41', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2038, '典型监控信息管理新增', 2036, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:monitor:add', '#', 'admin', '2025-07-17 15:52:41', '', '2025-07-30 21:46:06', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2039, '典型监控信息管理修改', 2036, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:monitor:edit', '#', 'admin', '2025-07-13 12:08:41', '', '2025-08-20 22:07:46', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2040, '典型监控信息管理删除', 2036, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:monitor:remove', '#', 'admin', '2025-08-24 12:13:41', '', '2025-09-02 17:54:38', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2041, '典型监控信息管理导出', 2036, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:monitor:export', '#', 'admin', '2025-08-04 22:10:41', '', '2025-08-19 23:47:32', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2042, '停用语料库', 2061, 1, 'word', 'system/word/index', null, '', 1, 0, 'C', '1', '0', 'system:word:list', 'build', 'admin', '2025-08-19 21:51:41', 'admin', '2025-09-04 02:20:48', '停用语料库菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2043, '停用语料库查询', 2042, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:word:query', '#', 'admin', '2025-08-04 01:41:41', '', '2025-08-10 00:39:35', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2044, '停用语料库新增', 2042, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:word:add', '#', 'admin', '2025-08-18 09:59:41', '', '2025-08-28 00:17:08', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2045, '停用语料库修改', 2042, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:word:edit', '#', 'admin', '2025-09-03 16:43:41', '', '2025-09-06 10:24:31', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2046, '停用语料库删除', 2042, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:word:remove', '#', 'admin', '2025-08-17 21:59:41', '', '2025-08-25 15:50:49', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2047, '停用语料库导出', 2042, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:word:export', '#', 'admin', '2025-07-09 19:57:41', '', '2025-07-11 21:45:03', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2048, '模型训练记录', 2062, 2, 'record', 'system/record/index', null, '', 1, 0, 'C', '0', '0', 'system:record:list', 'build', 'admin', '2025-08-14 04:45:41', 'admin', '2025-09-04 02:22:33', '模型训练记录菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2049, '模型训练记录查询', 2048, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:record:query', '#', 'admin', '2025-08-12 00:54:41', '', '2025-09-06 05:25:10', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2050, '模型训练记录新增', 2048, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:record:add', '#', 'admin', '2025-08-22 00:55:41', '', '2025-09-04 01:20:37', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2051, '模型训练记录修改', 2048, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:record:edit', '#', 'admin', '2025-08-04 15:21:41', '', '2025-08-12 15:44:12', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2052, '模型训练记录删除', 2048, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:record:remove', '#', 'admin', '2025-08-17 11:20:41', '', '2025-08-31 07:49:36', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2053, '模型训练记录导出', 2048, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:record:export', '#', 'admin', '2025-08-31 19:34:41', '', '2025-09-04 22:46:29', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2054, '模型信息概览', 2062, 1, 'model', 'system/model/index', null, '', 1, 0, 'C', '0', '0', 'system:model:list', 'international', 'admin', '2025-07-27 07:59:41', 'admin', '2025-09-04 02:23:08', '模型信息菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2055, '模型信息查询', 2054, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:model:query', '#', 'admin', '2025-08-15 04:59:41', '', '2025-08-27 20:31:49', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2056, '模型信息新增', 2054, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:model:add', '#', 'admin', '2025-08-13 00:43:41', '', '2025-08-28 23:21:45', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2057, '模型信息修改', 2054, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:model:edit', '#', 'admin', '2025-09-05 10:01:41', '', '2025-09-06 00:18:02', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2058, '模型信息删除', 2054, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:model:remove', '#', 'admin', '2025-07-22 17:30:41', '', '2025-08-29 13:08:03', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2059, '模型信息导出', 2054, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:model:export', '#', 'admin', '2025-07-23 08:01:41', '', '2025-08-13 05:53:40', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2060, '监控信息命名规范知识图谱', 0, 3, 'knowledgegraph', 'knowledgegraph/index', null, '', 1, 0, 'C', '0', '0', '', 'chart', 'admin', '2025-07-31 12:52:41', 'admin', '2025-09-04 02:23:30', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2061, '监控信息样本标注管理', 0, 1, 'task', null, null, '', 1, 0, 'M', '0', '0', null, 'list', 'admin', '2025-07-17 11:20:41', '', '2025-08-29 03:05:15', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2062, '算法模型管理', 0, 2, 'model', null, null, '', 1, 0, 'M', '0', '0', null, 'international', 'admin', '2025-08-16 04:08:41', '', '2025-09-02 00:59:31', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2063, '变电辅助分析大屏一览', 1, 0, 'http://47.110.76.101:6204', null, null, '', 0, 0, 'M', '0', '0', '', 'chart', 'admin', '2025-07-12 00:09:41', 'admin', '2025-09-06 11:38:26', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2064, '事件化合成业务展示', 1, 1, 'flowchart', 'system/flowchart/index', null, '', 1, 0, 'C', '0', '0', '', 'number', 'admin', '2025-08-14 22:00:41', 'admin', '2025-09-04 02:56:28', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2065, '帮助中心', 1, 15, 'helpcenter', 'system/helpcenter/index', null, '', 1, 0, 'C', '0', '0', '', 'user', 'admin', '2025-08-01 00:30:41', 'admin', '2025-09-06 14:18:14', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2066, '限流管理', 1, 17, 'confine', 'system/confine/index', null, '', 1, 0, 'C', '0', '0', '', 'example', 'admin', '2025-07-15 22:10:41', 'admin', '2025-09-06 14:18:39', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2067, '应用成效展示', 1, 18, 'results', 'system/results/index', null, '', 1, 0, 'C', '0', '0', '', 'server', 'admin', '2025-08-09 12:56:41', 'admin', '2025-09-06 14:18:48', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2068, '意见反馈', 1, 16, 'feedback', 'system/feedback/index', null, '', 1, 0, 'C', '0', '0', 'system:feedback:list', 'build', 'admin', '2025-08-09 07:23:41', 'admin', '2025-09-06 14:18:27', '意见反馈菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2069, '意见反馈查询', 2068, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:feedback:query', '#', 'admin', '2025-08-23 10:57:41', '', '2025-09-06 11:38:55', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2070, '意见反馈新增', 2068, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:feedback:add', '#', 'admin', '2025-09-01 16:14:41', '', '2025-09-03 13:29:19', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2071, '意见反馈修改', 2068, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:feedback:edit', '#', 'admin', '2025-08-16 01:23:41', '', '2025-09-05 15:06:45', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2072, '意见反馈删除', 2068, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:feedback:remove', '#', 'admin', '2025-07-12 08:11:41', '', '2025-08-16 09:18:07', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2073, '意见反馈导出', 2068, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:feedback:export', '#', 'admin', '2025-07-20 17:48:41', '', '2025-08-01 05:57:40', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2074, '厂站管理', 1, 2, 'stinfo', 'system/stinfo/index', null, '', 1, 0, 'C', '0', '0', 'system:stinfo:list', 'list', 'admin', '2025-08-03 12:08:41', 'admin', '2025-09-06 14:20:42', '变电站信息菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2075, '厂站管理查询', 2074, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:stinfo:query', '#', 'admin', '2025-09-04 11:25:41', '', '2025-09-05 03:27:52', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2076, '厂站管理新增', 2074, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:stinfo:add', '#', 'admin', '2025-08-18 12:40:41', '', '2025-09-05 07:50:45', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2077, '厂站管理修改', 2074, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:stinfo:edit', '#', 'admin', '2025-07-20 15:29:41', '', '2025-08-22 23:50:58', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2078, '厂站管理删除', 2074, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:stinfo:remove', '#', 'admin', '2025-07-28 11:09:41', '', '2025-08-24 05:34:18', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2079, '厂站管理导出', 2074, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:stinfo:export', '#', 'admin', '2025-07-18 05:15:41', '', '2025-07-30 22:22:01', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2080, '映射结果对比', 1, 19, 'mpresult', 'system/mpresult/index', null, '', 1, 0, 'C', '0', '0', 'system:mpresult:list', 'drag', 'admin', '2025-08-04 08:23:41', 'admin', '2025-09-07 02:13:24', '映射结果菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2081, '映射结果查询', 2080, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:mpresult:query', '#', 'admin', '2025-07-09 21:04:41', '', '2025-08-10 00:48:39', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2082, '映射结果新增', 2080, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:mpresult:add', '#', 'admin', '2025-08-18 06:18:41', '', '2025-09-04 06:03:07', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2083, '映射结果修改', 2080, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:mpresult:edit', '#', 'admin', '2025-07-17 17:54:41', '', '2025-08-28 13:26:00', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2084, '映射结果删除', 2080, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:mpresult:remove', '#', 'admin', '2025-09-04 17:58:41', '', '2025-09-05 13:32:12', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2085, '映射结果导出', 2080, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:mpresult:export', '#', 'admin', '2025-08-01 22:10:41', '', '2025-09-01 23:16:09', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2086, '频发错误统计', 1, 20, 'mpresulterror', 'system/mpresult/error', null, '', 1, 0, 'C', '0', '0', '', 'guide', 'admin', '2025-07-13 04:53:41', 'admin', '2025-09-07 02:13:30', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2087, '监控信息人工修改', 1, 22, 'mpresultedit', 'system/mpresult/customedit', null, '', 1, 0, 'C', '0', '0', '', 'post', 'admin', '2025-07-14 07:07:41', 'admin', '2025-09-07 02:06:45', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2088, '旧版入口', 1, 23, 'http://47.110.76.101:6203', null, null, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2025-08-23 13:53:41', 'admin', '2025-09-06 14:45:44', '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2089, '模型预警', 2062, 3, 'warning', 'system/warning/index', null, '', 1, 0, 'C', '0', '0', 'system:warning:list', 'validCode', 'admin', '2025-09-07 09:34:55', 'admin', '2025-09-07 10:37:36', '模型预警菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2090, '模型预警查询', 2089, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:warning:query', '#', 'admin', '2025-09-07 09:34:57', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2091, '模型预警新增', 2089, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:warning:add', '#', 'admin', '2025-09-07 09:34:57', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2092, '模型预警修改', 2089, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:warning:edit', '#', 'admin', '2025-09-07 09:34:58', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2093, '模型预警删除', 2089, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:warning:remove', '#', 'admin', '2025-09-07 09:34:58', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2094, '模型预警导出', 2089, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:warning:export', '#', 'admin', '2025-09-07 09:34:59', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2095, '模型预警', 1, 1, 'warning', 'system/warning/index', null, '', 1, 0, 'C', '1', '0', 'system:warning:list', 'build', 'admin', '2025-09-09 01:12:11', 'admin', '2025-09-09 01:42:39', '模型预警菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2096, '模型预警查询', 2095, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:warning:query', '#', 'admin', '2025-09-09 01:12:13', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2097, '模型预警新增', 2095, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:warning:add', '#', 'admin', '2025-09-09 01:12:14', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2098, '模型预警修改', 2095, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:warning:edit', '#', 'admin', '2025-09-09 01:12:14', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2099, '模型预警删除', 2095, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:warning:remove', '#', 'admin', '2025-09-09 01:12:15', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2100, '模型预警导出', 2095, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:warning:export', '#', 'admin', '2025-09-09 01:12:16', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2101, '间隔信息管理', 1, 1, 'jginfo', 'system/jginfo/index', null, '', 1, 0, 'C', '0', '0', 'system:jginfo:list', 'build', 'admin', '2025-09-26 09:26:41', '', null, '间隔信息管理菜单');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2102, '间隔信息管理查询', 2101, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:jginfo:query', '#', 'admin', '2025-09-26 09:26:43', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2103, '间隔信息管理新增', 2101, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:jginfo:add', '#', 'admin', '2025-09-26 09:26:43', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2104, '间隔信息管理修改', 2101, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:jginfo:edit', '#', 'admin', '2025-09-26 09:26:44', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2105, '间隔信息管理删除', 2101, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:jginfo:remove', '#', 'admin', '2025-09-26 09:26:44', '', null, '');
INSERT INTO app.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2106, '间隔信息管理导出', 2101, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'system:jginfo:export', '#', 'admin', '2025-09-26 09:26:45', '', null, '');

-- ----------------------------
-- 6、用户和角色关联表  用户N-1角色
-- ----------------------------
drop table if exists sys_user_role;
create table sys_user_role (
  user_id   bigint(20) not null comment '用户ID',
  role_id   bigint(20) not null comment '角色ID',
  primary key(user_id, role_id)
) engine=innodb comment = '用户和角色关联表';

-- ----------------------------
-- 初始化-用户和角色关联表数据
-- ----------------------------
insert into sys_user_role values ('1', '1');
insert into sys_user_role values ('2', '2');
insert into sys_user_role values ('3', '2');
insert into sys_user_role values ('4', '2');
insert into sys_user_role values ('5', '2');
insert into sys_user_role values ('6', '2');
insert into sys_user_role values ('7', '2');
insert into sys_user_role values ('8', '2');
insert into sys_user_role values ('9', '2');
insert into sys_user_role values ('10', '2');
insert into sys_user_role values ('11', '2');
insert into sys_user_role values ('12', '2');
insert into sys_user_role values ('13', '2');
insert into sys_user_role values ('14', '2');
insert into sys_user_role values ('15', '2');
insert into sys_user_role values ('16', '2');


-- ----------------------------
-- 7、角色和菜单关联表  角色1-N菜单
-- ----------------------------
drop table if exists sys_role_menu;
create table sys_role_menu (
  role_id   bigint(20) not null comment '角色ID',
  menu_id   bigint(20) not null comment '菜单ID',
  primary key(role_id, menu_id)
) engine=innodb comment = '角色和菜单关联表';

-- ----------------------------
-- 初始化-角色和菜单关联表数据
-- ----------------------------
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,100);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,101);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,102);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,103);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,104);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,105);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,106);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,107);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,108);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,500);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,501);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1000);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1001);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1002);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1003);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1004);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1005);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1006);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1007);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1008);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1009);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1010);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1011);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1012);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1013);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1014);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1015);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1016);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1017);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1018);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1019);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1020);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1021);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1022);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1023);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1024);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1025);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1026);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1027);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1028);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1029);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1030);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1031);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1032);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1033);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1034);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1035);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1036);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1037);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1038);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1039);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1040);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1041);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1042);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1043);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1044);
INSERT INTO sys_role_menu (role_id,menu_id) VALUES (2,1045);


-- ----------------------------
-- 8、角色和部门关联表  角色1-N部门
-- ----------------------------
drop table if exists sys_role_dept;
create table sys_role_dept (
  role_id   bigint(20) not null comment '角色ID',
  dept_id   bigint(20) not null comment '部门ID',
  primary key(role_id, dept_id)
) engine=innodb comment = '角色和部门关联表';

-- ----------------------------
-- 初始化-角色和部门关联表数据
-- ----------------------------
insert into sys_role_dept values ('2', '100');
insert into sys_role_dept values ('2', '101');
insert into sys_role_dept values ('2', '102');


-- ----------------------------
-- 9、用户与岗位关联表  用户1-N岗位
-- ----------------------------
drop table if exists sys_user_post;
create table sys_user_post
(
  user_id   bigint(20) not null comment '用户ID',
  post_id   bigint(20) not null comment '岗位ID',
  primary key (user_id, post_id)
) engine=innodb comment = '用户与岗位关联表';

-- ----------------------------
-- 初始化-用户与岗位关联表数据
-- ----------------------------
insert into sys_user_post values ('1', '1');
insert into sys_user_post values ('2', '1');
insert into sys_user_post values ('3', '1');
insert into sys_user_post values ('4', '1');
insert into sys_user_post values ('5', '1');
insert into sys_user_post values ('6', '1');
insert into sys_user_post values ('7', '1');
insert into sys_user_post values ('8', '1');
insert into sys_user_post values ('9', '1');
insert into sys_user_post values ('10', '1');
insert into sys_user_post values ('11', '1');
insert into sys_user_post values ('12', '1');
insert into sys_user_post values ('13', '1');
insert into sys_user_post values ('14', '1');
insert into sys_user_post values ('15', '1');
insert into sys_user_post values ('16', '1');



-- ----------------------------
-- 10、操作日志记录
-- ----------------------------
drop table if exists sys_oper_log;
create table sys_oper_log (
  oper_id           bigint(20)      not null auto_increment    comment '日志主键',
  title             varchar(50)     default ''                 comment '模块标题',
  business_type     int(2)          default 0                  comment '业务类型（0其它 1新增 2修改 3删除）',
  method            varchar(200)    default ''                 comment '方法名称',
  request_method    varchar(10)     default ''                 comment '请求方式',
  operator_type     int(1)          default 0                  comment '操作类别（0其它 1后台用户 2手机端用户）',
  oper_name         varchar(50)     default ''                 comment '操作人员',
  dept_name         varchar(50)     default ''                 comment '部门名称',
  oper_url          varchar(255)    default ''                 comment '请求URL',
  oper_ip           varchar(128)    default ''                 comment '主机地址',
  oper_location     varchar(255)    default ''                 comment '操作地点',
  oper_param        varchar(2000)   default ''                 comment '请求参数',
  json_result       varchar(2000)   default ''                 comment '返回参数',
  status            int(1)          default 0                  comment '操作状态（0正常 1异常）',
  error_msg         varchar(2000)   default ''                 comment '错误消息',
  oper_time         datetime                                   comment '操作时间',
  cost_time         bigint(20)      default 0                  comment '消耗时间',
  primary key (oper_id),
  key idx_sys_oper_log_bt (business_type),
  key idx_sys_oper_log_s  (status),
  key idx_sys_oper_log_ot (oper_time)
) engine=innodb auto_increment=100 comment = '操作日志记录';


-- ----------------------------
-- 11、字典类型表
-- ----------------------------
drop table if exists sys_dict_type;
create table sys_dict_type
(
  dict_id          bigint(20)      not null auto_increment    comment '字典主键',
  dict_name        varchar(100)    default ''                 comment '字典名称',
  dict_type        varchar(100)    default ''                 comment '字典类型',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (dict_id),
  unique (dict_type)
) engine=innodb auto_increment=100 comment = '字典类型表';

insert into sys_dict_type values(1,  '用户性别', 'sys_user_sex',        '0', 'admin', sysdate(), '', null, '用户性别列表');
insert into sys_dict_type values(2,  '菜单状态', 'sys_show_hide',       '0', 'admin', sysdate(), '', null, '菜单状态列表');
insert into sys_dict_type values(3,  '系统开关', 'sys_normal_disable',  '0', 'admin', sysdate(), '', null, '系统开关列表');
insert into sys_dict_type values(4,  '任务状态', 'sys_job_status',      '0', 'admin', sysdate(), '', null, '任务状态列表');
insert into sys_dict_type values(5,  '任务分组', 'sys_job_group',       '0', 'admin', sysdate(), '', null, '任务分组列表');
insert into sys_dict_type values(6,  '系统是否', 'sys_yes_no',          '0', 'admin', sysdate(), '', null, '系统是否列表');
insert into sys_dict_type values(7,  '通知类型', 'sys_notice_type',     '0', 'admin', sysdate(), '', null, '通知类型列表');
insert into sys_dict_type values(8,  '通知状态', 'sys_notice_status',   '0', 'admin', sysdate(), '', null, '通知状态列表');
insert into sys_dict_type values(9,  '操作类型', 'sys_oper_type',       '0', 'admin', sysdate(), '', null, '操作类型列表');
insert into sys_dict_type values(10, '系统状态', 'sys_common_status',   '0', 'admin', sysdate(), '', null, '登录状态列表');
INSERT INTO sys_dict_type VALUES (11, '调用结果', 'sys_remote_signal_call_result', '0', 'admin', sysdate(), '', null, '调用结果');
INSERT INTO sys_dict_type VALUES (12, '设备类型', 'sys_device_type', '0', 'admin', sysdate(), '', null, '设备类型');
INSERT INTO sys_dict_type VALUES (13, '系统电压等级', 'sys_voltage_level', '0', 'admin', sysdate(), '', null, '电压等级');
INSERT INTO sys_dict_type VALUES (14, '标注任务状态', 'sys_label_task', '0', 'admin', sysdate(), '', null, '标注任务状态');
INSERT INTO sys_dict_type VALUES (15, '告警状态', 'sys_alarm_status', '0', 'admin', sysdate(), '', null, '标注任务状态');
INSERT INTO sys_dict_type VALUES (16, '告警等级', 'sys_alarm_level', '0', 'admin', sysdate(), '', null, '标注任务状态');
INSERT INTO sys_dict_type VALUES (17, '是否上送监控', 'send_to_monitor', '0', 'admin', sysdate(), '', null, '标注任务状态');


-- ----------------------------
-- 12、字典数据表
-- ----------------------------
drop table if exists sys_dict_data;
create table sys_dict_data
(
  dict_code        bigint(20)      not null auto_increment    comment '字典编码',
  dict_sort        int(4)          default 0                  comment '字典排序',
  dict_label       varchar(100)    default ''                 comment '字典标签',
  dict_value       varchar(100)    default ''                 comment '字典键值',
  dict_type        varchar(100)    default ''                 comment '字典类型',
  css_class        varchar(100)    default null               comment '样式属性（其他样式扩展）',
  list_class       varchar(100)    default null               comment '表格回显样式',
  is_default       char(1)         default 'N'                comment '是否默认（Y是 N否）',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (dict_code)
) engine=innodb auto_increment=100 comment = '字典数据表';

insert into sys_dict_data values(1,  1,  '男',       '0',       'sys_user_sex',        '',   '',        'Y', '0', 'admin', sysdate(), '', null, '性别男');
insert into sys_dict_data values(2,  2,  '女',       '1',       'sys_user_sex',        '',   '',        'N', '0', 'admin', sysdate(), '', null, '性别女');
insert into sys_dict_data values(3,  3,  '未知',     '2',       'sys_user_sex',        '',   '',        'N', '0', 'admin', sysdate(), '', null, '性别未知');
insert into sys_dict_data values(4,  1,  '显示',     '0',       'sys_show_hide',       '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '显示菜单');
insert into sys_dict_data values(5,  2,  '隐藏',     '1',       'sys_show_hide',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '隐藏菜单');
insert into sys_dict_data values(6,  1,  '正常',     '0',       'sys_normal_disable',  '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(7,  2,  '停用',     '1',       'sys_normal_disable',  '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values(8,  1,  '正常',     '0',       'sys_job_status',      '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(9,  2,  '暂停',     '1',       'sys_job_status',      '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values(10, 1,  '默认',     'DEFAULT', 'sys_job_group',       '',   '',        'Y', '0', 'admin', sysdate(), '', null, '默认分组');
insert into sys_dict_data values(11, 2,  '系统',     'SYSTEM',  'sys_job_group',       '',   '',        'N', '0', 'admin', sysdate(), '', null, '系统分组');
insert into sys_dict_data values(12, 1,  '是',       'Y',       'sys_yes_no',          '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '系统默认是');
insert into sys_dict_data values(13, 2,  '否',       'N',       'sys_yes_no',          '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '系统默认否');
insert into sys_dict_data values(14, 1,  '通知',     '1',       'sys_notice_type',     '',   'warning', 'Y', '0', 'admin', sysdate(), '', null, '通知');
insert into sys_dict_data values(15, 2,  '公告',     '2',       'sys_notice_type',     '',   'success', 'N', '0', 'admin', sysdate(), '', null, '公告');
insert into sys_dict_data values(16, 1,  '正常',     '0',       'sys_notice_status',   '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(17, 2,  '关闭',     '1',       'sys_notice_status',   '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '关闭状态');
insert into sys_dict_data values(18, 99, '其他',     '0',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', sysdate(), '', null, '其他操作');
insert into sys_dict_data values(19, 1,  '新增',     '1',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', sysdate(), '', null, '新增操作');
insert into sys_dict_data values(20, 2,  '修改',     '2',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', sysdate(), '', null, '修改操作');
insert into sys_dict_data values(21, 3,  '删除',     '3',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '删除操作');
insert into sys_dict_data values(22, 4,  '授权',     '4',       'sys_oper_type',       '',   'primary', 'N', '0', 'admin', sysdate(), '', null, '授权操作');
insert into sys_dict_data values(23, 5,  '导出',     '5',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', sysdate(), '', null, '导出操作');
insert into sys_dict_data values(24, 6,  '导入',     '6',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', sysdate(), '', null, '导入操作');
insert into sys_dict_data values(25, 7,  '强退',     '7',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '强退操作');
insert into sys_dict_data values(26, 8,  '生成代码', '8',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', sysdate(), '', null, '生成操作');
insert into sys_dict_data values(27, 9,  '清空数据', '9',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '清空操作');
insert into sys_dict_data values(28, 1,  '成功',     '0',       'sys_common_status',   '',   'primary', 'N', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(29, 2,  '失败',     '1',       'sys_common_status',   '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '停用状态');
INSERT INTO sys_dict_data VALUES (30, 1, '成功', '0', 'sys_remote_signal_call_result', null, 'success', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (31, 0, '失败', '1', 'sys_remote_signal_call_result', null, 'warning', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (32, 1, '自动装置', '1', 'sys_device_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (33, 2, '公用设备', '2', 'sys_device_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (34, 3, '一次设备', '3', 'sys_device_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (35, 4, '二次设备', '4', 'sys_device_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (36, 5, '站用交直流', '5', 'sys_device_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (37, 6, '辅控装置', '6', 'sys_device_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (38, 1, '220kV', '1', 'sys_voltage_level', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (39, 2, '110kV', '2', 'sys_voltage_level', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (40, 3, '35kV', '3', 'sys_voltage_level', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (41, 3, '已发布 ', '0', 'sys_label_task', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (42, 3, '进行中', '1', 'sys_label_task', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (43, 3, '已完成', '2', 'sys_label_task', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (44, 3, '已回收', '3', 'sys_label_task', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (45, 3, '否', '0', 'send_to_monitor', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (46, 3, '是', '1', 'send_to_monitor', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);

-- 设备类型字典类型
INSERT INTO sys_dict_type VALUES (18, '设备类型', 'sys_device_type_a', '0', 'admin', sysdate(), '', null, '设备类型');
-- 设备类型字典数据
INSERT INTO sys_dict_data VALUES (47, 18, '变压器', 'DT01', 'sys_device_type_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (48, 18, '断路器', 'DT02', 'sys_device_type_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (49, 18, '隔离开关', 'DT03', 'sys_device_type_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (50, 18, '母线', 'DT04', 'sys_device_type_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (51, 18, '输电线路', 'DT05', 'sys_device_type_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (52, 18, '电容器/电抗器', 'DT06', 'sys_device_type_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (53, 18, '保护装置', 'DT07', 'sys_device_type_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (54, 18, '测控装置', 'DT08', 'sys_device_type_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (55, 18, '合并单元', 'DT09', 'sys_device_type_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (56, 18, '电能表', 'DT10', 'sys_device_type_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);

-- 电压等级字典类型
INSERT INTO sys_dict_type VALUES (19, '电压等级', 'sys_voltage_level_a', '0', 'admin', sysdate(), '', null, '电压等级');
-- 电压等级字典数据
INSERT INTO sys_dict_data VALUES (57, 19, '1000kV', 'VL01', 'sys_voltage_level_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (58, 19, '±800kV', 'VL02', 'sys_voltage_level_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (59, 19, '750kV', 'VL03', 'sys_voltage_level_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (60, 19, '500kV', 'VL04', 'sys_voltage_level_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (61, 19, '220kV', 'VL05', 'sys_voltage_level_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (62, 19, '110kV', 'VL06', 'sys_voltage_level_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (63, 19, '35kV', 'VL07', 'sys_voltage_level_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (64, 19, '10kV', 'VL08', 'sys_voltage_level_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (65, 19, '0.4kV', 'VL09', 'sys_voltage_level_a', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);

-- 事故/事件类型字典类型
INSERT INTO sys_dict_type VALUES (20, '事故/事件类型', 'sys_event_type', '0', 'admin', sysdate(), '', null, '事故/事件类型');
-- 事故/事件类型字典数据
INSERT INTO sys_dict_data VALUES (66, 20, '短路故障', 'ET01', 'sys_event_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (67, 20, '保护动作', 'ET02', 'sys_event_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (68, 20, '开关变位', 'ET03', 'sys_event_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (69, 20, '越限告警', 'ET04', 'sys_event_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (70, 20, '通信中断', 'ET05', 'sys_event_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (71, 20, '设备异常', 'ET06', 'sys_event_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (72, 20, '频率异常', 'ET07', 'sys_event_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (73, 20, '拓扑变化', 'ET08', 'sys_event_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);

-- 设备状态字典类型
INSERT INTO sys_dict_type VALUES (21, '设备状态', 'sys_device_status', '0', 'admin', sysdate(), '', null, '设备状态');
-- 设备状态字典数据
INSERT INTO sys_dict_data VALUES (74, 21, '运行', 'DS01', 'sys_device_status', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (75, 21, '停运', 'DS02', 'sys_device_status', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (76, 21, '检修', 'DS03', 'sys_device_status', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (77, 21, '故障', 'DS04', 'sys_device_status', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (78, 21, '试验', 'DS05', 'sys_device_status', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);

-- 遥测数据类型字典类型
INSERT INTO sys_dict_type VALUES (22, '遥测数据类型', 'sys_telemetry_type', '0', 'admin', sysdate(), '', null, '遥测数据类型');
-- 遥测数据类型字典数据
INSERT INTO sys_dict_data VALUES (79, 22, '电流', 'TM01', 'sys_telemetry_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (80, 22, '电压', 'TM02', 'sys_telemetry_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (81, 22, '有功功率', 'TM03', 'sys_telemetry_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (82, 22, '无功功率', 'TM04', 'sys_telemetry_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (83, 22, '频率', 'TM05', 'sys_telemetry_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (84, 22, '温度', 'TM06', 'sys_telemetry_type', null, 'default', 'N', '0', 'admin', sysdate(), '', null, null);

-- ----------------------------
-- 13、参数配置表
-- ----------------------------
drop table if exists sys_config;
create table sys_config (
  config_id         int(5)          not null auto_increment    comment '参数主键',
  config_name       varchar(100)    default ''                 comment '参数名称',
  config_key        varchar(100)    default ''                 comment '参数键名',
  config_value      varchar(500)    default ''                 comment '参数键值',
  config_type       char(1)         default 'N'                comment '系统内置（Y是 N否）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (config_id)
) engine=innodb auto_increment=100 comment = '参数配置表';

insert into sys_config values(1, '主框架页-默认皮肤样式名称',     'sys.index.skinName',               'skin-blue',     'Y', 'admin', sysdate(), '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow' );
insert into sys_config values(2, '用户管理-账号初始密码',         'sys.user.initPassword',            '123456',        'Y', 'admin', sysdate(), '', null, '初始化密码 123456' );
insert into sys_config values(3, '主框架页-侧边栏主题',           'sys.index.sideTheme',              'theme-dark',    'Y', 'admin', sysdate(), '', null, '深色主题theme-dark，浅色主题theme-light' );
insert into sys_config values(4, '账号自助-验证码开关',           'sys.account.captchaEnabled',       'false',          'Y', 'admin', sysdate(), '', null, '是否开启验证码功能（true开启，false关闭）');
insert into sys_config values(5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser',         'false',         'Y', 'admin', sysdate(), '', null, '是否开启注册用户功能（true开启，false关闭）');
insert into sys_config values(6, '用户登录-黑名单列表',           'sys.login.blackIPList',            '',              'Y', 'admin', sysdate(), '', null, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
insert into sys_config values(7, '用户管理-初始密码修改策略',     'sys.account.initPasswordModify',   '1',             'Y', 'admin', sysdate(), '', null, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
insert into sys_config values(8, '用户管理-账号密码更新周期',     'sys.account.passwordValidateDays', '0',             'Y', 'admin', sysdate(), '', null, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');


-- ----------------------------
-- 14、系统访问记录
-- ----------------------------
drop table if exists sys_logininfor;
create table sys_logininfor (
  info_id        bigint(20)     not null auto_increment   comment '访问ID',
  user_name      varchar(50)    default ''                comment '用户账号',
  ipaddr         varchar(128)   default ''                comment '登录IP地址',
  login_location varchar(255)   default ''                comment '登录地点',
  browser        varchar(50)    default ''                comment '浏览器类型',
  os             varchar(50)    default ''                comment '操作系统',
  status         char(1)        default '0'               comment '登录状态（0成功 1失败）',
  msg            varchar(255)   default ''                comment '提示消息',
  login_time     datetime                                 comment '访问时间',
  primary key (info_id),
  key idx_sys_logininfor_s  (status),
  key idx_sys_logininfor_lt (login_time)
) engine=innodb auto_increment=100 comment = '系统访问记录';


-- ----------------------------
-- 15、定时任务调度表
-- ----------------------------
drop table if exists sys_job;
create table sys_job (
  job_id              bigint(20)    not null auto_increment    comment '任务ID',
  job_name            varchar(64)   default ''                 comment '任务名称',
  job_group           varchar(64)   default 'DEFAULT'          comment '任务组名',
  invoke_target       varchar(500)  not null                   comment '调用目标字符串',
  cron_expression     varchar(255)  default ''                 comment 'cron执行表达式',
  misfire_policy      varchar(20)   default '3'                comment '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  concurrent          char(1)       default '1'                comment '是否并发执行（0允许 1禁止）',
  status              char(1)       default '0'                comment '状态（0正常 1暂停）',
  create_by           varchar(64)   default ''                 comment '创建者',
  create_time         datetime                                 comment '创建时间',
  update_by           varchar(64)   default ''                 comment '更新者',
  update_time         datetime                                 comment '更新时间',
  remark              varchar(500)  default ''                 comment '备注信息',
  primary key (job_id, job_name, job_group)
) engine=innodb auto_increment=100 comment = '定时任务调度表';

insert into sys_job values(1, '系统默认（无参）', 'DEFAULT', 'Task.noParams',        '0/10 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');
insert into sys_job values(2, '系统默认（有参）', 'DEFAULT', 'Task.params(\'有参😊\')',  '0/15 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');
insert into sys_job values(3, '系统默认（多参）', 'DEFAULT', 'Task.multipleParams(\'多参😎\', true, 2000L, 316.50D, 100)',  '0/20 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');
INSERT INTO sys_job VALUES (4, '定时更新调用记录数据', 'DEFAULT', 'Task.updateCallRecord()', '0 0 1 * * ?', '1', '1', '0', 'admin', sysdate(), '', null, '');
INSERT INTO sys_job VALUES (5, '定时更新操作日志', 'DEFAULT', 'Task.updateOperLogDates()', '0 0 1 * * ?', '1', '1', '0', 'admin', sysdate(), '', null, '');
INSERT INTO sys_job VALUES (6, '定时更新登录日志', 'DEFAULT', 'Task.updateLoginLogDates()', '0 0 1 * * ?', '1', '1', '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 16、定时任务调度日志表
-- ----------------------------
drop table if exists sys_job_log;
create table sys_job_log (
  job_log_id          bigint(20)     not null auto_increment    comment '任务日志ID',
  job_name            varchar(64)    not null                   comment '任务名称',
  job_group           varchar(64)    not null                   comment '任务组名',
  invoke_target       varchar(500)   not null                   comment '调用目标字符串',
  job_message         varchar(500)                              comment '日志信息',
  status              char(1)        default '0'                comment '执行状态（0正常 1失败）',
  exception_info      varchar(2000)  default ''                 comment '异常信息',
  create_time         datetime                                  comment '创建时间',
  primary key (job_log_id)
) engine=innodb comment = '定时任务调度日志表';


-- ----------------------------
-- 17、通知公告表
-- ----------------------------
drop table if exists sys_notice;
create table sys_notice (
  notice_id         int(4)          not null auto_increment    comment '公告ID',
  notice_title      varchar(50)     not null                   comment '公告标题',
  notice_type       char(1)         not null                   comment '公告类型（1通知 2公告）',
  notice_content    longblob        default null               comment '公告内容',
  status            char(1)         default '0'                comment '公告状态（0正常 1关闭）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(255)    default null               comment '备注',
  primary key (notice_id)
) engine=innodb auto_increment=10 comment = '通知公告表';

-- ----------------------------
-- 初始化-公告信息表数据
-- ----------------------------
insert into sys_notice values('1', '温馨提醒：2018-07-01 新版本发布啦', '2', '新版本内容', '0', 'admin', sysdate(), '', null, '管理员');
insert into sys_notice values('2', '维护通知：2018-07-01 系统凌晨维护', '1', '维护内容',   '0', 'admin', sysdate(), '', null, '管理员');


-- ----------------------------
-- 18、代码生成业务表
-- ----------------------------
drop table if exists gen_table;
create table gen_table (
  table_id          bigint(20)      not null auto_increment    comment '编号',
  table_name        varchar(200)    default ''                 comment '表名称',
  table_comment     varchar(500)    default ''                 comment '表描述',
  sub_table_name    varchar(64)     default null               comment '关联子表的表名',
  sub_table_fk_name varchar(64)     default null               comment '子表关联的外键名',
  class_name        varchar(100)    default ''                 comment '实体类名称',
  tpl_category      varchar(200)    default 'crud'             comment '使用的模板（crud单表操作 tree树表操作）',
  tpl_web_type      varchar(30)     default ''                 comment '前端模板类型（element-ui模版 element-plus模版）',
  package_name      varchar(100)                               comment '生成包路径',
  module_name       varchar(30)                                comment '生成模块名',
  business_name     varchar(30)                                comment '生成业务名',
  function_name     varchar(50)                                comment '生成功能名',
  function_author   varchar(50)                                comment '生成功能作者',
  gen_type          char(1)         default '0'                comment '生成代码方式（0zip压缩包 1自定义路径）',
  gen_path          varchar(200)    default '/'                comment '生成路径（不填默认项目路径）',
  options           varchar(1000)                              comment '其它生成选项',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time 	    datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (table_id)
) engine=innodb auto_increment=1 comment = '代码生成业务表';


-- ----------------------------
-- 19、代码生成业务表字段
-- ----------------------------
drop table if exists gen_table_column;
create table gen_table_column (
  column_id         bigint(20)      not null auto_increment    comment '编号',
  table_id          bigint(20)                                 comment '归属表编号',
  column_name       varchar(200)                               comment '列名称',
  column_comment    varchar(500)                               comment '列描述',
  column_type       varchar(100)                               comment '列类型',
  java_type         varchar(500)                               comment 'JAVA类型',
  java_field        varchar(200)                               comment 'JAVA字段名',
  is_pk             char(1)                                    comment '是否主键（1是）',
  is_increment      char(1)                                    comment '是否自增（1是）',
  is_required       char(1)                                    comment '是否必填（1是）',
  is_insert         char(1)                                    comment '是否为插入字段（1是）',
  is_edit           char(1)                                    comment '是否编辑字段（1是）',
  is_list           char(1)                                    comment '是否列表字段（1是）',
  is_query          char(1)                                    comment '是否查询字段（1是）',
  query_type        varchar(200)    default 'EQ'               comment '查询方式（等于、不等于、大于、小于、范围）',
  html_type         varchar(200)                               comment '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  dict_type         varchar(200)    default ''                 comment '字典类型',
  sort              int                                        comment '排序',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time 	    datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  primary key (column_id)
) engine=innodb auto_increment=1 comment = '代码生成业务表字段';


-- 更新创建时间为最近两个月内的随机时间
UPDATE sys_user
SET create_time = DATE_SUB(
        NOW(),
        INTERVAL FLOOR(RAND() * 60*24*60 + RAND() * 24*60 + RAND() * 60) MINUTE
                  );

-- 更新更新时间为不早于创建时间且在最近两个月内的随机时间
UPDATE sys_user
SET update_time = FROM_UNIXTIME(
        UNIX_TIMESTAMP(create_time) +
        FLOOR(RAND() * (UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(create_time)))
                  )
WHERE update_time IS NULL OR update_time < create_time OR update_time > NOW();
