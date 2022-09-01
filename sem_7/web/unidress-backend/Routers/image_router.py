from flask import Blueprint, make_response, render_template, request
from base64 import b64encode


import json_routine
from Repositories.ImageRepository import ImageRepository

image_service = Blueprint('image_service', __name__,url_prefix='/api/v1/image')


@image_service.route('/send', methods=['GET', 'POST'])
def send():
    base = ImageRepository()
    try:
        data = request.files['file'].read()
        result = base.save_photo(data)
        return result
    except Exception:
        return json_routine.getErrorJSON("internal server error"), 500


@image_service.route('/', methods=['GET', 'PUT'])
def coordinate():
    method = request.method
    if method == 'GET':
        return getImage(request)
    elif method == 'PUT':
        return changeImage(request)
    else:
        return json_routine.getErrorJSON("unsupported method"), 406

def getImage(request):
    base = ImageRepository()
    try:
        id = request.args.get('id')
        data = base.get_photo(id)
        response = make_response(data)
        response.headers.set('Content-Type', 'image/jpeg')
        response.headers.set(
            'Content-Disposition', 'attachment', filename='%s.jpg' % id)
        return response
    except Exception:
        return json_routine.getErrorJSON("internal server error"), 500


def changeImage(request):
    try:
        base = ImageRepository()
        id = request.form.get("image_id")
        image = request.files['image'].read()
        base.update_photo(id, image)
        return json_routine.getJSON({"status":"ok"}), 200
    except Exception:
        return json_routine.getErrorJSON("internal server error"), 500

