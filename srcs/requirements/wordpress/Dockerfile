FROM alpine:3.21

WORKDIR /app

RUN ["apk", "add", "--no-cache", "php-fpm"]
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php83/php-fpm.d/www.conf

COPY --chmod=700 ./tools/wordpress-entrypoint.sh /usr/local/bin

EXPOSE 9000

ENTRYPOINT ["wordpress-entrypoint.sh"]

CMD ["php-fpm83", "-F"]