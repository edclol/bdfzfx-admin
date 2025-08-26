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

DROP TABLE IF EXISTS sys_label_detail;
CREATE TABLE sys_label_detail
(
    id                 BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    task_id            BIGINT(20) NOT NULL COMMENT '所属任务ID，关联sys_label_task.task_id',
    substation_id      VARCHAR(100) DEFAULT NULL COMMENT '变电站ID，如：四川草坝',
    remote_signal_id   VARCHAR(100) DEFAULT NULL COMMENT '遥信ID，如：断路器表四川草坝四川/草坝/10kV 901开关遥信值',
    monitor_id         VARCHAR(100) DEFAULT NULL COMMENT '监控ID，如：XXXXXXXXXX',
    signal_type        VARCHAR(50)  DEFAULT NULL COMMENT '遥信类型：遥测/遥信/遥控/遥调',
    entry_time         DATETIME     DEFAULT NULL COMMENT '入库时间，如：2024-12-12 10:00:00',
    monitor_content    TEXT         DEFAULT NULL COMMENT '监控信息内容，描述性文本',
    -- 标注信息部分
    device_type        VARCHAR(50)  DEFAULT NULL COMMENT '设备类型，如：主变保护',
    device_principle   VARCHAR(100) DEFAULT NULL COMMENT '设备原理，如：通用',
    info_name          TEXT         DEFAULT NULL COMMENT '信息名称，格式为：[主变编号] [设备编号] 保护 [型号] 远方操作硬压板',
    voltage_level      VARCHAR(50)  DEFAULT NULL COMMENT '适用电压等级(kW)，如：500',
    alarm_status       VARCHAR(20)  DEFAULT NULL COMMENT '告警/状态，如：告警',
    alarm_level        VARCHAR(10)  DEFAULT NULL COMMENT '告警等级，如：1级',
    is_positive_sample CHAR(1)      DEFAULT '1' COMMENT '是否正样例：1=正样例，0=负样例',
    label_user         VARCHAR(64)  DEFAULT NULL COMMENT '标注人姓名',
    label_time         DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '标注时间',
    is_labeled         CHAR(1)      DEFAULT '0' COMMENT '是否已标注：1=已标注，0=未标注',
    remark             VARCHAR(500) DEFAULT NULL COMMENT '备注信息',

    PRIMARY KEY (id),
    KEY idx_task_id (task_id),
    KEY idx_monitor_id (monitor_id),
    KEY idx_label_time (label_time),
    KEY idx_info_name (info_name(255))
) ENGINE = InnoDB COMMENT = '样本标注详情表';

-- ----------------------------
-- 知识图谱JSON存储表
-- ----------------------------
DROP TABLE IF EXISTS kg_graph_json;
CREATE TABLE kg_graph_json
(
    id          BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    graph_data  TEXT       NOT NULL COMMENT '知识图谱JSON数据',
    create_by   VARCHAR(64)  DEFAULT '' COMMENT '创建者',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by   VARCHAR(64)  DEFAULT '' COMMENT '更新者',
    update_time DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark      VARCHAR(500) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id),
    KEY idx_create_time (create_time)
) ENGINE = InnoDB COMMENT ='知识图谱JSON存储表';

insert into kg_graph_json values(1, '{"nodes": [{"id": "1", "label": "节点1"}, {"id": "2", "label": "节点2"}], "edges": [{"source": "1", "target": "2"}]}', 'admin', sysdate(), '', null, '');

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


