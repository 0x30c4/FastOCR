#!/bin/bash
export NGINX_LESTEN_PORT=80
export STATIC_ROOT_REL="./data/media/static"
export MEDIA_ROOT_REL="./data/media/uploads"

# app vars.
export PORT=5000
export WORKERS=2
export HOST=0.0.0.0
export LOG_LEVEL=info
export RELOAD=1
export UPLOAD_DIR="./data/media/uploads"

export DATABASE_URL=postgresql+psycopg2://user:1234@192.168.69.55:5432/image
python ./app/main.py
python main.py
