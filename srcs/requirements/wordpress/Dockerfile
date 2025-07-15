FROM alpine:3.21

WORKDIR /usr/local/bin

ARG UID=10000
ARG GID=10000
ARG USERNAME="wordpress"
ARG GROUPNAME="webserver"

RUN ["apk", "add", "--no-cache", "php83-fpm", "php-phar", "php-mysqli", "mysql-client", "php-iconv", "php83-session", "php83-pecl-redis", "php83-tokenizer", "php83-ctype", "fcgi"]
RUN sed -i s/"memory_limit = 128M"/"memory_limit = 512M"/ /etc/php83/php.ini
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O wp \
    && chmod 100 wp
RUN addgroup -S $GROUPNAME -g $GID && \
    adduser -S $USERNAME -u $UID -G $GROUPNAME && \
    chown -R $USERNAME /var/log/php83

COPY --chmod=700 --chown=root:root ./tools/wordpress-entrypoint.sh .
COPY --chmod=640 --chown=$USERNAME ./conf/www.conf /etc/php83/php-fpm.d

EXPOSE 9000

WORKDIR /var/www/wordpress

ENTRYPOINT ["wordpress-entrypoint.sh"]

CMD php-fpm83 -F