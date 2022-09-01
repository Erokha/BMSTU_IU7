from shop.models import *
from shop.Serializers import UserSerializer
from django.db.models import Q


class AuthProvider:
    @staticmethod
    def saveUser(data):
        serializer = UserSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return {"status": "ok"}
        return {"status": "error"}

    @staticmethod
    def detailInfo(systemName):
        user = BrandUser.objects.filter(
            system_name=systemName).first()
        if user:
            serialized_data = UserSerializer(user).data
            return {"status": "ok", "info": serialized_data}
        return {"status": "error"}

    @staticmethod
    def validateUser(username, password):
        hashed_password = hashlib.md5(password.encode()).hexdigest()
        user = BrandUser.objects.filter(
            system_name=username,
            password__exact=hashed_password).first()
        if user:
            return {"status": "ok", "token": username}
        return {"status": "error"}

