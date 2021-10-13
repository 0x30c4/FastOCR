FROM python:3.9-alpine3.13 as dev
LABEL maintainer="sanaf"

ENV PYTHONUNBUFFERED 1

COPY app/requirements.txt /requirements.txt
# COPY ./app /code

WORKDIR /code

RUN pip install --upgrade pip && \
    apk add --update --no-cache --virtual .tmp-deps tesseract-ocr build-base jpeg-dev zlib-dev  && \
    pip install -r /requirements.txt && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/uploads && \
    rm /requirements.txt &&\
    apk del build-base jpeg-dev zlib-dev 

CMD ["/code/start_api"]
