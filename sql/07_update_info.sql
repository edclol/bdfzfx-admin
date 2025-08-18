USE app;
SET NAMES utf8mb4;
SET character_set_database = utf8mb4;
SET collation_database = utf8mb4_0900_ai_ci;


-- 处理所有带.0后缀的数值字符串
UPDATE sys_yx_info_all
SET yx_type = CAST(CAST(yx_type AS DECIMAL) AS CHAR)
WHERE yx_type REGEXP '^[0-9]+\\.0$';




