from uvicorn import run
from fastapi import FastAPI, UploadFile, File, status, HTTPException, Response
from fastapi.middleware.cors import CORSMiddleware
from fastapi_sqlalchemy import DBSessionMiddleware, db
from aiofiles import open as aio_open
from pytesseract import image_to_string
from os.path import join
from uuid import uuid4

from models import Image as ModelImage

# Importing the ENV vars from config
from config import (
                    DATABASE_URL,
                    UPLOAD_DIR,
                    ALLOWED_FILE_EXT,
                    PORT,
                    WORKERS,
                    HOST,
                    RELOAD,
                    LOG_LEVEL
)

app = FastAPI(
                openapi_url="/api/openapi.json",
                docs_url="/api/docs"
             )

origins = [
    "http://192.168.69.55",
    "http://192.168.69.3",
    "https://ocr.0x30c4.dev",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.add_middleware(DBSessionMiddleware, db_url=DATABASE_URL)


@app.post("/api/image", status_code=status.HTTP_201_CREATED)
async def process(file: UploadFile = File(...)):

    """
        Processes the image and returns the extracted text.

        - **file** : The file that need will be processed.
    """

    ret_obj = {}

    if not file.content_type.lower().endswith(ALLOWED_FILE_EXT):
        raise HTTPException(status_code=status.HTTP_415_UNSUPPORTED_MEDIA_TYPE,
                            detail="File Type Not Supported! Supported File"
                            f"type [{', '.join(ALLOWED_FILE_EXT)}]")
    else:
        # Get the image extention.
        file_ext = file.content_type.split("/")[1]

        # print(UPLOAD_DIR)
        # return {}

        # Create ModelImage obj to get the UUID.
        image_db = ModelImage(
                        text="", file_ext=file_ext,
                        original_file_name=file.filename, uuid=uuid4().hex
                   )

        # Creating file name for the image.
        file_name = image_db.uuid.__str__() + "." + file_ext
        file_path = join(UPLOAD_DIR, file_name)

        # Write image to the disk
        async with aio_open(file_path, "wb") as out_file:
            while content := await file.read(1024):
                await out_file.write(content)

        # Extracting text from the image.
        image_db.text = image_to_string(file_path)

        # Putting the text data on the db.
        db.session.add(image_db)
        db.session.commit()

        if not image_db.text.strip():
            image_db.text = 'No Text Was Found!'

        ret_obj["text"] = image_db.text
        ret_obj["url"] = "uploads/" + file_name

    return ret_obj


@app.get("/api/get_images/{uuid}")
async def get_images(response: Response, uuid: str):
    """
        Find image by UUID and if the image is found on then
        return the images text and other data.

        - **uuid** : The UUID of the image that you want to get
                     data of.
    """
    # response.set_cookie(key="s", value="s")
    # Making a query for the data.
    image: ModelImage = db.session.query(ModelImage).\
                            filter(ModelImage.uuid == uuid).first()


    # If nothing was found then rise a 404 not found exception.
    if not image:
        raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Image Not Fount!"
        )

    # Don't output the id no
    del image.id

    return image


if __name__ == "__main__":
    run(
        "main:app", host=HOST, port=PORT,
        log_level=LOG_LEVEL, workers=WORKERS,
        reload=RELOAD
    )

