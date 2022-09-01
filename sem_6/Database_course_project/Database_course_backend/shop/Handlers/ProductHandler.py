from django.http import JsonResponse
from rest_framework.request import Request
from shop.Providers.ProductProvider import ProductProvider


class ProductHandler:
    request = Request
    provider = ProductProvider
    supported_methods = ["GET", "POST"]
    def __init__(self, request):
        self.request = request

    def handleRequest(self):
        response = self.unsupported_methods()
        if self.request.method == "GET":
            response = self.__handle_get_request()
        elif self.request.method == "POST":
            response = self.__handle_post_request()
        return JsonResponse(response, safe=False)

    def __handle_get_request(self):
        code = self.request.GET.get(key="code", default=None)
        search = self.request.GET.get(key="search", default=None)
        provided_sizes_code = self.request.GET.get(key="provided_sizes", default=None)
        response = {"status": "error", "type": "no such method"}
        if code:
            response = self.provider.product_by_code(code)
        elif search is not None:
            response = self.provider.quick_search(search)
        elif provided_sizes_code:
            response = self.provider.provided_sizes(provided_sizes_code)
        return response

    def __handle_post_request(self):
        response = self.provider.register_product(self.request.data)
        return response


    def unsupported_methods(self):
        supported_methods = "Unsupported method. Supported types:"
        for method in self.supported_methods:
            supported_methods += " " + method
        return {"type": "error", "type": supported_methods}