FROM alpine:3.21

ARG UID=10000
ARG GID=10000
ARG USERNAME="webserver"
ARG GROUPNAME="webserver"

WORKDIR /app

RUN ["apk", "add", "--no-cache", "nginx"]
RUN addgroup -S $GROUPNAME -g $GID && \
    adduser -S $USERNAME -u $UID $GID && \
    chown -R $UID:$GID /var/log/nginx /var/lib/nginx /etc/nginx /run/nginx

COPY --chmod=640 ./conf/nginx.conf.template /etc/nginx
COPY --chmod=640 ./conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf
COPY --chmod=700 ./tools/nginx-entrypoint.sh /usr/local/bin

EXPOSE 443

ENTRYPOINT ["nginx-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]