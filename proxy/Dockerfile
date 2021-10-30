FROM nginxinc/nginx-unprivileged:1-alpine
LABEL maintainer="sanaf"

COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./nginx.conf /etc/nginx/nginx.conf
# COPY ./uwsgi_params /etc/nginx/uwsgi_params
COPY ./run.sh /run.sh

USER root

RUN mkdir -p /vol/web && \
    touch /etc/nginx/conf.d/default.conf && \
    chown nginx:nginx /etc/nginx/conf.d/default.conf && \
    chmod +x /run.sh

USER nginx

CMD ["/run.sh"]