-- 模型训练记录表
DROP TABLE IF EXISTS sys_model_train_record;
CREATE TABLE sys_model_train_record
(
    id                BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    train_date        DATE        NOT NULL COMMENT '训练日期',
    workflow_version  VARCHAR(50) NOT NULL COMMENT '工作流版本号',
    result            VARCHAR(10) NOT NULL COMMENT '训练结果（成功/失败）',
    gpu_count         INT(11)      DEFAULT 0 COMMENT 'GPU数量',
    init_model_params TEXT         DEFAULT NULL COMMENT '初始化模型参数（如：XXXX, YYYY, ZZZZ）',
    execution_process TEXT         DEFAULT NULL COMMENT '执行训练过程（如：AAAAA, BBBBB, CCCCC）',
    loss_curve_data   TEXT         DEFAULT NULL COMMENT '损失函数的变化数据（TEXT格式，包含多个系列）',
    create_by         VARCHAR(64)  DEFAULT '' COMMENT '创建人',
    create_time       DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by         VARCHAR(64)  DEFAULT '' COMMENT '更新人',
    update_time       DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark            VARCHAR(500) DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (id),
    KEY idx_train_date (train_date),
    KEY idx_workflow_version (workflow_version),
    KEY idx_result (result),
    KEY idx_create_time (create_time)
) ENGINE = InnoDB  COMMENT = '模型训练记录表';

INSERT INTO sys_model_train_record (train_date, workflow_version, result, gpu_count,
                                    init_model_params, execution_process, loss_curve_data,
                                    create_by, remark)
VALUES ('2024-08-01', '6M0jYz', '成功', 4,
        'XXXX, YYYY, ZZZZ', 'AAAAA, BBBBB, CCCCC',
        '[{"name":"系列2","data":[2,4,2,3]},{"name":"系列3","data":[2,2,4,5]}]',
        'admin', '首次训练');

INSERT INTO sys_model_train_record (train_date, workflow_version, result, gpu_count,
                                    init_model_params, execution_process, loss_curve_data,
                                    create_by, remark)
VALUES ('2024-08-01', '6M0jYz', '失败', 4,
        'XXXX, YYYY, ZZZZ', 'AAAAA, BBBBB, CCCCC',
        '[{"name":"系列2","data":[2,4,2,3]},{"name":"系列3","data":[2,2,4,5]}]',
        'admin', '训练中断');



-- 模型信息表
DROP TABLE IF EXISTS sys_model_info;
CREATE TABLE sys_model_info
(
    id             BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    model_name     VARCHAR(100) NOT NULL COMMENT '模型名称（如：故障诊断模型）',
    version_number VARCHAR(50)  NOT NULL COMMENT '版本号（如：V20.24.22）',
    upload_time    DATETIME     NOT NULL COMMENT '上传时间',
    call_count     INT(11)       DEFAULT 0 COMMENT '调用次数',
    precision_rate DECIMAL(5, 2) DEFAULT NULL COMMENT '精准率（百分比，如：85.00）',
    recall_rate    DECIMAL(5, 2) DEFAULT NULL COMMENT '召回率（百分比，如：80.00）',
    model_size     VARCHAR(50)   DEFAULT NULL COMMENT '模型大小',
    model_path     VARCHAR(50)   DEFAULT NULL COMMENT '部署路径',
    f1_score       DECIMAL(5, 2) DEFAULT NULL COMMENT 'F1分数（可选）',
    description    TEXT          DEFAULT NULL COMMENT '模型描述或用途说明',
    is_used        VARCHAR(1)    DEFAULT '0' COMMENT '是否启用（0：未启用，1：已启用）',
    create_by      VARCHAR(64)   DEFAULT '' COMMENT '创建人',
    create_time    DATETIME      DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by      VARCHAR(64)   DEFAULT '' COMMENT '更新人',
    update_time    DATETIME      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark         VARCHAR(500)  DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (id),
    UNIQUE KEY uk_version_number (version_number),
    KEY idx_upload_time (upload_time),
    KEY idx_call_count (call_count),
    KEY idx_create_time (create_time)
) ENGINE = InnoDB COMMENT = '模型信息表';


INSERT INTO sys_model_info (model_name, version_number, upload_time, call_count,
                            precision_rate, recall_rate, model_size, model_path, description, is_used,
                            create_by, remark)
VALUES ('故障诊断模型', 'V20.24.22', '2024-08-05 12:44:15', 3351,
        85.00, 80.00, '120G', '/models/fault_diagnosis_v20.24.22.h5',
        '用于电力设备故障识别的深度学习模型，基于CNN+LSTM架构。', '1',
        'admin', '首次发布');





