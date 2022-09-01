from typing import Any

from django.db import models
from django.contrib import admin
from django.core import serializers
from django.core.files.storage import FileSystemStorage

import hashlib
import uuid

fs = FileSystemStorage(location='/media/photos')


class Permission_levels:
    Assistant = "Assistant"
    Manager = "Manager"
    ShopOwner = "Shop owner"

    @staticmethod
    def types():
        return [(str(current_type), str(current_type)) for current_type in
                [Permission_levels.Assistant,
                 Permission_levels.Manager,
                 Permission_levels.ShopOwner]]


class Choices:
    HatType = "Hat"
    TshirtType = "T-shirt"
    PantsType = "Pants"
    ShoesType = "Shoes"

    @staticmethod
    def class_by_type(product_type):
        if product_type == Choices.HatType:
            return Hat
        elif product_type == Choices.TshirtType:
            return TShirt
        elif product_type == Choices.PantsType:
            return Pant
        elif product_type == Choices.ShoesType:
            return Shoe

    @staticmethod
    def types():
        return [(str(current_type), str(current_type)) for current_type in
                [Choices.HatType, Choices.TshirtType, Choices.PantsType, Choices.ShoesType]]

    @staticmethod
    def boots_sizes():
        return [(str(i), str(i)) for i in range(28, 43)]

    @staticmethod
    def clothes_sizes():
        return [(i, i) for i in "XS,S,M,L,XL".split(',')]


class Brand(models.Model):
    name = models.CharField(max_length=200, primary_key=True)

    def __str__(self):
        return f"{self.name}"


class Product(models.Model):
    name = models.CharField(max_length=200)
    price = models.PositiveIntegerField()
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='', null=True)
    type = models.TextField(
        max_length=15,
        choices=Choices.types(),
        default='T-shirt',
        name='type'
    )
    code = models.UUIDField(default=uuid.uuid4, primary_key=True, editable=False)

    @staticmethod
    def sell(code, size):
        response = {'status': 'error'}
        for model in CONMODELS:
            sellable = model.objects.filter(model__code__exact=code, size__exact=size).first()
            try:
                if sellable and int(sellable.size) > 0:
                    sellable.amount -= 1
                    response["status"] = "ok"
                    return response
            except Exception as e:
                response["type"] = str(e)
        return response

    @property
    def sizes(self):
        objects = []
        for model in CONMODELS:
            sizes = list(model.objects.filter(model__code__exact=self.code).all())
            if len(sizes) > 0:
                [objects.append(size) for size in sizes]
        return [{'size': model.size, 'amount': model.amount} for model in objects]

    def get_base_name(self):
        return f"{self.brand} {self.name} [art. {self.code}]"

    def serialize(self):
        return serializers.serialize("python", [self])[0]['fields']

    def __str__(self):
        return f"[{self.type}] {self.brand} {self.name} [art. {self.code}]"


class Hat(models.Model):
    model = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        limit_choices_to={Product.type.field.name: Choices.HatType}
    )
    amount = models.PositiveIntegerField()
    size = models.TextField(
        max_length=2,
        choices=Choices.clothes_sizes(),
        default="M",
    )

    def __str__(self):
        return f"[{self.size}] {self.model.get_base_name()}"


class TShirt(models.Model):
    model = models.ForeignKey(Product,
                              on_delete=models.CASCADE,
                              limit_choices_to={Product.type.field.name: Choices.TshirtType})
    amount = models.PositiveIntegerField()
    size = models.TextField(
        max_length=2,
        choices=Choices.clothes_sizes(),
        default='M',
    )

    def __str__(self):
        return f"[{self.size}] {self.model.get_base_name()}"


class Pant(models.Model):
    model = models.ForeignKey(Product,
                              on_delete=models.CASCADE,
                              limit_choices_to={Product.type.field.name: Choices.PantsType})
    amount = models.PositiveIntegerField()
    size = models.TextField(
        max_length=2,
        choices=Choices.clothes_sizes(),
        default='M',
    )

    def __str__(self):
        return f"[{self.size}] {self.model.get_base_name()}"


class Shoe(models.Model):
    model = models.ForeignKey(Product,
                              on_delete=models.CASCADE,
                              limit_choices_to={Product.type.field.name: Choices.ShoesType})
    amount = models.PositiveIntegerField()
    size = models.TextField(max_length=2,
                            choices=Choices.boots_sizes(),
                            default=36,
                            )

    def __str__(self):
        return f"[{self.size} EU] {self.model.get_base_name()}"


class BrandUser(models.Model):
    system_name = models.TextField(primary_key=True)
    displayed_name = models.TextField()
    password = models.TextField()
    position = models.TextField(null=True)
    permission = models.TextField(
        choices=Permission_levels.types(),
        default=Permission_levels.Assistant
    )
    image = models.ImageField(upload_to='', null=True, blank=True)

    # def save(self, force_insert=False, force_update=False, using=None, update_fields=None):
    #     if update_fields and "password" in update_fields:
    #         temp_password = hashlib.md5(self.password.encode()).hexdigest()
    #         self.password = temp_password
    #     super().save(force_insert, force_update, using, update_fields)

    def __str__(self):
        return f"[{self.position}] {self.displayed_name}"


class BrandUserAdmin(admin.ModelAdmin):

    def save_model(self, request, obj, form, change):
        if form.changed_data and 'password' in form.changed_data:
            temp_password = hashlib.md5(obj.password.encode()).hexdigest()
            obj.password = temp_password
        obj.save()


# def save_model(self, request, obj, form, change):
    #     obj.save(update_fields=form.changed_data)


# All avaliable concrate models
CONMODELS = [Hat, TShirt, Pant, Shoe]
