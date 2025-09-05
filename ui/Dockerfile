# 第一阶段：构建 Vue 项目
FROM node:16-alpine as build-stage

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm install --registry=https://registry.npmmirror.com

# 复制项目源代码
COPY . .

# 构建生产环境版本
RUN npm run build:prod

# 第二阶段：部署到 Nginx
FROM nginx:alpine as production-stage

# 从构建阶段复制打包结果到 Nginx 静态资源目录
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY ./ui-old/dist /usr/share/nginx/old_html
# 复制自定义 Nginx 配置（如果需要）
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY ./ui-old/nginx-old.conf /etc/nginx/conf.d/old_default.conf

# 暴露 80 端口
EXPOSE 80
# old-ui
EXPOSE 81

# 启动 Nginx 服务
CMD ["nginx", "-g", "daemon off;"]
