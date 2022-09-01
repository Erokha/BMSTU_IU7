from flask import Blueprint
from flask import request

import json_routine
from Repositories.ImageRepository import ImageRepository
from Repositories.UserRepository import UserRepository
from Routers.decorators import validate_api_key
from Services.user_service import UserService

auth_service = Blueprint('auth_service', __name__, url_prefix='/api/v1/auth')
user_service = UserService(UserRepository(), ImageRepository())


@auth_service.route('/login', methods=['POST'])
def login():
    try:
        login = request.form.get('login')
        password = request.form.get("password")
    except Exception:
        return json_routine.getJSON({"status": "error", "reason": "internal server error"}), 500
    return user_service.login(login, password)


@auth_service.route('/changeAvatar', methods=['POST'])
def change_avatar():
    try:
        login = request.form.get('login')
    except Exception:
        return 405
    login = request.form.get('login')
    image = request.files['file'].read()
    return user_service.change_avatar(login, image)


@auth_service.route('/changeName', methods=['POST'])
def change_name():
    try:
        login = request.form.get('login')
        name = request.form.get('new_name')
    except Exception:
        return 405
    return user_service.change_name(login, name)


@auth_service.route('/changePassword', methods=['POST'])
def change_password():
    try:
        login = request.form.get('login')
        password = request.form.get('new_password')
    except Exception:
        return 405
    try:
        base = UserRepository()
        if base.is_key_valid(request.form.get('apikey')):
            result = base.change_password(login, password)
            respcode = 200 if result else 404
            return result, respcode
        else:
            return 'Key unvalid', 500
    except Exception:
        return "Error", 500


@auth_service.route('/changeLoginTimeBomb', methods=['POST'])
def change_login():
    try:
        last_login = request.form.get('last_login')
        new_login = request.form.get('new_login')
    except Exception:
        return 405
    return user_service.change_login(last_login, new_login)


@auth_service.route('/register', methods=['POST'])
def register():
    try:
        login = request.form.get('login')
        username = request.form.get("username")
        password = request.form.get("password")
    except Exception:
        return 405
    try:
        image = request.files['file'].read()
    except Exception:
        image = None
    finally:
        response = user_service.register(login, username, password, image)
        return response
