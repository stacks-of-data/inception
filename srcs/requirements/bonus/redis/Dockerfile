FROM alpine:3.21

RUN ["apk", "--no-cache", "add", "redis"]

COPY ./conf/redis.conf /etc
COPY --chmod=700 --chown=root:root ./tools/redis-healthcheck.sh /usr/local/bin
COPY --chmod=700 --chown=root:root ./tools/redis-entrypoint.sh /usr/local/bin

EXPOSE 6379

ENTRYPOINT ["redis-entrypoint.sh"]

CMD ["redis-server", "/etc/redis.conf"]