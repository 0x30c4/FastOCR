#!/bin/sh

set -e

envsubst < /etc/nginx/conf.d/default.conf.tpl > /etc/nginx/conf.d/default.conf
envsubst < /etc/nginx/conf.d/global.conf.tpl > /etc/nginx/conf.d/global.conf
envsubst < /etc/nginx/nginx.conf.tpl > /etc/nginx/nginx.conf

nginx -g 'daemon off;'
