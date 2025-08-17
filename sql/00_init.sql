SET NAMES utf8mb4;
SET character_set_database = utf8mb4;
SET collation_database = utf8mb4_0900_ai_ci;

create database if not exists app;

USE app;

ALTER DATABASE app
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci ;