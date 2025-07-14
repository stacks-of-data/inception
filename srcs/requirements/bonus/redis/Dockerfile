FROM alpine:3.21

WORKDIR /

RUN ["apk", "--no-cache", "add", "redis"]

RUN mkdir redis_config && \
    chmod 740 redis_config && \
    chown redis:redis redis_config

COPY --chmod=640 --chown=redis:redis ./conf/redis.conf /redis_config/
COPY --chmod=700 --chown=root:root ./tools/redis-healthcheck.sh /usr/local/bin/
COPY --chmod=700 --chown=root:root ./tools/redis-entrypoint.sh /usr/local/bin/

EXPOSE 6379

ENTRYPOINT ["redis-entrypoint.sh"]

CMD redis-server /redis_config/redis.conf