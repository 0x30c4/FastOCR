server {
    listen $NGINX_LESTEN_PORT_CONT;

    add_header Access-Control-Allow-Origin *;

    location / {
        alias /vol/web/static/;
    }
    
    location /uploads {
        alias /vol/web/uploads;
        client_max_body_size 150M;
    }

    location /api {
        proxy_pass http://api.net:8080;
    }
}
