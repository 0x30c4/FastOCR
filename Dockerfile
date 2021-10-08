FROM python:3.9-alpine3.13 as dev
LABEL maintainer="sanaf"

ENV PYTHONUNBUFFERED 1

COPY app/requirements.txt /requirements.txt
# COPY ./app /code

WORKDIR /code

RUN pip install --upgrade pip && \
    pip install -r /requirements.txt && \
    apk add --update --no-cache tesseract-ocr && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/uploads && \
    rm /requirements.txt

CMD ["/code/start_api"]