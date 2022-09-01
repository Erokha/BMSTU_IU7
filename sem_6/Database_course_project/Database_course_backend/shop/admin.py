from django.contrib import admin
from django.utils.translation import ugettext_lazy
from .models import *

#Register
admin.register(Product)
admin.register(Brand)
admin.register(Shoe)
admin.register(Hat)
admin.register(TShirt)
admin.register(Pant)
admin.register(BrandUser)


#Site register
admin.site.register(Product)
admin.site.register(Brand)
admin.site.register(Shoe)
admin.site.register(Hat)
admin.site.register(TShirt)
admin.site.register(Pant)
admin.site.register(BrandUser, BrandUserAdmin)


