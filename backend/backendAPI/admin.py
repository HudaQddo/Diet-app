from django.contrib import admin
from . import models

@admin.register(models.Recipe)
class RecipeAdmin (admin.ModelAdmin) :
    list_per_page = 10
    list_display = ['id' , 'name' , 'calories']
    search_fields = ['id' , 'name__icontains' , 'calories' , 'description__icontains']
    list_filter = ['subCategory' , 'dailyDiet']
    
@admin.register(models.Category)
class CategoryAdmin (admin.ModelAdmin) :
    list_per_page = 10
    list_display = ['id' , 'name' , 'subCategories_count']
    search_fields = ['id' , 'name__icontains']
    def subCategories_count (self , category) :
        return category.subCategories.count()

@admin.register(models.SubCategory)
class SubCategoryAdmin (admin.ModelAdmin) :
    list_per_page = 10
    list_display = ['id' , 'name' , 'category' , 'recipes_count']
    search_fields = ['id' , 'name__icontains' , 'category__name__icontains']
    list_filter = ['category']
    def recipes_count (self , sub) :
        return sub.recipes.count()

@admin.register(models.Diet)
class DietAdmin (admin.ModelAdmin) :
    list_per_page = 10
    list_display = ['id' , 'name' , 'numberOfDays']
    search_fields = ['id' , 'name__icontains']

@admin.register(models.DailyDiet)
class DailyDietAdmin (admin.ModelAdmin) :
    list_per_page = 10
    list_display = ['id' , 'name' , 'mainDiet__name' , 'numberOfMeals']
    search_fields = ['id' , 'name__icontains' , 'mainDiet__name__icontains']
    list_filter = ['mainDiet__name']
    def mainDiet__name (self , daily) :
        return daily.mainDiet.name

@admin.register(models.Challenge)
class ChallengeAdmin (admin.ModelAdmin) :
    list_per_page = 10
    list_display = ['id' , 'name']
    search_fields = ['id' , 'name__icontains']

@admin.register(models.Exercise)
class ExerciseAdmin (admin.ModelAdmin) :
    list_per_page = 10
    list_display = ['id' , 'name']
    search_fields = ['id' , 'name__icontains']

@admin.register(models.Favorite)
class FavoriteAdmin (admin.ModelAdmin) :
    list_per_page = 10
    list_display = ['user_id' , 'user' , 'Items']
    readonly_fields = ['user' ,  'userRecipes']
    search_fields = ['user_id']
    def Items (self , fav) :
        return fav.recipes.count()
    
    
admin.site.register(models.Dairy)
admin.site.register(models.Water)

@admin.register(models.User)
class UserAdmin (admin.ModelAdmin) :
    list_per_page = 10
    list_display = ['id' , 'user']
    search_fields = ['id' , 'user']
