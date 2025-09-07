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

