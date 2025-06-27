FROM alpine:3.21

WORKDIR /app

RUN ["apk", "add", "nginx"]

COPY ./nginx.conf /etc/nginx
COPY ./tools/index.html .

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]