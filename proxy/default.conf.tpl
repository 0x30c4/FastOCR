upstream backend {
    server ocr_api_srv:5000;
}

server {
    listen 80;

    add_header Access-Control-Allow-Origin *;

    index index.html;

    location / {
        alias /vol/web/static/;
    }
    
    location /uploads {
        alias /vol/web/uploads;
        client_max_body_size 150M;
    }

    location /api {
        proxy_pass http://backend;
    }
}
