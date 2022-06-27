FROM nginx:1.21.6-alpine
LABEL maintainer="sanaf@0x30c4.dev"

COPY ./nginx.conf /etc/nginx/nginx.conf.tpl
COPY ./default.conf.tpl /etc/nginx/conf.d/default.conf.tpl
COPY ./global.conf /etc/nginx/conf.d/global.conf.tpl
COPY ./loggin.conf /etc/nginx/conf.d/loggin.conf
COPY ./run.sh /run.sh

USER root

RUN touch /etc/nginx/conf.d/default.conf && \
    touch /etc/nginx/conf.d/global.conf && \
    touch /etc/nginx/conf.d/loggin.conf && \
    touch /etc/nginx/nginx.conf && \
    chown nginx:nginx /etc/nginx/conf.d/* && \
    chown nginx:nginx /etc/nginx/nginx.conf && \
    mkdir /logs && \
    touch /logs && \
    chown nginx:nginx /logs && \
    chmod +x /run.sh

# USER nginx

CMD ["/run.sh"]
