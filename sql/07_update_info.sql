USE app;
SET NAMES utf8mb4;
SET character_set_database = utf8mb4;
SET collation_database = utf8mb4_0900_ai_ci;


-- 处理所有带.0后缀的数值字符串
UPDATE sys_yx_info_all
SET yx_type = CAST(CAST(yx_type AS DECIMAL) AS CHAR)
WHERE yx_type REGEXP '^[0-9]+\\.0$';

# DELETE FROM sys_yx_info_all WHERE yx_type not in ('1', '2', '3', '4', '5', '6');

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
    status          char(1)      default '0' not null comment '任务状态（0待标注 1进行中 2已完成 3已回收 4已发布）',
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
insert into sys_label_task values(1, '样本标注任务1', 200, 0, 'yunjian_5', '0', 'admin', sysdate(), '', null, '');
insert into sys_label_task values(2, '样本标注任务2', 100, 50, 'yunjian_1', '1', 'admin', sysdate(), '', null, '');
insert into sys_label_task values(3, '样本标注任务3', 200, 200, 'yunjian_2', '2', 'admin', sysdate(), '', null, '');
insert into sys_label_task values(4, '样本标注任务4', 100, 0, 'yunjian_1', '0', 'admin', sysdate(), '', null, '');
insert into sys_label_task values(5, '样本标注任务5', 200, 0, 'yunjian_4', '0', 'admin', sysdate(), '', null, '');
insert into sys_label_task values(6, '样本标注任务6', 100, 0, 'yunjian_3', '0', 'admin', sysdate(), '', null, '');

