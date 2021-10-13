#!/usr/bin/python3
from fastapi import FastAPI, File, UploadFile
from uvicorn import run
from pytesseract import image_to_string
from os import environ, path
from uuid import uuid4

app = FastAPI()

"""
    If no upload directory is given in the env variable then
    the app will exit.
"""
UPLOAD_DIR = environ.get("UPLOAD_DIR", default='')

@app.post("/process")
async def process(image: UploadFile = File(...)):

    """
        Check if the content type is image. If not then
        return invalid file type.
    """

    ret_dic = {}

    if not image.content_type.startswith('image/'):
        ret_dic = {"Error": "Uploaded File is not a IMAGE!"}

    else:
        image.filename = uuid4().__str__()
        upload_path = path.join(UPLOAD_DIR, image.filename)

        contents = await image.read()

        with open(upload_path, "wb") as f:
            f.write(contents)

        i2text = image_to_string(upload_path)

        if not i2text.strip():
            i2text = "Sorry! Couldn't detect any text."

        ret_dic = {
            "image_to_text": i2text,
            "file_name": image.filename
        }

    return ret_dic

if __name__ == "__main__":

    '''
        Load all the environment variables.
    '''

    if not UPLOAD_DIR:
        exit(-1)

    port = int(environ.get("PORT", default=5000))
    workers = int(environ.get("WORKERS", default=1))
    host = environ.get("HOST", default="0.0.0.0")
    log_level = environ.get("LOG_LEVEL", default="info")

    reload = int(environ.get("RELOAD", default="0"))

    run(
        "main:app", host=host, port=port,
        log_level=log_level, workers=workers,
        reload=reload
    )
