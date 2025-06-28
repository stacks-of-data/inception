FROM alpine:3.21

WORKDIR /app

RUN ["apk", "add", "nginx"]

COPY ./conf /etc/nginx
COPY ./tools/index.html .

EXPOSE 443

CMD ["/bin/sh", "-c", "sed s/'$DOMAIN_NAME'/$DOMAIN_NAME/ < /etc/nginx/conf > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"]