DROP TABLE IF EXISTS sys_label_detail;
CREATE TABLE sys_label_detail
(
    id                 BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    task_id            BIGINT(20) NOT NULL COMMENT '所属任务ID，关联sys_label_task.task_id',
    substation_id      VARCHAR(100) DEFAULT NULL COMMENT '变电站ID，如：四川草坝',
    remote_signal_id   VARCHAR(100) DEFAULT NULL COMMENT '遥信ID，如：断路器表四川草坝四川/草坝/10kV 901开关遥信值',
    monitor_id         VARCHAR(100) DEFAULT NULL COMMENT '监控ID，如：XXXXXXXXXX',
    signal_type        VARCHAR(50)  DEFAULT NULL COMMENT '遥信类型：遥测/遥信/遥控/遥调',
    entry_time         DATETIME     DEFAULT NULL COMMENT '入库时间，如：2025-12-12 10:00:00',
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
    is_labeled         CHAR(1)      DEFAULT '0' COMMENT '是否已标注：2=异常样本，1=已标注，0=未标注',
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

INSERT INTO kg_graph_json (id,graph_data,create_by,create_time,update_by,update_time,remark) VALUES (1,'[{"设备":[{"index":"1","name":"变压器","value":"电力系统电压变换的核心设备。"},{"index":"2","name":"断路器","value":"通断电路并隔离故障的保护装置。"},{"index":"3","name":"保护装置","value":"自动检测故障并触发保护动作的设备。"},{"index":"4","name":"监控终端","value":"实时采集设备运行数据的智能终端。"},{"index":"5","name":"母线","value":"汇集和分配电能的导体节点。"},{"index":"6","name":"输电线路","value":"输送电能的架空线或电缆通道。"},{"index":"7","name":"智能电表","value":"记录用户用电量并支持远程抄表的终端。"},{"index":"8","name":"传感器","value":"监测温度、电流等物理量的感知设备。"}]},{"数据与状态":[{"index":"1","name":"遥测数据","value":"远程采集的电压、电流等实时量测值。"},{"index":"2","name":"遥信数据","value":"设备开关状态或告警信号的远程上报。"},{"index":"3","name":"过载告警","value":"设备负荷超过安全阈值的预警信号。"},{"index":"4","name":"跳闸事件","value":"保护装置触发断路器断开电路的记录。"},{"index":"5","name":"运行状态","value":"设备正常供电的工作模式。"},{"index":"6","name":"检修状态","value":"设备停机维护的标记状态。"},{"index":"7","name":"电压越限","value":"电压超出允许范围的异常数据。"},{"index":"8","name":"谐波畸变","value":"电流/电压波形失真的质量问题。"}]},{"故障事件":[{"index":"1","name":"短路故障","value":"相间或对地异常低阻接通的故障。"},{"index":"2","name":"接地故障","value":"线路或设备对地绝缘失效的事件。"},{"index":"3","name":"停电事件","value":"供电中断的系统记录。"},{"index":"4","name":"孤岛运行","value":"局部电网脱离主网独立运行的状态。"},{"index":"5","name":"重合闸动作","value":"断路器跳闸后自动尝试合闸的操作。"}]},{"分析与控制":[{"index":"1","name":"SCADA系统","value":"电网数据采集与监控的核心平台。"},{"index":"2","name":"故障定位","value":"快速确定线路故障点位置的技术。"},{"index":"3","name":"负荷预测","value":"基于历史数据预估未来用电需求。"},{"index":"4","name":"拓扑分析","value":"动态计算电网连接关系的算法。"},{"index":"5","name":"自动电压控制","value":"优化电网电压稳定的闭环调节。"}]},{"运维策略":[{"index":"1","name":"调度指令","value":"调度中心下发的操作命令。"},{"index":"2","name":"巡检计划","value":"定期检查设备状态的维护方案。"},{"index":"3","name":"N-1准则","value":"单一设备故障不影响供电的安全标准。"},{"index":"4","name":"黑启动","value":"大停电后系统自恢复的预案。"}]},{"标准与装置":[{"index":"1","name":"IEC 61850","value":"电力自动化通信国际标准。"},{"index":"2","name":"RTU","value":"远程终端单元，数据上传与指令执行设备。"},{"index":"3","name":"PMU","value":"同步相量测量单元，高精度动态监测装置。"}]},{"保护与机制":[{"index":"1","name":"继电保护","value":"故障时快速隔离设备的防御体系。"},{"index":"2","name":"备自投","value":"备用电源自动投入的切换逻辑。"},{"index":"3","name":"防误操作","value":"强制约束错误操作的联锁机制。"}]},{"运行指标":[{"index":"1","name":"供电可靠性","value":"用户年均停电时间的评价指标。"},{"index":"2","name":"线损率","value":"输电过程中电能损耗的百分比。"},{"index":"3","name":"频率偏差","value":"电网实际频率与标准值的差值。"},{"index":"4","name":"功率因数","value":"有功功率与视在功率的比值。"}]}]','admin','2025-08-26 15:04:41','','2025-08-27 22:55:35','');

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
('过流Ⅰ段', '过流 I 段', '系统管理员', '2025-12-12 10:00:00'),
('过流1段', '过流 I 段', '系统管理员', '2025-12-12 10:00:00'),
('过流一段', '过流 I 段', '系统管理员', '2025-12-12 10:00:00'),

('零序过流Ⅰ段', '零序过流 I 段', '系统管理员', '2025-12-12 10:00:00'),
('零序过流1段', '零序过流 I 段', '系统管理员', '2025-12-12 10:00:00'),
('零序过流一段', '零序过流 I 段', '系统管理员', '2025-12-12 10:00:00'),

('距离Ⅰ段', '距离 I 段', '系统管理员', '2025-12-12 10:00:00'),
('距离1段', '距离 I 段', '系统管理员', '2025-12-12 10:00:00'),
('距离一段', '距离 I 段', '系统管理员', '2025-12-12 10:00:00'),

-- 告警/保护类
('过负荷告警', '过载告警', '系统管理员', '2025-12-12 10:00:00'),
('过载告警', '过载告警', '系统管理员', '2025-12-12 10:00:00'),
('过载报警', '过载告警', '系统管理员', '2025-12-12 10:00:00'),

('低电压保护', '欠压保护', '系统管理员', '2025-12-12 10:00:00'),
('欠压保护', '欠压保护', '系统管理员', '2025-12-12 10:00:00'),
('低压保护', '欠压保护', '系统管理员', '2025-12-12 10:00:00'),

('过电压保护', '过压保护', '系统管理员', '2025-12-12 10:00:00'),
('过压保护', '过压保护', '系统管理员', '2025-12-12 10:00:00'),
('高压保护', '过压保护', '系统管理员', '2025-12-12 10:00:00'),

('差动速断', '差动Ⅰ段', '系统管理员', '2025-12-12 10:00:00'),
('差动Ⅰ段', '差动Ⅰ段', '系统管理员', '2025-12-12 10:00:00'),
('差动一段', '差动Ⅰ段', '系统管理员', '2025-12-12 10:00:00'),

('重合闸后加速', '后加速保护', '系统管理员', '2025-12-12 10:00:00'),
('后加速保护', '后加速保护', '系统管理员', '2025-12-12 10:00:00'),
('重合后加速', '后加速保护', '系统管理员', '2025-12-12 10:00:00'),

('PT断线告警', '电压互感器断线报警', '系统管理员', '2025-12-12 10:00:00'),
('电压互感器断线报警', '电压互感器断线报警', '系统管理员', '2025-12-12 10:00:00'),
('PT失压报警', '电压互感器断线报警', '系统管理员', '2025-12-12 10:00:00'),

('CT断线闭锁', '电流互感器断线闭锁', '系统管理员', '2025-12-12 10:00:00'),
('电流互感器断线闭锁', '电流互感器断线闭锁', '系统管理员', '2025-12-12 10:00:00'),
('CT失效闭锁', '电流互感器断线闭锁', '系统管理员', '2025-12-12 10:00:00'),

('低频减载', '低频保护', '系统管理员', '2025-12-12 10:00:00'),
('低频保护', '低频保护', '系统管理员', '2025-12-12 10:00:00'),
('低周减载', '低频保护', '系统管理员', '2025-12-12 10:00:00'),

('过频保护', '高周保护', '系统管理员', '2025-12-12 10:00:00'),
('高周保护', '高周保护', '系统管理员', '2025-12-12 10:00:00'),
('超频保护', '高周保护', '系统管理员', '2025-12-12 10:00:00'),

('非电量保护', '开入量保护', '系统管理员', '2025-12-12 10:00:00'),
('开入量保护', '开入量保护', '系统管理员', '2025-12-12 10:00:00'),
('辅助保护', '开入量保护', '系统管理员', '2025-12-12 10:00:00'),

('失灵启动', '断路器失灵启动', '系统管理员', '2025-12-12 10:00:00'),
('断路器失灵启动', '断路器失灵启动', '系统管理员', '2025-12-12 10:00:00'),
('失灵保护触发', '断路器失灵启动', '系统管理员', '2025-12-12 10:00:00'),

('小电流接地选线', '接地故障选线', '系统管理员', '2025-12-12 10:00:00'),
('接地故障选线', '接地故障选线', '系统管理员', '2025-12-12 10:00:00'),
('零序选线', '接地故障选线', '系统管理员', '2025-12-12 10:00:00'),

('过流Ⅱ段', '过流 II 段', '系统管理员', '2025-12-12 10:00:00'),
('过流2段', '过流 II 段', '系统管理员', '2025-12-12 10:00:00'),
('过流二段', '过流 II 段', '系统管理员', '2025-12-12 10:00:00'),

('零序过流Ⅱ段', '零序过流 II 段', '系统管理员', '2025-12-12 10:00:00'),
('零序过流2段', '零序过流 II 段', '系统管理员', '2025-12-12 10:00:00'),
('零序过流二段', '零序过流 II 段', '系统管理员', '2025-12-12 10:00:00'),

('距离Ⅱ段', '距离 II 段', '系统管理员', '2025-12-12 10:00:00'),
('距离2段', '距离 II 段', '系统管理员', '2025-12-12 10:00:00'),
('距离二段', '距离 II 段', '系统管理员', '2025-12-12 10:00:00'),

('过流Ⅲ段', '过流 III 段', '系统管理员', '2025-12-12 10:00:00'),
('过流3段', '过流 III 段', '系统管理员', '2025-12-12 10:00:00'),
('过流三段', '过流 III 段', '系统管理员', '2025-12-12 10:00:00'),

('零序过流Ⅲ段', '零序过流 III 段', '系统管理员', '2025-12-12 10:00:00'),
('零序过流3段', '零序过流 III 段', '系统管理员', '2025-12-12 10:00:00'),
('零序过流三段', '零序过流 III 段', '系统管理员', '2025-12-12 10:00:00'),

('距离Ⅲ段', '距离 III 段', '系统管理员', '2025-12-12 10:00:00'),
('距离3段', '距离 III 段', '系统管理员', '2025-12-12 10:00:00'),
('距离三段', '距离 III 段', '系统管理员', '2025-12-12 10:00:00'),

('反时限过流', '反时限保护', '系统管理员', '2025-12-12 10:00:00'),
('反时限保护', '反时限保护', '系统管理员', '2025-12-12 10:00:00'),
('I-t特性保护', '反时限保护', '系统管理员', '2025-12-12 10:00:00'),

('重合闸前加速', '前加速保护', '系统管理员', '2025-12-12 10:00:00'),
('前加速保护', '前加速保护', '系统管理员', '2025-12-12 10:00:00'),
('瞬时加速', '前加速保护', '系统管理员', '2025-12-12 10:00:00'),

('检同期重合', '同期检定重合', '系统管理员', '2025-12-12 10:00:00'),
('同期检定重合', '同期检定重合', '系统管理员', '2025-12-12 10:00:00'),
('同步检查重合', '同期检定重合', '系统管理员', '2025-12-12 10:00:00'),

('检无压重合', '无压检定重合', '系统管理员', '2025-12-12 10:00:00'),
('无压检定重合', '无压检定重合', '系统管理员', '2025-12-12 10:00:00'),
('电压闭锁重合', '无压检定重合', '系统管理员', '2025-12-12 10:00:00'),

('母线充电保护', '母充保护', '系统管理员', '2025-12-12 10:00:00'),
('母充保护', '母充保护', '系统管理员', '2025-12-12 10:00:00'),
('充电短时过流', '母充保护', '系统管理员', '2025-12-12 10:00:00'),

('冷负荷启动', '冷载启动', '系统管理员', '2025-12-12 10:00:00'),
('冷载启动', '冷载启动', '系统管理员', '2025-12-12 10:00:00'),
('负荷突投保护', '冷载启动', '系统管理员', '2025-12-12 10:00:00'),

('频率异常', '频偏保护', '系统管理员', '2025-12-12 10:00:00'),
('频偏保护', '频偏保护', '系统管理员', '2025-12-12 10:00:00'),
('系统频率越限', '频偏保护', '系统管理员', '2025-12-12 10:00:00'),

('电压越限告警', '电压超限报警', '系统管理员', '2025-12-12 10:00:00'),
('电压超限报警', '电压超限报警', '系统管理员', '2025-12-12 10:00:00'),
('越压报警', '电压超限报警', '系统管理员', '2025-12-12 10:00:00'),

('电流越限告警', '电流超限报警', '系统管理员', '2025-12-12 10:00:00'),
('电流超限报警', '电流超限报警', '系统管理员', '2025-12-12 10:00:00'),
('过流预警', '电流超限报警', '系统管理员', '2025-12-12 10:00:00'),

('功率振荡闭锁', '振荡闭锁', '系统管理员', '2025-12-12 10:00:00'),
('振荡闭锁', '振荡闭锁', '系统管理员', '2025-12-12 10:00:00'),
('失步闭锁', '振荡闭锁', '系统管理员', '2025-12-12 10:00:00'),

('TA断线告警', 'CT二次断线报警', '系统管理员', '2025-12-12 10:00:00'),
('CT二次断线报警', 'CT二次断线报警', '系统管理员', '2025-12-12 10:00:00'),
('电流回路异常', 'CT二次断线报警', '系统管理员', '2025-12-12 10:00:00'),

('TV断线告警', 'PT二次断线报警', '系统管理员', '2025-12-12 10:00:00'),
('PT二次断线报警', 'PT二次断线报警', '系统管理员', '2025-12-12 10:00:00'),
('电压回路异常', 'PT二次断线报警', '系统管理员', '2025-12-12 10:00:00'),

('控制回路断线', '控回断线', '系统管理员', '2025-12-12 10:00:00'),
('控回断线', '控回断线', '系统管理员', '2025-12-12 10:00:00'),
('操作电源消失', '控回断线', '系统管理员', '2025-12-12 10:00:00'),

('弹簧未储能', '储能超时', '系统管理员', '2025-12-12 10:00:00'),
('储能超时', '储能超时', '系统管理员', '2025-12-12 10:00:00');

-- 更新创建时间为最近两个月内的随机时间
UPDATE sys_synonym
SET create_time = DATE_SUB(
        NOW(),
        INTERVAL FLOOR(RAND() * 60*24*60 + RAND() * 24*60 + RAND() * 60) MINUTE
                  );

-- 更新更新时间为不早于创建时间且在最近两个月内的随机时间
UPDATE sys_synonym
SET update_time = FROM_UNIXTIME(
        UNIX_TIMESTAMP(create_time) +
        FLOOR(RAND() * (UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(create_time)))
                  )
WHERE update_time IS NULL OR update_time < create_time OR update_time > NOW();


DROP TABLE IF EXISTS sys_typical_monitor_info;
CREATE TABLE sys_typical_monitor_info
(
    id                     BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    device_type            VARCHAR(500)  DEFAULT NULL COMMENT '设备类型，如：开关保护、线路保护',
    device_principle       VARCHAR(500) DEFAULT NULL COMMENT '设备原理，如：带过压远跳功能',
    info_name              TEXT         DEFAULT NULL COMMENT '信息名称，格式为：[电压等级][间隔名称][设备编号][保护（型号）] 光纤通道一软压板',
    voltage_level          VARCHAR(500)  DEFAULT NULL COMMENT '通用电压等级，如：550/220kV',
    alarm_status           VARCHAR(20)  DEFAULT NULL COMMENT '告警状态，如：告警、动作、异常',
    alarm_level            varchar(10)  DEFAULT NULL COMMENT '告警等级，如：4级',
    send_to_monitor        varchar(10)  DEFAULT '0' COMMENT '是否上送监控（0否，1是）',
    reference_basis        VARCHAR(500)  DEFAULT NULL COMMENT '参考依据，如：新一代、2020企标',
    collection_requirement VARCHAR(500) DEFAULT NULL COMMENT '采集要求，如：实时采集、定时采集',
    target_device          VARCHAR(500) DEFAULT NULL COMMENT '指向设备，如：线路保护装置、开关',
    source_device          VARCHAR(500) DEFAULT NULL COMMENT '采集源设备，如：线路保护装置',
    integration_device     VARCHAR(500) DEFAULT NULL COMMENT '数据集成设备，如：线路保护装置',
    update_time            DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_by              VARCHAR(64)  DEFAULT '' COMMENT '创建者',
    create_time            DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by              VARCHAR(64)  DEFAULT '' COMMENT '更新者',
    remark                 VARCHAR(500) DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (id)
) ENGINE = InnoDB COMMENT = '典型监控信息管理表';


INSERT INTO sys_typical_monitor_info (
    device_type,
    device_principle,
    info_name,
    voltage_level,
    alarm_status,
    alarm_level,
    send_to_monitor,
    reference_basis,
    collection_requirement,
    target_device,
    source_device,
    integration_device,
    create_time,
    update_time
)
SELECT
    device_type,
    device_principle,
    info_name,
    v_level AS voltage_level,
    alarm_type AS alarm_status,
    alarm_level,
    '0' AS send_to_monitor,  -- 使用默认值0（否）
    reference AS reference_basis,
    requirement AS collection_requirement,
    target_device,
    origin_device AS source_device,
    data_primary_device AS integration_device,
    null AS create_time,
    null AS update_time
FROM sys_yx_info_all
ORDER BY RAND()
LIMIT 1000;

UPDATE sys_typical_monitor_info
SET create_time = DATE_SUB(
        NOW(),
        INTERVAL FLOOR(RAND() * 60*24*60 + RAND() * 24*60 + RAND() * 60) MINUTE
                  );

-- 更新更新时间为不早于创建时间且在最近两个月内的随机时间
UPDATE sys_typical_monitor_info
SET update_time = FROM_UNIXTIME(
        UNIX_TIMESTAMP(create_time) +
        FLOOR(RAND() * (UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(create_time)))
                  )
WHERE update_time IS NULL OR update_time < create_time OR update_time > NOW();

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

INSERT INTO sys_model_train_record (
    train_date, workflow_version, result, gpu_count,
    init_model_params, execution_process, loss_curve_data,
    create_by
) VALUES
-- 8月第一周数据
('2025-08-01', 'v1.0.0', '成功', 2, 'learning_rate=0.001, batch_size=32', '数据加载→预处理→训练→验证', '[{"epoch":1,"loss":0.85},{"epoch":10,"loss":0.32}]', 'admin'),
('2025-08-02', 'v1.0.0', '成功', 2, 'learning_rate=0.001, batch_size=32', '数据加载→预处理→训练→验证', '[{"epoch":1,"loss":0.82},{"epoch":10,"loss":0.30}]', 'admin'),
('2025-08-03', 'v1.0.1', '失败', 2, 'learning_rate=0.002, batch_size=32', '数据加载→预处理→训练中断', '[]', 'admin'),
('2025-08-04', 'v1.0.1', '成功', 4, 'learning_rate=0.002, batch_size=64', '数据加载→预处理→训练→验证', '[{"epoch":1,"loss":0.78},{"epoch":10,"loss":0.28}]', 'admin'),
('2025-08-05', 'v1.0.1', '成功', 4, 'learning_rate=0.002, batch_size=64', '数据加载→预处理→训练→验证', '[{"epoch":1,"loss":0.76},{"epoch":10,"loss":0.27}]', 'admin'),

-- 8月第二周数据
('2025-08-06', 'v1.0.2', '成功', 4, 'learning_rate=0.001, batch_size=64', '数据加载→预处理→训练→验证', '[{"epoch":1,"loss":0.75},{"epoch":10,"loss":0.26}]', 'model_user'),
('2025-08-07', 'v1.0.2', '成功', 4, 'learning_rate=0.001, batch_size=64', '数据加载→预处理→训练→验证', '[{"epoch":1,"loss":0.74},{"epoch":10,"loss":0.25}]', 'model_user'),
('2025-08-08', 'v1.0.2', '失败', 2, 'learning_rate=0.001, batch_size=128', '数据加载→内存溢出', '[]', 'model_user'),
('2025-08-09', 'v1.1.0', '成功', 8, 'learning_rate=0.0005, batch_size=128', '数据加载→预处理→训练→验证→测试', '[{"epoch":1,"loss":0.72},{"epoch":10,"loss":0.23}]', 'model_user'),
('2025-08-10', 'v1.1.0', '成功', 8, 'learning_rate=0.0005, batch_size=128', '数据加载→预处理→训练→验证→测试', '[{"epoch":1,"loss":0.71},{"epoch":10,"loss":0.22}]', 'admin'),

-- 8月第三周数据
('2025-08-11', 'v1.1.0', '成功', 8, 'learning_rate=0.0005, batch_size=128', '数据加载→预处理→训练→验证→测试', '[{"epoch":1,"loss":0.70},{"epoch":10,"loss":0.21}]', 'admin'),
('2025-08-12', 'v1.1.1', '成功', 8, 'learning_rate=0.0005, batch_size=256', '数据加载→预处理→训练→验证→测试', '[{"epoch":1,"loss":0.68},{"epoch":10,"loss":0.20}]', 'admin'),
('2025-08-13', 'v1.1.1', '失败', 8, 'learning_rate=0.0005, batch_size=256', '数据加载→预处理→训练→验证失败', '[{"epoch":1,"loss":0.68},{"epoch":5,"loss":0.25}]', 'admin'),
('2025-08-14', 'v1.1.1', '成功', 8, 'learning_rate=0.0005, batch_size=256', '数据加载→预处理→训练→验证→测试', '[{"epoch":1,"loss":0.67},{"epoch":10,"loss":0.19}]', 'model_user'),
('2025-08-15', 'v1.2.0', '成功', 4, 'learning_rate=0.001, batch_size=128', '数据加载→预处理→训练→验证', '[{"epoch":1,"loss":0.65},{"epoch":10,"loss":0.18}]', 'model_user'),

-- 8月第四周数据
('2025-08-16', 'v1.2.0', '成功', 4, 'learning_rate=0.001, batch_size=128', '数据加载→预处理→训练→验证', '[{"epoch":1,"loss":0.64},{"epoch":10,"loss":0.17}]', 'model_user'),
('2025-08-17', 'v1.2.0', '成功', 4, 'learning_rate=0.001, batch_size=128', '数据加载→预处理→训练→验证', '[{"epoch":1,"loss":0.63},{"epoch":10,"loss":0.16}]', 'admin'),
('2025-08-18', 'v2.0.0', '成功', 8, 'learning_rate=0.0005, batch_size=256', '数据加载→预处理→增强→训练→验证→测试', '[{"epoch":1,"loss":0.60},{"epoch":10,"loss":0.15}]', 'admin'),
('2025-08-19', 'v2.0.0', '成功', 8, 'learning_rate=0.0005, batch_size=256', '数据加载→预处理→增强→训练→验证→测试', '[{"epoch":1,"loss":0.59},{"epoch":10,"loss":0.14}]', 'admin'),
('2025-08-20', 'v2.0.0', '失败', 8, 'learning_rate=0.0005, batch_size=256', '数据加载→预处理→增强→训练中断', '[{"epoch":1,"loss":0.59}]', 'admin'),

-- 8月第五周数据
('2025-08-21', 'v2.0.1', '成功', 8, 'learning_rate=0.0005, batch_size=256', '数据加载→预处理→增强→训练→验证→测试', '[{"epoch":1,"loss":0.58},{"epoch":10,"loss":0.13}]', 'model_user'),
('2025-08-22', 'v2.0.1', '成功', 8, 'learning_rate=0.0005, batch_size=256', '数据加载→预处理→增强→训练→验证→测试', '[{"epoch":1,"loss":0.57},{"epoch":10,"loss":0.12}]', 'model_user'),
('2025-08-23', 'v2.0.1', '成功', 16, 'learning_rate=0.0005, batch_size=512', '数据加载→预处理→增强→训练→验证→测试', '[{"epoch":1,"loss":0.56},{"epoch":10,"loss":0.11}]', 'model_user'),
('2025-08-24', 'v2.0.1', '成功', 16, 'learning_rate=0.0005, batch_size=512', '数据加载→预处理→增强→训练→验证→测试', '[{"epoch":1,"loss":0.55},{"epoch":10,"loss":0.10}]', 'admin'),
('2025-08-25', 'v3.0.0', '成功', 16, 'learning_rate=0.0001, batch_size=512', '数据加载→预处理→增强→特征工程→训练→验证→测试', '[{"epoch":1,"loss":0.50},{"epoch":10,"loss":0.08}]', 'admin'),

-- 9月第一周数据
('2025-08-26', 'v3.0.0', '成功', 16, 'learning_rate=0.0001, batch_size=512', '数据加载→预处理→增强→特征工程→训练→验证→测试', '[{"epoch":1,"loss":0.49},{"epoch":10,"loss":0.07}]', 'admin'),
('2025-08-27', 'v3.0.0', '失败', 16, 'learning_rate=0.0001, batch_size=512', '数据加载→预处理→增强→特征工程→训练→验证失败', '[{"epoch":1,"loss":0.49},{"epoch":8,"loss":0.09}]', 'admin'),
('2025-08-28', 'v3.0.1', '成功', 16, 'learning_rate=0.0001, batch_size=1024', '数据加载→预处理→增强→特征工程→训练→验证→测试', '[{"epoch":1,"loss":0.48},{"epoch":10,"loss":0.06}]', 'model_user'),
('2025-08-29', 'v3.0.1', '成功', 16, 'learning_rate=0.0001, batch_size=1024', '数据加载→预处理→增强→特征工程→训练→验证→测试', '[{"epoch":1,"loss":0.47},{"epoch":10,"loss":0.05}]', 'model_user'),
('2025-08-30', 'v3.0.1', '成功', 16, 'learning_rate=0.0001, batch_size=1024', '数据加载→预处理→增强→特征工程→训练→验证→测试', '[{"epoch":1,"loss":0.46},{"epoch":10,"loss":0.04}]', 'model_user');



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


-- 插入模型数据
INSERT INTO sys_model_info (
    model_name, version_number, upload_time, call_count,
    precision_rate, recall_rate, model_size, model_path,
    f1_score, description, is_used, create_by
) VALUES
-- model_v1
('model_v1', 'model_v1', '2025-08-10 09:30:00', 4852,
 91.20, 89.50, '256MB', '/models/v1',
 90.30, ' ', '1', 'admin'),

-- model_v2
('model_v2', 'model_v2', '2025-08-18 14:15:00', 5127,
 92.40, 90.80, '320MB', '/models/v2',
 91.60, ' ', '1', 'admin'),

-- model_v3
('model_v3', 'model_v3', '2025-08-25 16:40:00', 5689,
 93.10, 92.30, '410MB', '/models/v3',
 92.70, ' ', '1', 'admin');

-- ----------------------------
-- 意见反馈表
-- ----------------------------
DROP TABLE IF EXISTS sys_feedback;
CREATE TABLE sys_feedback
(
    id             BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    username       VARCHAR(50)  DEFAULT '匿名' COMMENT '用户名',
    feedback_type  VARCHAR(20)  DEFAULT NULL COMMENT '反馈类型（如：功能问题、界面优化、性能问题等）',
    content        TEXT         NOT NULL COMMENT '反馈内容（详细描述问题或建议）',
    contact_info   VARCHAR(100) DEFAULT NULL COMMENT '联系方式（如邮箱、电话，便于后续沟通）',
    status         CHAR(1)      DEFAULT '0' NOT NULL COMMENT '处理状态（0: 待处理, 1: 处理中, 2: 已解决, 3: 已关闭）',
    priority       CHAR(1)      DEFAULT '2' NOT NULL COMMENT '优先级（1: 高, 2: 中, 3: 低）',
    create_by      VARCHAR(64)  DEFAULT '' COMMENT '创建者',
    create_time    DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by      VARCHAR(64)  DEFAULT '' COMMENT '更新者',
    update_time    DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark         VARCHAR(500) DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (id)
) ENGINE = InnoDB COMMENT = '意见反馈表';

INSERT INTO sys_feedback ( username, feedback_type, content, contact_info, status, priority, create_by)
VALUES
    ('张三', '功能问题', '系统在导出报表时经常卡顿，建议优化性能。', 'zhangsan@example.com', '0', '1', 'admin'),
    ('李四', '界面优化', '首页布局不够清晰，希望增加导航栏。', 'lisi@example.com', '0', '2', 'admin');

-- 变电站信息表
DROP TABLE IF EXISTS sys_substation_info;
CREATE TABLE sys_substation_info
(
    id             BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    substation_name VARCHAR(100) NOT NULL COMMENT '变电站名称',
    location        VARCHAR(200) DEFAULT NULL COMMENT '地理位置信息',
    voltage_level   VARCHAR(50)  DEFAULT NULL COMMENT '电压等级，如：220kV',
    create_by       VARCHAR(64)  DEFAULT '' COMMENT '创建者',
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by       VARCHAR(64)  DEFAULT '' COMMENT '更新者',
    update_time     DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark          VARCHAR(500) DEFAULT NULL COMMENT '备注信息',

    PRIMARY KEY (id)
) ENGINE = InnoDB COMMENT = '变电站信息表';

-- 插入示例数据
INSERT INTO sys_substation_info VALUES (1, '草坝站', 'xxxxxx', '220kV', 'admin', '2025-08-01 09:30:00', 'admin', '2025-08-01 09:30:00', '');
INSERT INTO sys_substation_info VALUES (2, '汉源站', 'xxxxxx', '220kV', 'admin', '2025-08-05 14:15:00', 'admin', '2025-08-05 14:15:00', '');
INSERT INTO sys_substation_info VALUES (3, '黄岗站', 'xxxxxx', '220kV', 'admin', '2025-08-08 10:00:00', 'admin', '2025-08-08 10:00:00', '');
INSERT INTO sys_substation_info VALUES (4, '名山站', 'xxxxxx', '110kV', 'admin', '2025-08-12 16:45:00', 'admin', '2025-08-12 16:45:00', '');
INSERT INTO sys_substation_info VALUES (5, '顺河站', 'xxxxxx', '220kV', 'admin', '2025-08-15 08:20:00', 'admin', '2025-08-15 08:20:00', '');
INSERT INTO sys_substation_info VALUES (6, '天全站', 'xxxxxx', '110kV', 'admin', '2025-08-18 13:50:00', 'admin', '2025-08-18 13:50:00', '');
INSERT INTO sys_substation_info VALUES (7, '下坪站', 'xxxxxx', '220kV', 'admin', '2025-08-20 11:30:00', 'admin', '2025-08-20 11:30:00', '');
INSERT INTO sys_substation_info VALUES (8, '新棉站', 'xxxxxx', '220kV', 'admin', '2025-08-22 15:10:00', 'admin', '2025-08-22 15:10:00', '');
INSERT INTO sys_substation_info VALUES (9, '荥经站', 'xxxxxx', '110kV', 'admin', '2025-08-25 09:40:00', 'admin', '2025-08-25 09:40:00', '');
INSERT INTO sys_substation_info VALUES (10, '竹马站', 'xxxxxx', '220kV', 'admin', '2025-08-28 14:20:00', 'admin', '2025-08-28 14:20:00', '');
INSERT INTO sys_substation_info VALUES (11, '七盘站', 'xxxxxx', '110kV', 'admin', '2025-08-30 10:50:00', 'admin', '2025-08-30 10:50:00', '');


