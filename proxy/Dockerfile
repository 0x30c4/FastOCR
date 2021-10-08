FROM nginxinc/nginx-unprivileged:1-alpine
LABEL maintainer="sanaf"

COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
# COPY ./uwsgi_params /etc/nginx/uwsgi_params
COPY ./run.sh /run.sh

ENV LISTEN_PORT 61571
ENV APP_HOST ocr_nginx
ENV APP_PORT 5000

USER root

RUN mkdir -p /vol/web
RUN touch /etc/nginx/conf.d/default.conf
RUN chown nginx:nginx /etc/nginx/conf.d/default.conf
RUN chmod +x /run.sh

USER nginx

CMD ["/run.sh"]