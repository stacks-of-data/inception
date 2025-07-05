FROM alpine:3.21

WORKDIR /usr/local/bin

ARG UID=10001
ARG GID=10000
ARG USERNAME="wordpress"
ARG GROUPNAME="webserver"

RUN ["apk", "add", "--no-cache", "php-fpm", "php-phar", "php-mysqli", "mysql-client", "php-iconv", "fcgi"]
RUN sed -i s/"memory_limit = 128M"/"memory_limit = 512M"/ /etc/php83/php.ini
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O wp \
    && chmod 100 wp
RUN addgroup -S $GROUPNAME -g $GID && \
    adduser -S $USERNAME -u $UID $GID

COPY --chmod=700 --chown=root:root ./tools/wordpress-entrypoint.sh .
COPY --chmod=640 --chown=root:root ./conf/www.conf.template /etc/php83/php-fpm.d/www.conf.template

EXPOSE 9000

WORKDIR /var/www/wordpress

ENTRYPOINT ["wordpress-entrypoint.sh"]

CMD ["php-fpm83", "-F"]