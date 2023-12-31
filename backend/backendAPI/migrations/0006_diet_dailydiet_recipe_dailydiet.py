# Generated by Django 4.1 on 2022-08-09 19:23

import django.core.validators
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('backendAPI', '0005_recipe'),
    ]

    operations = [
        migrations.CreateModel(
            name='Diet',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(blank=True, null=True, upload_to='diets/')),
                ('name', models.CharField(default='', max_length=255)),
                ('description', models.TextField(blank=True, default='')),
                ('numberOfDays', models.PositiveIntegerField(default=0, validators=[django.core.validators.MinValueValidator(0)])),
            ],
            options={
                'ordering': ['name'],
            },
        ),
        migrations.CreateModel(
            name='DailyDiet',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(default='', max_length=255)),
                ('numberOfMeals', models.PositiveIntegerField(default=0, validators=[django.core.validators.MinValueValidator(0)])),
                ('mainDiet', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='dailyDiets', to='backendAPI.diet')),
            ],
            options={
                'ordering': ['name'],
            },
        ),
        migrations.AddField(
            model_name='recipe',
            name='dailyDiet',
            field=models.ManyToManyField(blank=True, related_name='recipes', to='backendAPI.dailydiet'),
        ),
    ]
