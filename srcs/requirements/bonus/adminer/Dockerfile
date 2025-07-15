FROM alpine:3.21

ARG GID=10000
ARG USERNAME="nginx"
ARG GROUPNAME="webserver"

WORKDIR /var/www/adminer

RUN ["apk", "--no-cache", "add", "nginx"]

RUN addgroup -S $GROUPNAME -g $GID && \
    addgroup $USERNAME $GROUPNAME && \
    mkdir /etc/nginx/snippets && \
    chown $USERNAME /etc/nginx/snippets

COPY --chmod=700 --chown=root:root ./tools/adminer-entrypoint.sh /usr/local/bin
COPY --chmod=640 --chown=$USERNAME ./conf/nginx.conf /etc/nginx
COPY --chmod=640 --chown=$USERNAME ./conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf

EXPOSE 8080

ENTRYPOINT ["adminer-entrypoint.sh"]

CMD nginx -g "daemon off;"