# 使用 Debian Bullseye 镜像作为基础
FROM debian:bullseye

# 更新软件包列表并安装 Nginx、PHP 和相关扩展
RUN apt-get update && apt-get install -y nginx php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-intl php7.4-mbstring php7.4-xml php7.4-zip

# 清理 apt 缓存和临时文件
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 将本地的 Nginx 配置文件复制到容器中
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/www.conf /etc/nginx/conf.d/www.conf

# 将本地的 PHP 配置文件复制到容器中
COPY php/php.ini /etc/php/7.4/fpm/php.ini

# 将运行 PHP + Nginx 服务的脚本复制到容器中
COPY startup.sh /opt/startup.sh

# 赋予脚本可执行权限
RUN chmod +x /opt/startup.sh

# 将容器的 80 端口暴露给外部访问
EXPOSE 80
EXPOSE 8000

# 使用脚本启动 PHP + Nginx 服务
CMD ["/bin/bash", "/opt/startup.sh"]
