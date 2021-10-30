from uvicorn import run
from fastapi import FastAPI, UploadFile, File, status, HTTPException
from fastapi_sqlalchemy import DBSessionMiddleware, db
from aiofiles import open as aio_open
from pytesseract import image_to_string
from os.path import join
from os import environ
from uuid import uuid4

from models import Image as ModelImage

app = FastAPI(
                openapi_url="/api/openapi.json",
                docs_url="/api/docs"
             )

db_host = environ.get("DATABASE_HOST", default="")
db_port = int(environ.get("DATABSE_PORT", default=5432))
db_user = environ.get("POSTGRES_USER", default="")
db_pass = environ.get("POSTGRES_PASSWORD", default="")
db_name = environ.get("DB_NAME", default="")

db_url = f"postgresql+psycopg2://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}"

app.add_middleware(DBSessionMiddleware, db_url=db_url)

UPLOAD_DIR = environ.get("UPLOAD_DIR", default='')

ALLOWED_FILE_EXT = ("jpeg", "png", "gif", "bmp", "tiff", "jpg")

@app.post("/api/image", status_code=status.HTTP_201_CREATED)
async def process(image: UploadFile = File(...)):

    """
        Check if the content type is image. If not then
        return invalid file type.
    """

    ret_obj = {}

    if not image.content_type.lower().endswith(ALLOWED_FILE_EXT):
        raise HTTPException(status_code=status.HTTP_415_UNSUPPORTED_MEDIA_TYPE,
                            detail="File Type Not Supported! Supported File"
                            f"type [{', '.join(ALLOWED_FILE_EXT)}]")
    else:
        # Get the image extention.
        file_ext = image.content_type.split("/")[1]

        # Create ModelImage obj to get the UUID.
        image_db = ModelImage(
                        text="asdasd as", file_ext=file_ext,
                        original_file_name=image.filename, uuid=uuid4().hex
                   )

        file_name = image_db.uuid.__str__() + "." + file_ext
        file_path = join(UPLOAD_DIR, file_name)

        # Write image to the disk
        async with aio_open(file_path, "wb") as out_file:
            while content := await image.read(1024):
                await out_file.write(content)

        image_db.text = image_to_string(file_path)

        db.session.add(image_db)
        db.session.commit()

        ret_obj["text"] = image_db.text
        ret_obj["url"] = file_name

    return ret_obj


@app.get("/api/get_images/{uuid}")
async def get_images(uuid: str):
    """
        Find image by UUID
    """
    image: ModelImage = db.session.query(ModelImage).filter(ModelImage.uuid == uuid).first()

    if not image:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Image Not Fount!")

    return image


if __name__ == "__main__":
    port = int(environ.get("PORT", default=5000))
    workers = int(environ.get("WORKERS", default=1))
    host = environ.get("HOST", default="0.0.0.0")
    log_level = environ.get("LOG_LEVEL", default="info")

    reload = int(environ.get("RELOAD", default="1"))

    run(
        "main:app", host=host, port=port,
        log_level=log_level, workers=workers,
        reload=reload
    )

