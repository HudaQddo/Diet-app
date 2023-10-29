# Generated by Django 4.1 on 2022-08-10 07:47

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('backendAPI', '0008_exercise'),
    ]

    operations = [
        migrations.CreateModel(
            name='Water',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('numberOfCup', models.PositiveIntegerField()),
                ('sizeOfCup', models.FloatField()),
                ('literIsDrink', models.FloatField(null=True)),
                ('numberOfLiter', models.FloatField()),
            ],
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(blank=True, null=True, upload_to='BMI/')),
                ('birthDate', models.DateTimeField(null=True)),
                ('height', models.PositiveIntegerField()),
                ('createTime', models.DateTimeField(auto_now_add=True, null=True)),
                ('startWeight', models.FloatField()),
                ('currentWeight', models.FloatField()),
                ('gender', models.CharField(choices=[('M', 'Male'), ('F', 'Female')], default='M', max_length=1)),
                ('goalWeight', models.FloatField(null=True)),
                ('BMI', models.FloatField(default=21.7)),
                ('changeRate', models.FloatField(default=0.0)),
                ('dietTarget', models.CharField(choices=[('Loss', 'Weight Loss'), ('Gain', 'Weight Gain'), ('Keep Fit', 'Keep Fit')], default='Loss', max_length=20)),
                ('dietType', models.CharField(choices=[('CLASSIC', 'Classic'), ('KETO', 'Keto'), ('FLEX', 'Flexitarian'), ('PALEO', 'Paleo'), ('VEGAN', 'Vegan'), ('PESCET', 'Pescetarian'), ('VEGETERIAN', 'Vegetarain')], default='CLASSIC', max_length=10)),
                ('activityRate', models.CharField(choices=[('LITTLE', 'Little or No Activity'), ('LIGHT', 'Lightly Active'), ('MODEREATE', 'Moderately Active'), ('VERY', 'Very Active')], default='MODEREATE', max_length=10)),
                ('ilnesses', models.CharField(choices=[('NO', 'None'), ('DI', 'Diabates'), ('CH', 'Cholesterol'), ('HY', 'Hypertension'), ('PC', 'PCOS'), ('TH', 'Thyroid'), ('PH', 'Physical Injuries')], default='NO', max_length=20)),
                ('challenges', models.ManyToManyField(blank=True, related_name='users', to='backendAPI.challenge')),
                ('diet', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='users', to='backendAPI.diet')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Dairy',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('totalCalories', models.FloatField(blank=True, null=True)),
                ('eatenCalories', models.FloatField(blank=True, null=True)),
                ('burnetCalories', models.FloatField(blank=True, null=True)),
                ('breakfast', models.ManyToManyField(blank=True, null=True, related_name='breakFast', to='backendAPI.recipe')),
                ('dinner', models.ManyToManyField(blank=True, null=True, related_name='dinner', to='backendAPI.recipe')),
                ('lunch', models.ManyToManyField(blank=True, null=True, related_name='lunch', to='backendAPI.recipe')),
                ('snack', models.ManyToManyField(blank=True, null=True, related_name='snack', to='backendAPI.recipe')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='dairy', to='backendAPI.user')),
                ('water', models.OneToOneField(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='dairy', to='backendAPI.water')),
            ],
        ),
    ]
