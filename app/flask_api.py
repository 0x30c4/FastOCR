#!/usr/bin/python
from flask import Flask, request, render_template, make_response, jsonify, redirect
from werkzeug.utils import secure_filename

from subprocess import check_output
import os
from uuid import uuid4

app = Flask(__name__, template_folder='templates')

UPLOAD_DIR = os.environ.get("UPLOAD_DIR", default="/tmp")
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

# print(UPLOAD_DIR)


def allowed_file(filename):
    return '.' in filename and \
            filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def image_to_txt(filename):
    txt = ''
    try:
        txt = check_output(['tesseract', filename, 'stdout'])
        txt = txt.decode()
    except Exception as e:
        print(e)

    return txt

@app.route("/", methods=['GET'])
def home():
    return render_template("index.html")

@app.route("/upload-video", methods=['GET', 'POST'])
def upload():

    if request.method == "POST":

        if 'file' not in request.files:
            # flash('No file part')
            return redirect(request.url)

        file = request.files['file']

        if file.filename == '':
            #flash('No selected file')
            return make_response(jsonify({"message": "No file"}), 200)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)

            filename = uuid4().hex + filename

            local_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)

            file.save(local_path)

            txt = image_to_txt(local_path)

            # os.remove(local_path)

            if not txt:
                txt = 'An Error Occoured!'

            return make_response(jsonify({"text_in_image": txt}), 200)
        else:
            return make_response(jsonify({"message": "File Not Allowed!"}), 200)

    return make_response(jsonify({"message": "Upload a file."}), 200)

# if __name__ == "__main__":
#     app.run(host="0.0.0.0", port=8080)
