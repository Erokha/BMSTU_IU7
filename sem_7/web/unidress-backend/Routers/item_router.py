from flask import Blueprint
from flask import request

import json_routine
from Repositories.ImageRepository import ImageRepository
from Repositories.ItemRepository import ItemRepository
from Routers.decorators import validate_api_key
from Services.item_service import ItemService
from Services.access_manager import AccessManager, make_access_manager

item_router = Blueprint('item_service', __name__,url_prefix='/api/v1')
item_service = ItemService(ItemRepository(), ImageRepository())
access_manager = make_access_manager()


@item_router.route('/items', methods=['GET', 'POST'])
def items():
    method = request.method
    if method == 'GET':
        return getAllItems(request)
    else:
        return add_item(request)


@item_router.route('/items/<int:item_id>', methods=['DELETE', 'PUT', 'GET'])
def coordinate(item_id):
    method = request.method
    if method == 'GET':
        return get_item_by_id(request, item_id)
    elif method == 'PUT':
        return update_item(request, item_id)
    elif method == 'DELETE':
        return remove_item(request, item_id)
    else:
        return json_routine.getErrorJSON("unsupported method"), 406


def get_item_by_id(request, item_id):
    try:
        login = request.headers.get('login')
        password = request.headers.get('password')
        if access_manager.check_user_auth(login, password):
            return item_service.get_item_by_id(item_id)
        else:
            return json_routine.getJSON({"status": "error", "reason": "no access for this clothe"}), 403
    except Exception as e:
        print(f'/getItemById: {e}')
        return None, 500



def remove_item(request, item_id):
    try:
        login = request.headers.get('login')
        password = request.headers.get('password')
        if access_manager.check_user_auth(login, password):
            return item_service.remove_item(item_id)
        else:
            return json_routine.getErrorJSON("user not authenticated"), 403
    except Exception as e:
        print(f'/removeItem: {e}')
        return None, 500



def add_item(request):
    try:
        item_name = request.form.get("name")
        item_type = request.form.get("type")
        try:
            file = request.files['image'].read()
        except Exception:
            file = None
        login = request.headers.get('login')
        password = request.headers.get('password')
        if access_manager.check_user_auth(login, password):
            return item_service.add_item(item_name, login, item_type, file)
        else:
            return json_routine.getErrorJSON("user not authenticated"), 403
    except Exception as e:
        print(f'/addItem: {e}')
        return json_routine.getErrorJSON("internal server error"), 500


def update_item(request, item_id):
    try:
        login = request.headers.get('login')
        password = request.headers.get('password')
        new_name = request.form.get("new_name")
        file = request.files['file'].read()
        if access_manager.check_user_auth(login, password):
            return item_service.update_item(item_id, new_name, file)
        else:
            return json_routine.getErrorJSON("user not authenticated"), 403
    except Exception as e:
        print(f'/updateItem: {e}')
        return None, 500

def getAllItems(request):
    base = ItemRepository()
    try:
        login = request.headers.get('login')
        password = request.headers.get('password')
        if access_manager.check_user_auth(login, password):
            return base.get_all_items_by_user(login)
        else:
            return json_routine.getErrorJSON("user not authenticated"), 403
    except Exception:
        print("Error occured")
        return json_routine.getJSON({"status": "error", "reason": "internal server error"}), 500
