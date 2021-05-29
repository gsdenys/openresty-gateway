#FROM mmaartje/openresty:arm64v8-1.17.8.1rc1
FROM openresty/openresty:1.19.3.1-3-alpine-fat
# FROM openresty/openresty:1.19.3.1-buster-fat


#RUN apt update && apt upgrade -y && apt install -y luarocks
RUN apk add git
# RUN apt update && \
#     apt -y upgrade && \
#     apt -y install git luarocks

RUN mkdir -p /etc/openresty/sites/

COPY src/* /etc/openresty/sites/
COPY default.conf /etc/nginx/conf.d/default.conf

RUN luarocks install lua-resty-redis

#RUN luarocks install --server=https://luarocks.org/dev log4lua

EXPOSE 8080