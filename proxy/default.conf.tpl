upstream backend {
    server ocr_api_srv:5000;
}

server {
    listen 80;

    location /static {
        alias /vol/web/static;
    }
    
    location /uploads {
        alias /vol/web/uploads;
    }

    location / {
        proxy_pass http://backend;
    }
}