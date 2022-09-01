from django.db import models
from django.conf import settings
from django.contrib.auth.models import User

# Create your models here.
class Category(models.Model):
    title = models.CharField(max_length = 255 )
    def __str__(self):
        return self.title

class Kitchen(models.Model):
    title = models.CharField(max_length = 255)
    def __str__(self):
        return self.title

class Menu(models.Model):
    title = models.CharField(max_length = 255)
    def __str__(self):
        return self.title

class Recipe(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, default=1, null=True,
                            on_delete=models.SET_NULL)
    title = models.CharField(max_length = 255,help_text ='Название рецепта:')
    description = models.TextField(help_text= 'Описание рецепта')
    date = models.DateTimeField(auto_now_add=True)
    image = models.ImageField(blank = True, upload_to='recipes_img/')
    category = models.ForeignKey(Category, null = True, blank= True,
                                 on_delete=models.SET_NULL)
    kitchen = models.ForeignKey(Kitchen, null = True, blank= True,
                                on_delete=models.SET_NULL)
    menu = models.ForeignKey(Menu, null = True, blank = True,
                             on_delete = models.SET_NULL)

    time = models.IntegerField(null=True, blank=True)
    cal = models.IntegerField(null=True, blank=True)
    views = models.PositiveIntegerField(default = 0)

    DIFFICULTY = (
        (1, '1'),
        (2, '2'),
        (3, '3'),
    )
    diff = models.IntegerField(choices=DIFFICULTY, null=True)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return '/info/%s' %(self.id)
