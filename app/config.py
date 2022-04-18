
from os import environ


db_host = environ.get("DATABASE_HOST", default="")
db_port = int(environ.get("DATABSE_PORT", default=5432))
db_user = environ.get("POSTGRES_USER", default="")
db_pass = environ.get("POSTGRES_PASSWORD", default="")
db_name = environ.get("DB_NAME", default="")

ALLOWED_FILE_EXT = ("jpeg", "png", "gif", "bmp", "tiff", "jpg")

DATABASE_URL = f"postgresql+psycopg2://{db_user}" \
               f":{db_pass}@{db_host}:{db_port}/{db_name}"

UPLOAD_DIR = environ.get("UPLOAD_DIR_CONT", default='')

PORT = int(environ.get("API_PORT", default=5000))
WORKERS = int(environ.get("WORKERS", default=1))
HOST = environ.get("HOST", default="0.0.0.0")
LOG_LEVEL = environ.get("LOG_LEVEL", default="info")
RELOAD = int(environ.get("RELOAD", default="1"))
