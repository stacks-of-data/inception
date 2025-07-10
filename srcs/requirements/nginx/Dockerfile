FROM alpine:3.21

ARG GID=10000
ARG USERNAME="nginx"
ARG GROUPNAME="webserver"

WORKDIR /var/www/wordpress

RUN ["apk", "add", "--no-cache", "nginx"]

RUN addgroup -S $GROUPNAME -g $GID && \
    addgroup $USERNAME $GROUPNAME

COPY --chmod=640 ./conf/nginx.conf /etc/nginx
COPY --chmod=640 ./conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf
COPY --chmod=700 ./tools/nginx-entrypoint.sh /usr/local/bin

EXPOSE 443

ENTRYPOINT ["nginx-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]