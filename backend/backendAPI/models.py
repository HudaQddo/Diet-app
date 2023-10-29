import datetime
from django.db import models
from django.core.validators import MinValueValidator , MaxValueValidator
from django.conf import settings

class Recipe(models.Model):
    image = models.ImageField(blank=True, null=True, upload_to='Recipes/')
    name = models.CharField(max_length=255)
    serving = models.PositiveIntegerField(default=1 , validators=[MinValueValidator(0)])
    description = models.TextField(null=True , blank=True)
    ingredients = models.TextField(null=True , blank=True)
    steps = models.TextField()
    calories = models.IntegerField(default=0 , validators=[MinValueValidator(0)])
    fat = models.FloatField(default=0 , validators=[MinValueValidator(0)])
    protein = models.FloatField(default=0 , validators=[MinValueValidator(0)])
    carbs = models.FloatField(default=0 , validators=[MinValueValidator(0)])
    rating = models.FloatField(default=0 , validators=[MinValueValidator(0)])
    dailyDiet = models.ManyToManyField('DailyDiet', blank = True , related_name='recipes')
    subCategory = models.ManyToManyField('SubCategory' , related_name='recipes')
    
    def str(self) -> str:
        return self.name
    
    class Meta :
        ordering = ['name']
        
class Category (models.Model) :
    name = models.CharField(max_length=255)
    def __str__(self) -> str:
        return self.name

    class Meta :
        ordering = ['name']

class SubCategory (models.Model) :
    image = models.ImageField(blank=True, null=True, upload_to='subCategories/')
    name = models.CharField(max_length=255)
    category = models.ForeignKey('Category' , on_delete=models.CASCADE, related_name='subCategories')

    def __str__(self) -> str:
        return self.name
    
    class Meta :
        ordering = ['category__name']

# Main Diet Model 
class Diet(models.Model):
    image = models.ImageField(blank=True, null=True, upload_to='diets/')
    name = models.CharField(default = "" , max_length=255)
    description = models.TextField(default="" , blank=True)
    numberOfDays = models.PositiveIntegerField(default=0 , validators=[MinValueValidator(0)])         
    def str(self) -> str:
        return self.name

    class Meta :
        ordering = ['name']

# Daily Diet Model
class DailyDiet (models.Model) :
    name = models.CharField(default = "" ,max_length=255)
    numberOfMeals = models.PositiveIntegerField(default=0 , validators=[MinValueValidator(0)])
    mainDiet = models.ForeignKey(Diet , on_delete=models.CASCADE , related_name= 'dailyDiets')

    def str(self) -> str:
        return self.name

    class Meta :
        ordering = ['name']
        
        
# Challenge Model
class Challenge(models.Model):
    name = models.CharField(max_length=255)
    image = models.ImageField(blank=True, null=True, upload_to='Challenges/')

    def str(self) -> str:
        return self.name

    class Meta :
        ordering = ['name']

# User challenge model
class UserChallenge(models.Model):
    startTime = models.DateTimeField(auto_now_add = True)
    endTime = models.DateTimeField(null=True)
    user = models.ForeignKey('User',on_delete=models.CASCADE,related_name='userChallenge')
    challenge = models.ForeignKey(Challenge,on_delete=models.CASCADE,related_name='userChallenge')
    
       
