from django.contrib import admin as adm
from django.urls import path
from .views import *

adm.autodiscover()

urlpatterns = [
    path('', testpage),
    path('products', product_handler),
    path('supply', supply_handler),
    path('auth', auth_handler)
]