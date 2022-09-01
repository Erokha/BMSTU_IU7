from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view

from .Handlers.AuthHandler import AuthHandler
from .Handlers.ProductHandler import ProductHandler
from .Handlers.SupplyHandler import SupplyHandler




def testpage(request):
    return HttpResponse("True")


@csrf_exempt
@api_view(['GET', 'POST'])
def product_handler(request):
    handler = ProductHandler(request)
    return handler.handleRequest()


@csrf_exempt
@api_view(['GET', 'POST'])
def supply_handler(request):
    handler = SupplyHandler(request)
    return handler.handleRequest()

@csrf_exempt
@api_view(['GET', 'POST'])
def auth_handler(request):
    handler = AuthHandler(request)
    return handler.handleRequest()






