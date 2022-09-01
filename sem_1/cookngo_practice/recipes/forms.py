from django import forms
from .models import Recipe
# -*- coding:utf-8 -*-





class Add_recipe_form(forms.ModelForm):

    class Meta:
        model = Recipe
        fields = [
            'title',
            'description',
            'image',
            'diff',
            'kitchen',
            'category',
            'menu',
            'time',
            'cal',
        ]

        labels = {
            'title': 'Название рецепта:',
            'description': 'Описание рецепта:',
            'image': 'Фотография рецепта:',
            'diff': 'Сложность рецепта:',
            'kitchen': 'Кухня:',
            'category': 'Категория блюда:',
            'menu': 'Меню:',
            'time': 'Время приготовления',
            'cal': 'Калорийность',
        }



