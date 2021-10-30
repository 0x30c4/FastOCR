FROM python:3.9 as dev
LABEL maintainer="Sanaf <sanaf@0x30c4.dev>"

ENV PYTHONUNBUFFERED=1

COPY app/requirements.txt /requirements.txt
COPY ./app /code

WORKDIR /code


RUN pip install --upgrade pip && \
    pip install --no-cache-dir --upgrade -r /requirements.txt && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/uploads && \
    apt-get update && \
    apt-get install -y tesseract-ocr && \
    rm /requirements.txt



# RUN apk add --update --no-cache --virtual .tmp-deps tesseract-ocr build-base jpeg-dev zlib-dev  postgresql-dev  && \
#     pip install --upgrade pip && \
#     pip install --no-cache-dir --upgrade -r /requirements.txt && \
#     mkdir -p /vol/web/static && \
#     mkdir -p /vol/web/uploads && \
#     rm /requirements.txt &&\
#     apk del build-base jpeg-dev zlib-dev 

CMD ["python", "/code/main.py"]
