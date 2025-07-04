FROM alpine:3.21

WORKDIR /app

ARG UID=10001
ARG GID=10000
ARG USERNAME="wordpress"
ARG GROUPNAME="webserver"

RUN ["apk", "add", "--no-cache", "php-fpm"]
RUN addgroup -S $GROUPNAME -g $GID && \
    adduser -S $USERNAME -u $UID $GID

COPY --chmod=700 ./tools/wordpress-entrypoint.sh /usr/local/bin
COPY --chmod=640 ./conf/www.conf.template /etc/php83/php-fpm.d/www.conf.template

EXPOSE 9000

ENTRYPOINT ["wordpress-entrypoint.sh"]

CMD ["php-fpm83", "-F"]