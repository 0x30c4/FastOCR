#!/usr/bin/env bash


LOG_DIR=$(grep "NGINX_LOG_DIR_HOST" env/.env.* | cut -d = -f 2 | xargs -I{} echo {})

ERROR_LOG=$(grep "NGINX_LOG_ERROR" env/.env.* | cut -d = -f 2 | xargs -I{} echo {})
ACCESS_LOG=$(grep "NGINX_LOG_ACCESS" env/.env.* | cut -d = -f 2 | xargs -I{} echo {})

touch $LOG_DIR/$ERROR_LOG
touch $LOG_DIR/$ACCESS_LOG

chmod 666 $LOG_DIR/$ERROR_LOG
chmod 666 $LOG_DIR/$ACCESS_LOG
