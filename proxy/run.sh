#!/bin/sh

set -e

envsubst < /etc/nginx/conf.d/default.conf.tpl > /etc/nginx/conf.d/default.conf
envsubst < /etc/nginx/conf.d/global.conf.tpl > /etc/nginx/conf.d/global.conf
envsubst < /etc/nginx/nginx.conf.tpl > /etc/nginx/nginx.conf
# envsubst < /etc/nginx/conf.d/default.conf.tpl
# envsubst < /etc/nginx/conf.d/global.conf.tpl
# envsubst < /etc/nginx/nginx.conf

# nginx -t
# id
# ls -la /logs
nginx -g 'daemon off;'
