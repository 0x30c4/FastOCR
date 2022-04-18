#!/bin/bash

set -e

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
export POSTGRES_USER=user
export DATABASE_HOST=192.168.0.105
export POSTGRES_PASSWORD=1234
export DB_NAME=image
export DATABSE_PORT=5432


sudo docker run -d \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    -e POSTGRES_USER=POSTGRES_USER \
    -e POSTGRES_DB=DB_NAME \
    postgres

# export DATABASE_URL=postgresql+psycopg2://user:1234@192.168.0.105:5432/image
cd app
alembic upgrade head
cd ..
python ./app/main.py
# python main.py