# Create your models here.
class User(models.Model):
    GENDER_MALE = 'M'
    GENDER_FEMALE = 'F'
    GENDER_CHOICES = [
        (GENDER_MALE,'Male'),
        (GENDER_FEMALE,'Female')
        
    ]

    DIET_TARGET_CHOICES = [
        ('Loss', 'Weight Loss'),
        ('Gain', 'Weight Gain'),
        ('Keep Fit' , 'Keep Fit'),
    ]

    DIET_TYPES_CHOICES = [
        ('CLASSIC', 'Classic'),
        ('LOW CARB', 'Low Carb'),
        ('LOW FAT', 'Low Fat'),
        ('HIGH PROTEIN', 'High Protein'),
        ('VEGAN' , 'Vegan'),
        ('VEGETERIAN' , 'Vegetarain'),
    ]

    ACTIVITY_CHOICES = [
        ('LITTLE', 'Little or No Activity'),
        ('LIGHT', 'Lightly Active'),
        ('MODEREATE' , 'Moderately Active'),
        ('VERY' , 'Very Active'),
    ]

    ILLNESSES_CHOICES = [
        ('NO' , 'None'),
        ('DI', 'Diabates'),
        ('CH', 'Cholesterol'),
    ]

    user = models.OneToOneField(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)
    image = models.ImageField(blank=True, null=True, upload_to='BMI/')
    firstName = models.CharField(max_length=255)
    lastName = models.CharField(max_length=255)
    username = models.CharField(max_length=255 , default='username')
    email = models.EmailField(max_length=255 , default='email@gmail.com')
    password = models.CharField(max_length=255 , default='0000000000')
    birthDate = models.DateField(null=True)
    height = models.PositiveIntegerField()
    createTime = models.DateTimeField(auto_now_add = True,null=True)
    startWeight = models.FloatField()
    currentWeight = models.FloatField()
    gender = models.CharField(max_length=1,choices=GENDER_CHOICES,default='M')
    goalWeight = models.FloatField(null=True)
    BMI = models.FloatField(default = 21.7)
    changeRate = models.FloatField(default = 0.0)
    dietTarget = models.CharField(max_length = 20 , choices = DIET_TARGET_CHOICES , default = 'Loss')
    dietType = models.CharField(max_length = 20 , choices = DIET_TYPES_CHOICES , default = 'CLASSIC')
    activityRate = models.CharField(max_length = 10 , choices = ACTIVITY_CHOICES , default = 'MODEREATE')
    # Allergies & Don't Like --> More Than One Option Available
    ilnesses = models.CharField(max_length = 20 , choices = ILLNESSES_CHOICES , default = 'NO')
    challenges = models.ManyToManyField('Challenge',related_name='users' , blank = True)
    exercises = models.ManyToManyField('Exercise',related_name='users', blank = True)
    diet = models.ForeignKey('Diet' , null = True , blank = True , on_delete=models.CASCADE , related_name='users')
    def str(self) -> str:
        return self.user.email
    
    def firstName(self):
        return self.user.first_name

    def lastName(self):
        return self.user.last_name

    def getActivityRate (user) :
        if user.activityRate == 'LITTLE' :
            return 1.3
        if user.activityRate == 'LIGHT' : 
            return 1.4
        if user.activityRate == 'MODEREATE' :
            return 1.5
        if user.activityRate == 'VERY' :
            return 1.7

    # Calculate BMR For User 
    def userCalories (self) :
        age = datetime.datetime.now().year-self.birthDate.year
        calories = 0.0
        if self.gender == "male":
            calories = 5 + (9.99 * self.currentWeight) + (6.25 * self.height) - (4.92 * age)  
        else :
            calories = (9.99 * self.currentWeight) + (6.25 * self.height) - (4.92 * age) - 161
        
        activityRate = self.getActivityRate()
        calories = activityRate * calories
        return calories

# User Favorite Model
class Favorite(models.Model):
    user = models.OneToOneField('User',on_delete=models.CASCADE,primary_key=True,related_name='favorite')
    recipes = models.ManyToManyField('Recipe',related_name='favorites',blank=True)
    userRecipes = models.IntegerField(default=0 , validators=[MinValueValidator(0)])

# Excersice Model
class Exercise(models.Model):
    name = models.CharField(max_length=255)
    def str(self) -> str:
        return self.name

    class Meta :
        ordering = ['name']

# User challenge model
class UserExercise(models.Model):
    lengthOfTime = models.IntegerField()
    burntCalories = models.FloatField()
    user = models.ForeignKey(User,on_delete=models.CASCADE,related_name='userExercise')
    exercise = models.ForeignKey(Exercise,on_delete=models.CASCADE,related_name='userExercise')
    

# Water Model
class Water(models.Model):
    numberOfCup = models.PositiveIntegerField()
    sizeOfCup = models.FloatField()
    literIsDrink = models.FloatField(null=True)
    numberOfLiter = models.FloatField()

# Dairy Page Modle
class Dairy(models.Model):
    user = models.OneToOneField('User',on_delete=models.CASCADE,related_name='dairy')
    water = models.OneToOneField(Water, null = True , blank = True , on_delete=models.PROTECT,related_name='dairy')
    breakfast = models.ManyToManyField(Recipe, null = True , blank = True , related_name='breakFast')
    lunch = models.ManyToManyField(Recipe,null = True , blank = True , related_name='lunch')
    dinner = models.ManyToManyField(Recipe, null = True , blank = True , related_name='dinner')
    snack = models.ManyToManyField(Recipe,null = True , blank = True , related_name='snack')
    totalCalories = models.FloatField(null=True , blank=True)
    eatenCalories = models.FloatField(null=True , blank=True)
    burnetCalories = models.FloatField(null=True , blank= True)



class RecipeReview (models.Model) : 
    user = models.ForeignKey('User' , on_delete=models.CASCADE, related_name='reviews')
    recipe = models.ForeignKey('Recipe' , on_delete=models.CASCADE, related_name='reviews')
    rating = models.FloatField(validators=[MinValueValidator(1) , MaxValueValidator(5)] )



