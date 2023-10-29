from .models import *
from rest_framework import serializers


class UserSerializer (serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id','user_id','firstName','lastName','email','password','username','createTime','birthDate','height','startWeight','currentWeight','gender','goalWeight','changeRate',
         'BMI','dietTarget','dietType','activityRate','ilnesses','challenges','exercises' , 'dairy' , 'diet' , 'image']
        # fields = '__all__'
                
class RecipeSerializer (serializers.ModelSerializer) :
    class Meta :
        model = Recipe
        fields = ['id' , 'name' , 'image' , 'description' , 'ingredients' , 'steps' , 'calories' , 'rating' , 'fat' , 'carbs' , 'protein' , 'serving']
        
class SubCategorySerializer (serializers.ModelSerializer) :
    recipes = RecipeSerializer(many = True , read_only = True)
    class Meta :
        model = SubCategory
        fields = ['id' , 'name' , 'image' , 'recipes']


class CategorySerializer (serializers.ModelSerializer) :
    subCategories = SubCategorySerializer(many = True , read_only = True)
    class Meta :
        model = Category
        fields = ['id' , 'name' , 'subCategories']
        
class DailyDietSerializer (serializers.ModelSerializer) :
    recipes = RecipeSerializer(many = True , read_only = True)
    class Meta :
        model = DailyDiet
        fields = ['id' , 'name' , 'recipes']

class DietSerializer (serializers.ModelSerializer) :
    dailyDiets = DailyDietSerializer(many = True , read_only = True)
    class Meta :
        model = Diet
        fields = ['id' , 'name' , 'image' , 'description' , 'numberOfDays' , 'dailyDiets']
        
class ChallengeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Challenge
        fields = ['id' , 'name' , 'image']

class ExerciseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Exercise
        fields = ['name']

class DairySerializer (serializers.ModelSerializer) :
    recipes = RecipeSerializer(many = True , read_only = True)
    class Meta:
        model = Dairy
        fields = '__all__'
    
class FavoriteSerializer (serializers.ModelSerializer):
    recipes = RecipeSerializer(many = True , read_only = True)
    class Meta:
        model = Favorite
        fields = '__all__'