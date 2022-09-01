from flask import Blueprint
from flask_swagger_ui import get_swaggerui_blueprint
from config import ip

import json_routine as js

SWAGGER_URL = '/api/docs'
API_URL = 'https://unidressproject.xyz/pureswagger'

swaggerui_blueprint = get_swaggerui_blueprint(
    SWAGGER_URL,  # Swagger UI templates files will be mapped to '{SWAGGER_URL}/dist/'
    API_URL,
    config={  # Swagger UI config overrides
        'app_name': "Unidress application"
    }
)
swagger_internal_router = Blueprint('swagger_internal_router', __name__)


@swagger_internal_router.route('/pureswagger')
def get_swagger_json():
    return js.getJSON(
        {
            "swagger": "2.0",
            "info": {
                "description": "This is a unidress backend server.  You can find out more about Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).  For this sample, you can use the api key `special-key` to test the authorization filters.",
                "version": "1.0.6",
                "title": "Unidress",
                "termsOfService": "http://swagger.io/terms/",
                "license": {
                    "name": "Apache 2.0",
                    "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
                }
            },
            "host": "unidressproject.xyz",
            "basePath": "/api/v1",
            "tags": [
                {
                    "name": "auth",
                    "description": "Everything containing auth",
                },
                {
                    "name": "image",
                    "description": "Access to images"
                },
                {
                    "name": "item",
                    "description": "Operations with clothtes"
                },
            ],
            "schemes": [
                "https",
                "http"
            ],
            "paths": {
                "/auth/login": {
                    "post": {
                        "tags": [
                            "auth"
                        ],
                        "summary": "perform login",
                        "description": "",
                        "operationId": "uploadFile",
                        "produces": [
                            "application/json"
                        ],
                        "parameters": [
                            {
                                "name": "login",
                                "in": "formData",
                                "description": "user login",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "password",
                                "in": "formData",
                                "description": "user password",
                                "required": True,
                                "type": "string"
                            }
                        ],
                        "responses": {
                            "200": {
                                "description": "successful operation",
                                "schema": {
                                    "$ref": "#/definitions/auth_login_response"
                                }
                            },
                            "500": {
                                "description": "operation error",
                                "schema": {
                                    "$ref": "#/definitions/error_response"
                                }
                            },
                        },
                    }
                },
                "/auth/register": {
                    "post": {
                        "tags": [
                            "auth"
                        ],
                        "summary": "perform login",
                        "description": "",
                        "operationId": "uploadFile",
                        "produces": [
                            "application/json"
                        ],
                        "parameters": [
                            {
                                "name": "login",
                                "in": "formData",
                                "description": "user login",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "password",
                                "in": "formData",
                                "description": "user password",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "username",
                                "in": "formData",
                                "description": "user nickname",
                                "required": True,
                                "type": "string"
                            }
                        ],
                        "responses": {
                            "200": {
                                "description": "successful operation",
                                "schema": {
                                    "$ref": "#/definitions/auth_login_response"
                                }
                            },
                            "500": {
                                "description": "operation error",
                                "schema": {
                                    "$ref": "#/definitions/error_response"
                                }
                            },
                        },
                    }
                },
                "/image?{id}": {
                    "get": {
                        "tags": [
                            "image"
                        ],
                        "summary": "get image item info",
                        "description": "",
                        "operationId": "uploadFile",
                        "produces": [
                            "application/json"
                        ],
                        "parameters": [
                            {
                                "name": "image_id",
                                "in": "formData",
                                "description": "image id",
                                "required": True,
                                "type": "integer"
                            }
                        ],
                        "responses": {
                            "200": {
                                "description": "successful operation",
                                "schema": {}
                            },
                            "500": {
                                "description": "operation error",
                                "schema": {
                                    "$ref": "#/definitions/error_response"
                                }
                            },
                        },
                    }
                },
                "/image": {
                    "put": {
                        "tags": [
                            "image"
                        ],
                        "summary": "update image info",
                        "description": "",
                        "operationId": "uploadFile",
                        "produces": [
                            "application/json"
                        ],
                        "parameters": [
                            {
                                "name": "image_id",
                                "in": "formData",
                                "description": "image id",
                                "required": True,
                                "type": "integer"
                            },
                            {
                                "name": "image",
                                "in": "files",
                                "required": False,
                                "type": "file"
                            }
                        ],
                        "responses": {
                            "200": {
                                "description": "successful operation",
                                "schema": {
                                    "$ref": "#/definitions/success_response"
                                }
                            },
                            "500": {
                                "description": "operation error",
                                "schema": {
                                    "$ref": "#/definitions/error_response"
                                }
                            },
                        },
                    }
                },
                "/items": {
                    "post": {
                        "tags": [
                            "item"
                        ],
                        "summary": "add new item",
                        "description": "",
                        "operationId": "uploadFile",
                        "produces": [
                            "application/json"
                        ],
                        "parameters": [
                            {
                                "name": "name",
                                "in": "formData",
                                "description": "item name",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "login",
                                "in": "formData",
                                "description": "login",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "item_type",
                                "in": "formData",
                                "description": "item type",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "image",
                                "in": "files",
                                "required": False,
                                "type": "file"
                            }
                        ],
                        "responses": {
                            "200": {
                                "description": "successful operation",
                                "schema": {
                                    "$ref": "#/definitions/add_item_response"
                                }
                            },
                            "500": {
                                "description": "operation error",
                                "schema": {
                                    "$ref": "#/definitions/error_response"
                                }
                            },
                        },
                    }
                },
                "/items/:id": {
                    "get": {
                        "tags": [
                            "item"
                        ],
                        "summary": "get item detail info",
                        "description": "",
                        "operationId": "uploadFile",
                        "produces": [
                            "application/json"
                        ],
                        "parameters": [
                            {
                                "name": "login",
                                "in": "header",
                                "description": "user login",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "password",
                                "in": "header",
                                "description": "password",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "item_id",
                                "in": "formData",
                                "description": "id of item",
                                "required": False,
                                "type": "integer"
                            },
                        ],
                        "responses": {
                            "200": {
                                "description": "successful operation",
                                "schema": {
                                    "$ref": "#/definitions/item_info"
                                }
                            },
                            "500": {
                                "description": "operation error",
                                "schema": {
                                    "$ref": "#/definitions/error_response"
                                }
                            },
                        },
                    },
                    "delete": {
                        "tags": [
                            "item"
                        ],
                        "summary": "delete item",
                        "description": "",
                        "operationId": "uploadFile",
                        "produces": [
                            "application/json"
                        ],
                        "parameters": [
                            {
                                "name": "login",
                                "in": "header",
                                "description": "user login",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "password",
                                "in": "header",
                                "description": "user password",
                                "required": True,
                                "type": "string"
                            },
                        ],
                        "responses": {
                            "200": {
                                "description": "successful operation",
                                "schema": {
                                    "$ref": "#/definitions/success_response"
                                }
                            },
                            "500": {
                                "description": "operation error",
                                "schema": {
                                    "$ref": "#/definitions/error_response"
                                }
                            },
                        },
                    },
                    "put": {
                        "tags": [
                            "item"
                        ],
                        "summary": "update item info",
                        "description": "",
                        "operationId": "uploadFile",
                        "produces": [
                            "application/json"
                        ],
                        "parameters": [
                            {
                                "name": "login",
                                "in": "formData",
                                "description": "user login",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "item_id",
                                "in": "formData",
                                "description": "item id",
                                "required": True,
                                "type": "string"
                            },
                            {
                                "name": "new_name",
                                "in": "formData",
                                "description": "new item name",
                                "required": False,
                                "type": "string"
                            },
                            {
                                "name": "new_image",
                                "in": "formData",
                                "description": "new item image",
                                "required": False,
                                "type": "file"
                            },
                        ],
                        "responses": {
                            "200": {
                                "description": "successful operation",
                                "schema": {
                                    "$ref": "#/definitions/item_info"
                                }
                            },
                            "500": {
                                "description": "operation error",
                                "schema": {
                                    "$ref": "#/definitions/error_response"
                                }
                            },
                        },
                    },
                },
            },
            "securityDefinitions": {
                "api_key": {
                    "type": "apiKey",
                    "name": "api_key",
                    "in": "header"
                },
                "petstore_auth": {
                    "type": "oauth2",
                    "authorizationUrl": "https://petstore.swagger.io/oauth/authorize",
                    "flow": "implicit",
                    "scopes": {
                        "read:pets": "read your pets",
                        "write:pets": "modify pets in your account"
                    }
                }
            },
            "definitions": {
                "all_items": {
                    "type": "object",
                    "properties": {
                        "clothes": {
                            "type": "array",
                            "items": {
                                "type": "object",
                                "properties": {
                                    "type": {
                                        "type": "string"
                                    },
                                    "items": {
                                        "type": "object",
                                        "properties": {
                                            "clothes_id": {
                                                "type": "integer",
                                                "format": "int32"
                                            },
                                            "clothes_name": {
                                                "type": "string"
                                            },
                                            "type": {
                                                "type": "string"
                                            },
                                            "image_url": {
                                                "type": "string"
                                            },
                                            "owner_login": {
                                                "type": "string"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                "error_response": {
                    "type": "object",
                    "properties": {
                        "status": {
                            "type": "string",
                        },
                        "reason": {
                            "type": "string"
                        },
                    }
                },
                "success_response": {
                    "type": "object",
                    "properties": {
                        "status": {
                            "type": "string",
                        }
                    }
                },
                "auth_login_response": {
                    "type": "object",
                    "properties": {
                        "user_name": {
                            "type": "integer",
                            "format": "int32"
                        },
                        "image_id": {
                            "type": "string"
                        },
                        "image_url": {
                            "type": "string"
                        },
                        "user_login": {
                            "type": "string"
                        }
                    }
                },
                "item_info": {
                    "type": "object",
                    "properties": {
                        "clothes_id": {
                            "type": "integer",
                            "format": "int32"
                        },
                        "clothes_name": {
                            "type": "string"
                        },
                        "type": {
                            "type": "string"
                        },
                        "image_url": {
                            "type": "string"
                        },
                        "owner_login": {
                            "type": "string"
                        }
                    }
                },
                "add_item_response": {
                    "type": "object",
                    "properties": {
                        "item_id": {
                            "type": "integer",
                            "format": "int32"
                        }
                    }
                },
            },
            "externalDocs": {
                "description": "Find out more about Swagger",
                "url": "http://swagger.io"
            }
        }
    )
