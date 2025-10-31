## 平台简介

* 前端采用Vue、Element UI。
* 后端采用Spring Boot、Spring Security、Redis & Jwt。
* 权限认证使用Jwt，支持多终端认证系统。
* 支持加载动态权限菜单，多方式轻松权限控制。

## 内置功能

1.  用户管理：用户是系统操作者，该功能主要完成系统用户配置。
2.  部门管理：配置系统组织机构（公司、部门、小组），树结构展现支持数据权限。
3.  岗位管理：配置系统用户所属担任职务。
4.  菜单管理：配置系统菜单，操作权限，按钮权限标识等。
5.  角色管理：角色菜单权限分配、设置角色按机构进行数据范围权限划分。
6.  字典管理：对系统中经常使用的一些较为固定的数据进行维护。
7.  参数管理：对系统动态配置常用参数。
8.  通知公告：系统通知公告信息发布维护。
9.  操作日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。
10. 登录日志：系统登录日志记录查询包含登录异常。
11. 在线用户：当前系统中活跃用户状态监控。
12. 定时任务：在线（添加、修改、删除)任务调度包含执行结果日志。
13. 代码生成：前后端代码的生成（java、html、xml、sql）支持CRUD下载 。
14. 系统接口：根据业务代码自动生成相关的api接口文档。
15. 服务监控：监视当前系统CPU、内存、磁盘、堆栈等相关信息。
16. 缓存监控：对系统的缓存信息查询，命令统计等。
17. 在线构建器：拖动表单元素生成相应的HTML代码。
18. 连接池监视：监视当前系统数据库连接池状态，可进行分析SQL找出系统性能瓶颈。

## new-ui 账号密码
- admin/W41XsAftTYp90ayhg8P
- shuzihua_1/shuzihua123
- shuzihua_2/shuzihua123
- shuzihua_3/shuzihua123
- shuzihua_4/shuzihua123
- shuzihua_5/shuzihua123
- yunjian_1/yunjian123
- yunjian_2/yunjian123
- yunjian_3/yunjian123
- yunjian_4/yunjian123
- yunjian_5/yunjian123
- yunjian_6/yunjian123
- yunjian_7/yunjian123
- yunjian_8/yunjian123
- yunjian_9/yunjian123
- yunjian_10/yunjian123

## 旧版UI账号密码
- 管理员账号/密码: admin/1Q2w3e4r5t
- 普通用户账号/密码: yunjian_1/1Q2w3e4r5t


系统启动说明
一、环境要求服务器需已安装 Docker 与 Docker Compose。
二、部署步骤
上传文件：将本目录所有文件（含sql文件夹、.env、compose.yml、image_tar文件夹）至服务器目标路径（例：/opt/[项目名]）。
进入目录：登录服务器，终端执行：
bash
cd /opt/[项目名]
加载镜像：进入目录后，先加载image_tar文件夹中的所有镜像文件（否则docker compose可能因找不到镜像而启动失败），执行：
bash
# 批量加载所有tar.gz格式的镜像
for tar in ./image_tar/*.tar.gz; do docker load -i $tar; done
启动服务：
bash
docker compose up -d
三、验证与访问检查状态：执行以下命令，确保所有服务状态为Up：
bash
docker compose ps
访问系统：浏览器输入 http://服务IP:8082/，确认登录页正常加载。
四、异常排查
端口检查：若无法访问，确认服务器防火墙已开放 8082 端口。
日志排查：查看容器日志定位问题：
bash
docker compose logs -f
五、补充说明
sql文件夹：存放数据库初始化脚本，由compose.yml中数据库服务自动加载执行。
.env文件：存放项目环境变量（如数据库密码、服务端口），请勿随意修改。
image_tar文件夹：存放项目所需的 Docker 镜像压缩包，需先通过docker load加载至本地镜像库，否则服务无法启动。



svc
bdfzfx-admin-service:8080
bdfzfx-admin-mysql:3306
bdfzfx-admin-redis:6379


kubectl exec -it mysql-sts-0-0 -- /bin/bash
mysql -u app -ptB91Y7X5e8oipZJu


申请四个端口出来；要访问14机器的 30377(mysql) 30378(new-ui) 30379(old-ui) 30380(bigscreen);这端口可以改 只要符合要求就行



## new-ui 账号密码
- admin/W41XsAftTYp90ayhg8P
- shuzihua_1/shuzihua123
- shuzihua_2/shuzihua123
- shuzihua_3/shuzihua123
- shuzihua_4/shuzihua123
- shuzihua_5/shuzihua123
- yunjian_1/yunjian123
- yunjian_2/yunjian123
- yunjian_3/yunjian123
- yunjian_4/yunjian123
- yunjian_5/yunjian123
- yunjian_6/yunjian123
- yunjian_7/yunjian123
- yunjian_8/yunjian123
- yunjian_9/yunjian123
- yunjian_10/yunjian123

## 旧版UI账号密码
- 管理员账号/密码: admin/1Q2w3e4r5t
- 普通用户账号/密码: yunjian_1/1Q2w3e4r5t




