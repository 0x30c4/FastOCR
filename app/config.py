
from os import environ


db_host = environ.get("DATABASE_HOST")
db_port = int(environ.get("DATABSE_PORT"))
db_user = environ.get("POSTGRES_USER")
db_pass = environ.get("POSTGRES_PASSWORD")
db_name = environ.get("POSTGRES_DB")

ALLOWED_FILE_EXT = ("jpeg", "png", "gif", "bmp", "tiff", "jpg")

DATABASE_URL = f"postgresql+psycopg2://{db_user}" \
               f":{db_pass}@{db_host}:{db_port}/{db_name}"

UPLOAD_DIR = environ.get("UPLOAD_DIR_CONT", default='')

PORT = int(environ.get("API_PORT"))
WORKERS = int(environ.get("WORKERS"))
HOST = environ.get("HOST")
LOG_LEVEL = environ.get("LOG_LEVEL")
RELOAD = int(environ.get("RELOAD"))
LOG_INI = environ.get("APP_LOG_INI")
