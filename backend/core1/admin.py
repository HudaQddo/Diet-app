from django.contrib import admin
from . import models
from django.contrib.auth.admin import UserAdmin as baseUserAdmin
from .models import MainUser
# Register your models here.

@admin.register(MainUser)
class UserAdmin(baseUserAdmin):
    add_fieldsets = (
        (
            None,
            {
                "classes": ("wide",),
                "fields": ("username", "password1", "password2","email","first_name","last_name"),
            },
        ),
    )

