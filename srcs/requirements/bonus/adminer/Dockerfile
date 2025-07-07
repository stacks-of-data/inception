FROM alpine:3.21

ARG GID=10000
ARG USERNAME="nginx"
ARG GROUPNAME="webserver"

WORKDIR /var/www/adminer

RUN ["apk", "--no-cache", "add", "nginx"]
#RUN ["wget", "https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0-mysql.php", "-O", "index.php"]

RUN addgroup -S $GROUPNAME -g $GID && \
    addgroup $USERNAME $GROUPNAME

COPY --chmod=700 --chown=root:root ./tools/adminer-entrypoint.sh /usr/local/bin
COPY --chmod=640 ./conf/nginx.conf.template /etc/nginx
COPY --chmod=640 ./conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf

EXPOSE 80

ENTRYPOINT ["adminer-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]