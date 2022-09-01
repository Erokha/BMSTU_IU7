from rest_framework import serializers
import shop.models as models


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.BrandUser
        fields = '__all__'


class ProductSerializer(serializers.ModelSerializer):
    sizes = serializers.ReadOnlyField()

    class Meta:
        model = models.Product
        fields = '__all__'


class InstanceSerializerFabric:
    @staticmethod
    def getSerializer(baseModel):
        class SomeSerializer(serializers.ModelSerializer):
            class Meta:
                model = baseModel
                fields = "__all__"

            def to_representation(self, obj):
                return {
                    "size": obj.size,
                    "amount": obj.amount,
                    "model": ProductSerializer(obj.model).data
                }

        return SomeSerializer

    @staticmethod
    def serialeQuerySet(querySet):
        response = []
        if len(querySet):
            instanceSerializer = InstanceSerializerFabric.getSerializer(querySet.first())
            for instance in querySet:
                serializer = instanceSerializer(instance)
                serializedobject = serializer.data
                try:
                    response.append(dict(serializer.data))
                except Exception as error:
                    print("error: " + serializedobject + "could not be converted to JSON")
                    print("Error code: " + error)
        return response
