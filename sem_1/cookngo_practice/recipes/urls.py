from . import  views
from django.contrib import admin
from django.urls import path

from .views import login,logout,registration,Add_view,post_update, post_delete, userpage


admin.autodiscover()

urlpatterns = [
    path('', views.Index.as_view(), name ="home"),
    path('info/<int:id>', views.post_detail, name = 'detail'),
    path('accounts/login/', login, name = 'login'),
    path('accounts/logout', logout, name = 'logout'),
    path('accounts/registration/', registration),
    path('add/', Add_view.as_view(), name = 'create'),
    path('userpage/<int:pageid>', userpage, name = 'lk'),
    path('<int:id>/edit', post_update, name = 'edit'),
    path('delete/<int:id>', post_delete, name = 'delete'),
]
