from django.http import JsonResponse
from rest_framework.request import Request
from shop.Providers.AuthProvider import AuthProvider


class AuthHandler:
    request = Request
    provider = AuthProvider
    supported_methods = ["POST"]
    def __init__(self, request):
        self.request = request

    def handleRequest(self):
        response = self.unsupported_methods()
        if self.request.method == "POST":
            response = self.__handle_post_request()
        return JsonResponse(response, safe=False)


    def __handle_post_request(self):
        action_type = self.request.POST.get(key="type", default=None)
        username = self.request.POST.get(key="username", default=None)
        password = self.request.POST.get(key="password", default=None)
        response = {"status": "error", "type": "no such type"}
        if action_type == "validate":
            response = self.provider.validateUser(username, password)
        elif action_type == "register_user":
            response = self.provider.saveUser(self.request.data)
        elif action_type == "detail_info":
            response = self.provider.detailInfo(username)
        return response


    def unsupported_methods(self):
        supported_methods = "Unsupported method. Supported types:"
        for method in self.supported_methods:
            supported_methods += " " + method
        return {"type": "error", "type": supported_methods}