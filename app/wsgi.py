from flask_api import app, UPLOAD_DIR
from os import environ

app.config['DEBUG'] = bool(environ.get("DEBUG", default="0"))
app.config['UPLOAD_FOLDER'] = UPLOAD_DIR
app.config['MAX_CONTENT_LENGTH'] = 8 * 1000 * 1000

if __name__ == "__main__":
    # port = int(environ.get("LISTEN_PORT", default="8080")) 
    app.run()