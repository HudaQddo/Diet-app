# Generated by Django 4.1 on 2022-08-10 11:16

import django.core.validators
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('backendAPI', '0010_user_exercises'),
    ]

    operations = [
        migrations.CreateModel(
            name='Favorite',
            fields=[
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='favorite', serialize=False, to='backendAPI.user')),
                ('userRecipes', models.IntegerField(default=0, validators=[django.core.validators.MinValueValidator(0)])),
                ('recipes', models.ManyToManyField(blank=True, related_name='favorites', to='backendAPI.recipe')),
            ],
        ),
        migrations.CreateModel(
            name='FavoriteRecipe',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('favorite', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='backendAPI.favorite')),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='backendAPI.recipe')),
            ],
        ),
    ]
