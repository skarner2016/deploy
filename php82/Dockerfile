# 使用 Debian Bullseye 镜像作为基础
FROM debian:bullseye

ARG UID
ARG GID
ARG USER
ARG GROUP
ARG VERSION

ENV UID=$UID
ENV GID=$GID
ENV USER=$USER
ENV GROUP=$GROUP
ENV VERSION=$VERSION

RUN groupadd -g ${GID} ${GROUP} && \
    useradd -u ${UID} -g ${GID} -s /bin/bash -m ${USER}

RUN mkdir -p /var/www && chown -R ${USER}:${GROUP} /var/www

# 切换到指定用户
#USER ${USER}

# 更新软件包列表并安装 Nginx、PHP 和相关扩展
RUN apt-get update && apt-get install -y lsb-release apt-transport-https ca-certificates wget nginx \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install -y php${VERSION}-fpm php${VERSION}-mysql php${VERSION}-curl php${VERSION}-gd php${VERSION}-intl php${VERSION}-mbstring php${VERSION}-xml php${VERSION}-zip

# 清理 apt 缓存和临时文件
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 将本地的 Nginx 配置文件复制到容器中
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/www.conf /etc/nginx/conf.d/www.conf

# 将本地的 PHP 配置文件复制到容器中
#COPY php/php.ini /etc/php/7.4/fpm/php.ini

# 将运行 PHP + Nginx 服务的脚本复制到容器中
COPY startup.sh /opt/startup.sh

RUN sed -i "s/unix:\/var\/run\/php\/php-fpm.sock/unix:\/var\/run\/php\/php${VERSION}-fpm.sock/g" /etc/nginx/conf.d/www.conf
RUN sed -i "s/php${VERSION}-fpm/php-fpm/g" /opt/startup.sh

# 赋予脚本可执行权限
RUN chmod +x /opt/startup.sh

# 将容器的 80 端口暴露给外部访问
EXPOSE 80
EXPOSE 8000

# 使用脚本启动 PHP + Nginx 服务
CMD ["/bin/bash", "/opt/startup.sh"]
