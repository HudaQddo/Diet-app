# Generated by Django 4.1 on 2022-08-09 16:07

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backendAPI', '0004_subcategory_image'),
    ]

    operations = [
        migrations.CreateModel(
            name='Recipe',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(blank=True, null=True, upload_to='Recipes/')),
                ('name', models.CharField(max_length=255)),
                ('serving', models.PositiveIntegerField(default=1, validators=[django.core.validators.MinValueValidator(0)])),
                ('description', models.TextField(blank=True, null=True)),
                ('ingredients', models.TextField(blank=True, null=True)),
                ('steps', models.TextField()),
                ('calories', models.IntegerField(default=0, validators=[django.core.validators.MinValueValidator(0)])),
                ('fat', models.FloatField(default=0, validators=[django.core.validators.MinValueValidator(0)])),
                ('protein', models.FloatField(default=0, validators=[django.core.validators.MinValueValidator(0)])),
                ('carbs', models.FloatField(default=0, validators=[django.core.validators.MinValueValidator(0)])),
                ('rating', models.FloatField(default=0, validators=[django.core.validators.MinValueValidator(0)])),
                ('subCategory', models.ManyToManyField(related_name='recipes', to='backendAPI.subcategory')),
            ],
            options={
                'ordering': ['name'],
            },
        ),
    ]