USE app;
SET NAMES utf8mb4;
SET character_set_database = utf8mb4;
SET collation_database = utf8mb4_0900_ai_ci;

-- ----------------------------
-- 映射结果表
-- ----------------------------
DROP TABLE IF EXISTS sys_mapping_result;
CREATE TABLE sys_mapping_result
(
    id              BIGINT(20)    NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    remote_signal_id VARCHAR(100)  NOT NULL COMMENT '遥信ID',
    db_statement    TEXT          DEFAULT NULL COMMENT '条件语句',
    score           DECIMAL(5,3)  DEFAULT NULL COMMENT '相似度',
    elapsed_time    VARCHAR(64)     DEFAULT NULL COMMENT '匹配耗时',
    create_by       VARCHAR(64)   DEFAULT '' COMMENT '创建者',
    create_time     DATETIME      DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by       VARCHAR(64)   DEFAULT '' COMMENT '更新者',
    update_time     DATETIME      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark          VARCHAR(500)  DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (id)
) ENGINE = InnoDB COMMENT = '映射结果表';


-- 插入映射结果数据，90%的记录score在0.800-0.980之间，10%在0.500-0.799之间
INSERT INTO sys_mapping_result (remote_signal_id, db_statement, score, elapsed_time)
SELECT
    yx_id AS remote_signal_id,
    info_name AS db_statement,
    -- 生成符合分布要求的随机score
    CASE
        WHEN RAND() <= 0.9 THEN 0.8 + (RAND() * 0.18)  -- 90%概率：0.800-0.980
        ELSE 0.5 + (RAND() * 0.299)                   -- 10%概率：0.500-0.799
    END AS score,
    -- 生成5-20ms的随机耗时
    CONCAT(FLOOR(5 + (RAND() * 16)), 'ms') AS elapsed_time
FROM sys_yx_info_all limit 4032;


-- ----------------------------
-- 模型预警信息表
-- ----------------------------
DROP TABLE IF EXISTS sys_model_warning;
CREATE TABLE sys_model_warning
(
    id              BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    occur_time      DATETIME    NOT NULL COMMENT '发生时间',
    warning_level   VARCHAR(20) NOT NULL COMMENT '预警等级：CRITICAL=严重，WARNING=警告，INFO=轻微',
    warning_content TEXT        NOT NULL COMMENT '预警内容描述',
    suggestion      TEXT         DEFAULT NULL COMMENT '建议处理措施',
    status          VARCHAR(20)  DEFAULT 'UNHANDLED' COMMENT '状态：UNHANDLED=未处理，PROCESSING=处理中，HANDLED=已处理',
    remark          VARCHAR(500) DEFAULT NULL COMMENT '备注信息',
    create_by       VARCHAR(64)  DEFAULT '' COMMENT '创建者',
    create_time     DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by       VARCHAR(64)  DEFAULT '' COMMENT '更新者',
    update_time     DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB COMMENT = '模型预警信息表';

-- 插入示例数据 日期在最近两个月内
-- 插入模型预警信息数据
INSERT INTO sys_model_warning (occur_time, warning_level, warning_content, suggestion, status, create_by, update_by)
SELECT
    -- 生成最近两个月内的随机时间
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 60) DAY) + INTERVAL FLOOR(RAND() * 86400) SECOND AS occur_time,
    -- 按照70% INFO, 25% WARNING, 5% CRITICAL的比例分配预警等级
    CASE
        WHEN RAND() < 0.7 THEN 'INFO'
        WHEN RAND() < 0.95 THEN 'WARNING'
        ELSE 'CRITICAL'
        END AS warning_level,
    -- 20个固定预警内容随机选择
    ELT(FLOOR(RAND() * 20) + 1,
        '模型预测准确率下降1%',
        '模型训练时间延长5分钟',
        '模型内存使用增加10%',
        '模型输入数据格式轻微异常',
        '模型预测延迟增加2秒',
        '模型的特征重要性分布变化',
        '模型的验证集表现波动',
        '模型的调用频率异常升高',
        '模型的输出范围轻微超出预期',
        '模型的日志文件增大过快',
        '模型的依赖库版本不兼容',
        '模型的训练数据分布偏移',
        '模型的预测结果出现少量异常值',
        '模型的API响应时间增加',
        '模型的存储占用空间不足',
        '模型的并发处理能力达到上限',
        '模型的超参数优化效果不佳',
        '模型的部署环境磁盘IO过高',
        '模型的监控指标缺失',
        '模型的备份策略执行失败'
    ) AS warning_content,
    -- 对应的20个固定建议
    ELT(FLOOR(RAND() * 20) + 1,
        '检查数据源是否有变化',
        '优化训练参数减少训练时间',
        '检查是否有内存泄漏问题',
        '验证数据预处理流程完整性',
        '考虑增加计算资源提升性能',
        '重新评估特征选择有效性',
        '增加验证集规模提高稳定性',
        '检查是否有异常调用来源',
        '调整输出约束条件范围',
        '优化日志记录策略减少占用',
        '更新依赖库到兼容版本',
        '重新采集训练数据修正分布',
        '增加异常检测机制过滤异常值',
        '优化API接口实现逻辑',
        '清理历史数据或扩展存储空间',
        '增加负载均衡或扩展实例',
        '调整超参数搜索范围和策略',
        '优化数据读写策略降低IO',
        '补充必要的监控指标',
        '检查备份脚本和存储路径'
    ) AS suggestion,
    -- 按照70% HANDLED, 30%其他状态的比例分配状态
    CASE
        WHEN RAND() < 0.7 THEN 'HANDLED'
        WHEN RAND() < 0.85 THEN 'PROCESSING'
        ELSE 'UNHANDLED'
        END AS status,
    -- 随机生成创建者和更新者
    CONCAT('user_', FLOOR(RAND() * 10) + 1) AS create_by,
    CONCAT('user_', FLOOR(RAND() * 10) + 1) AS update_by
-- 生成100条测试数据
FROM (
         SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
         UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
     ) t1,
     (
         SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
         UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
     ) t2;

# -- 菜单 SQL
# insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
# values('模型预警', '1', '1', 'warning', 'system/warning/index', 1, 0, 'C', '0', '0', 'system:warning:list', 'build', 'admin', sysdate(), '', null, '模型预警菜单');
#
# -- 按钮父菜单ID
# SELECT @parentId := LAST_INSERT_ID();
#
# -- 按钮 SQL
# insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
# values('模型预警查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:warning:query',        '#', 'admin', sysdate(), '', null, '');
#
# insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
# values('模型预警新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:warning:add',          '#', 'admin', sysdate(), '', null, '');
#
# insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
# values('模型预警修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:warning:edit',         '#', 'admin', sysdate(), '', null, '');
#
# insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
# values('模型预警删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:warning:remove',       '#', 'admin', sysdate(), '', null, '');
#
# insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
# values('模型预警导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:warning:export',       '#', 'admin', sysdate(), '', null, '');

