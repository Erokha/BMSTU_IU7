from shop.models import *

class SupplyProvider:
    code = str
    size = str

    def __init__(self, code, size):
        self.code = code
        self.size = size

    def supply(self, amount):
        response = {'status': 'error'}
        for model in CONMODELS:
            supplyModel = model.objects.filter(model__code__exact=self.code, size__exact=self.size).first()
            try:
                if supplyModel and int(supplyModel.amount) >= 0:
                    supplyModel.amount += int(amount)
                    supplyModel.save()
                    response["status"] = "ok"
                    return response
            except Exception as e:
                response["type"] = str(e)
                return response
        try:
            new_supply = Product.objects.filter(code__exact=self.code).first()
            model = Choices.class_by_type(new_supply.type)
            model(model=new_supply, amount=amount, size=self.size).save()
            response["status"] = "ok"
        except Exception as e:
            response["type"] = str(e)

        return response

    def sell(self, amount=1):
        response = {'status': 'error'}
        for model in CONMODELS:
            sellable = model.objects.filter(model__code__exact=self.code, size__exact=self.size).first()
            try:
                if sellable and int(sellable.amount) >= amount:
                    sellable.amount -= int(amount)
                    response["status"] = "ok"
                    sellable.save()
                    return response
            except Exception as e:
                response["type"] = str(e)
        return response