FROM python:3.9
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

CMD ["python", "/code/main.py"]
