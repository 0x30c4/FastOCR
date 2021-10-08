FROM python:3.9-alpine3.13 as production
LABEL maintainer="sanaf"

ENV PYTHONUNBUFFERED 1

# COPY app/requirements.txt /requirements.txt
COPY ./app /code

WORKDIR /code

RUN pip install --upgrade pip && \
    pip install -r /code/requirements.txt && \
    apk add --update --no-cache tesseract-ocr

# RUN pip install --upgrade pip && \
#     apk add --update --no-cache postgresql-client && \
#     apk add --update --no-cache --virtual .tmp-deps \
#         build-base postgresql-dev musl-dev linux-headers libffi-dev cairo-dev pango-dev gdk-pixbuf-dev rust openssl-dev python3-dev cargo libressl-dev && \
#     apk add jpeg-dev zlib-dev && \
#     pip install -r /requirements_.txt && \
#     mkdir -p /vol/web/static && \
#     mkdir -p /vol/web/media && \
#     chmod -R +x /scripts
#     # apk del .tmp-deps && \

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends zip bash libpq-dev gcc linux-headers-$(uname -r) build-essential  && \
#     pip install --upgrade pip && \
#     pip install -r /requirements_.txt && \
#     mkdir -p /vol/web/static && \
#     mkdir -p /vol/web/media && \
#     chmod -R +x /scripts 

# ENV PYTHONPATH "${PYTHONPATH}:/py/lib/python3.9/site-packages/"

EXPOSE 8080

# ENV PATH="/scripts:/py/bin/:$PATH"

CMD ["/code/start_api"]
# apk --update --upgrade add gcc musl-dev jpeg-dev zlib-dev libffi-dev cairo-dev pango-dev gdk-pixbuf-dev