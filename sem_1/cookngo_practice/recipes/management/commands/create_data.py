from django.core.management.base import BaseCommand
from faker import  Faker
from recipes.models import Recipe, Category, Kitchen, Menu
import random
import datetime

faker = Faker('ru_RU')


def generate_title():
    return faker.sentence(nb_words = 3)



def generate_description():
    return (faker.text(max_nb_chars = 500, ext_word_list = None))

def generate_category():

    list_of_cats = [
        'Мясо',
        'Рыба',
        'Салаты',
        'Десерты',
        'Супы',
        'Напитки',
        'Закуски'
    ]
    index = random.randint(0,6)
    return list_of_cats[index]

def generate_kitchen():

    list_of_kithcens = [
        'Азиатская кухня',
        'Грузинская кухня',
        'Американская кухня',
        'Русская кухня',
        'Италянская кухня',
    ]
    index = random.randint(0,4)
    return list_of_kithcens[index]

def generate_menu():

    list_of_menues = [
        'Детская еда',
        'Низкокалорийная еда',
        'Веганская еда',
        'Правильное питание',
        'Обычное меню'
    ]
    index = random.randint(0,4)
    return list_of_menues[index]

def generate_date():
    year = random.randint(2010,2019)
    month = random.randint(1,12)
    day = random.randint(1,30)
    return datetime.date(year, month, day)

class Command(BaseCommand):

    def handle(self, *args, **options):

        for i in range(100):
            title_name = generate_title()
            description_name = generate_description()
            category_name = generate_category()
            kitchen_name = generate_kitchen()
            menu_name = generate_menu()
            my_date = generate_date()

            Category.objects.get_or_create(title = category_name)
            Kitchen.objects.get_or_create(title = kitchen_name)
            Menu.objects.get_or_create(title = menu_name)

            recipe = Recipe (
                title = title_name,
                description = description_name,
                category = Category.objects.get(title=category_name),
                kitchen= Kitchen.objects.get(title=kitchen_name),
                menu= Menu.objects.get(title = menu_name),
                date = my_date
            )

            recipe.save()
        self.stdout.write(self.style.SUCCESS('Data imported successfully'))
