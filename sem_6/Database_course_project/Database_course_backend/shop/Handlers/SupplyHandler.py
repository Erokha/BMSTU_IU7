from rest_framework.request import Request
from django.http import JsonResponse

from shop.Providers.SupplyProvider import SupplyProvider


class SupplyHandler:
    request = Request
    supported_methods = ["POST"]
    def __init__(self, request):
        self.request = request

    def handleRequest(self):
        response = self.unsupported_methods()
        if self.request.method == "POST":
            response = self.__handle_post_request()
        return JsonResponse(response, safe=False)

    def __handle_post_request(self):
        operation_type = self.request.POST.get(key="type", default=None)
        code = self.request.POST.get(key="code", default=None)
        size = self.request.POST.get(key="size", default=None)
        amount = self.request.POST.get(key="amount", default=None)
        provider = SupplyProvider(code=code, size=size)
        response = {"status": "error", "type": "No such type"}
        if operation_type == "sell_item":
            response = provider.sell()
        elif operation_type == "supply_item":
            response = provider.supply(amount)
        return response

    def unsupported_methods(self):
        supported_methods = "Unsupported method. Supported types:"
        for method in self.supported_methods:
            supported_methods += " " + method
        return {"type": "error", "type": supported_methods}
