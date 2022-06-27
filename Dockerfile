FROM python:3.10.4-bullseye
LABEL maintainer="Sanaf <sanaf@0x30c4.dev>"

ENV PYTHONUNBUFFERED=1

COPY app/requirements.txt /requirements.txt
COPY ./app /code

WORKDIR /code

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential libpq-dev gettext && \
	pip install --upgrade pip && \
    pip install --no-cache-dir --upgrade -r /requirements.txt && \
    apt-get install -y tesseract-ocr && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/uploads && \
    rm /requirements.txt

COPY ./scripts/api-envsubst-log-ini.sh /api-envsubst-log-ini.sh
COPY ./config/logs/log.ini.tpl /log.ini.tpl
# CMD ["python", "/code/main.py"]
