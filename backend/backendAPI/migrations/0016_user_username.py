# Generated by Django 4.1 on 2022-08-11 00:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backendAPI', '0015_user_email_user_password'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='username',
            field=models.CharField(default='username', max_length=255),
        ),
    ]
