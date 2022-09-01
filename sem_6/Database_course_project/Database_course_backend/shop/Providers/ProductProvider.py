from shop.models import *
from shop.Serializers import ProductSerializer
from django.db.models import Q


class ProductProvider:
    @staticmethod
    def register_product(data):
        serializer = ProductSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return {"status": "ok"}
        return {"status": "error"}

    @staticmethod
    def product_by_code(code):
        product = Product.objects.filter(code__iexact=code).first()
        return ProductSerializer(product).data

    @staticmethod
    def quick_search(search):
        search_code = None
        try:
            search_code = uuid.UUID(search)
        except:
            pass
        objects = Product.objects.filter(
            Q(code__iexact=search_code) |
            Q(name__icontains=search) |
            Q(brand__name__icontains=search)
        ).all()
        response = []
        for i in range(len(objects)):
            response.append(ProductSerializer(objects[i]).data)
        return response

    @staticmethod
    def provided_sizes(code):
        result = {"provided_sizes": []}
        try:
            product = Product.objects.filter(code__exact=code).first()
            if product:
                if product.type == Choices.ShoesType:
                    result["provided_sizes"] = [i[0] for i in Choices.boots_sizes()]
                else:
                    result["provided_sizes"] = [i[0] for i in Choices.clothes_sizes()]
        except Exception as e:
            print(e)
        return result
