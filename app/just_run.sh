#!/bin/sh

# python /root/gpt-j-api/flask_api.py &>> /root/gpt-j-api/log &

# python /code/wsgi.py
# uwsgi --socket 0.0.0.0:8080 --protocol=http -w wsgi:app

# cd /code

# uwsgi --plugin /usr/lib/uwsgi/python_plugin.so --socket 0.0.0.0:5000 --protocol=http -w wsgi:app

#gunicorn -w 3 --bind 0.0.0.0:5000 wsgi:app

# uvicorn main:app --host 0.0.0.0 --port 5000

export PORT=8000
export WORKERS=2
export HOST="0.0.0.0"
export LOG_LEVEL=info
export RELOAD=1
export UPLOAD_DIR="../data/media/uploads"

python main.py
