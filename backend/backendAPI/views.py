from pickle import PUT
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import *
from .serializers import *
from django.shortcuts import get_object_or_404
from core1.models import MainUser

# Create your views here.
@api_view(['POST'])
def createUser(request):
    username = request.data['username']
    first_name = request.data['firstName']
    last_name = request.data['lastName']
    password = request.data['password']
    email = request.data['email']
    
    user = MainUser.objects.create_user(
        username = username,
        password = password,
        first_name = first_name,
        last_name = last_name,
        email =email
    )
    user.save()

    userDiet = User()
    userDiet.user_id = user.id
    userDiet.email = user.email
    userDiet.firstName = user.first_name
    userDiet.lastName = user.last_name
    userDiet.username = user.username
    userDiet.password = user.password
    userDiet.birthDate = request.data['birthDate']
    userDiet.startWeight = float(request.data['currentWeight'])
    userDiet.currentWeight = float(request.data['currentWeight'])
    userDiet.height = int(request.data['height'])
    userDiet.gender = request.data['gender'] 
    userDiet.changeRate = request.data['changeRate'] 
    userDiet.dietType = request.data['dietType']
    userDiet.activityRate = request.data['activityRate']
    userDiet.ilnesses = request.data['ilnesses']
    currentWeight = float(request.data['currentWeight'])
    heightInMeter = userDiet.height/100
    userDiet.BMI = currentWeight/(heightInMeter*heightInMeter)
    #diet target
    if userDiet.BMI < 18.5 :
        userDiet.dietTarget = 'Gain'
        dietTarget = 'Gain'
        userDiet.image = "BMI/underweight.png"
    
    elif userDiet.BMI >= 18.5 and userDiet.BMI <= 24.9 :
        userDiet.dietTarget = 'Keep Fit'
        dietTarget = 'Keep Fit'
        userDiet.image = "BMI/normal.png"

    else :
        userDiet.dietTarget = 'Loss'
        dietTarget = 'Loss' 
        if userDiet.BMI > 24.9 and userDiet.BMI <= 29.9 :
            userDiet.image = "BMI/overweight.png"
        elif userDiet.BMI > 29.9 and userDiet.BMI <= 34.9 :
            userDiet.image = "BMI/obesity.PNG"
        elif userDiet.BMI > 34.9 :
            userDiet.image = "BMI/extreme_obesity.png"

    #goal weight
    targetMbi = (24.9+18.5)/2
    if dietTarget=='Loss' or dietTarget == 'Gain':
        userDiet.goalWeight = targetMbi * (heightInMeter*heightInMeter)
        
    else:
        userDiet.goalWeight = userDiet.currentWeight
        
    userDiet.save()
    # create favorite
    favorite = Favorite()
    favorite.userRecipes = 0
    favorite.user = userDiet
    favorite.save()
    #create water
    dt = datetime.datetime.strptime(userDiet.birthDate, '%Y-%m-%d')
    year = dt.year
    # year = userDiet.birthDate.year
    age = datetime.datetime.now().year-year
    age = 20
    water = Water()
    water.numberOfCup = 0
    water.sizeOfCup = 200.0
    if age<60 :
        water.numberOfLiter = (userDiet.currentWeight*30)/1000
    elif age>60 :
        water.numberOfLiter = (userDiet.currentWeight*25)/1000
    water.save()
    #creat daily page
    dailyPage = Dairy()
    dailyPage.water = water
    dailyPage.user = userDiet
    dailyPage.eatenCalories = 0.0
    dailyPage.burnetCalories = 0.0
    dailyPage.water.save()
    dailyPage.save()
    return Response(userDiet.id)

#get user profile by id
@api_view()
def getUser(request,id):
    user = get_object_or_404(User,pk=id)
    serializer = UserSerializer(user) 
    return Response(serializer.data)

#get my profile
@api_view()
def getMyProfile(request):
    id = request.user.id
    user=get_object_or_404(User,user_id=id)
    serializer = UserSerializer(user) 
    return Response(serializer.data)

#get all user
@api_view()
def getAllUser(request):
    queryset = User.objects.all()
    serializer = UserSerializer(queryset,many=True)
    return Response(serializer.data)

#update current weight
@api_view(['POST'])
def updateCurrentWeight(request):
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    user.currentWeight = request.data['currentWeight']
    heightInMeter = user.height/100
    user.BMI = float(user.currentWeight)/(heightInMeter*heightInMeter)
    
    #diet target
    if user.BMI < 18.5 :
        user.dietTarget = 'Gain'
        dietTarget = 'Gain'
        user.image = "BMI/underweight.png"
    
    elif user.BMI >= 18.5 and user.BMI <= 24.9 :
        user.dietTarget = 'Keep Fit'
        dietTarget = 'Keep Fit'
        user.image = "BMI/normal.png"

    else :
        user.dietTarget = 'Loss'
        dietTarget = 'Loss' 
        if user.BMI >= 25 and user.BMI <= 29.9 :
            user.image = "BMI/overweight.png"
        elif user.BMI >= 30 and user.BMI <= 34.9 :
            user.image = "BMI/obesity.PNG"
        elif user.BMI >= 35 :
            user.image = "BMI/extreme_obesity.png"

    #goal weight
    targetMbi = (24.9+18.5)/2
    if dietTarget=='Loss' or dietTarget == 'Gain':
        user.goalWeight = targetMbi * (heightInMeter*heightInMeter)
        
    else:
        user.goalWeight = user.currentWeight
     
    
    user.save()
    serializers = UserSerializer(user)
    return Response(serializers.data)

#change Activity Rate
@api_view(['POST'])
def updateActivityRate(request):
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    user.activityRate = request.data['activityRate']
    user.save()
    serializers = UserSerializer(user)
    return Response(serializers.data)

#change Diet Type
@api_view(['POST'])
def updateDietType(request):
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    user.dietType = request.data['dietType']
    user.save()
    serializers = UserSerializer(user)
    return Response(serializers.data)

#change Change Rate
@api_view(['POST'])
def updateChangeRate(request):
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    user.changeRate = request.data['changeRate']
    user.save()
    serializers = UserSerializer(user)
    return Response(serializers.data)

#update current weight
@api_view(['POST'])
def updateHeight(request):
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    user.height = request.data['height']
    heightInMeter = user.height/100
    user.BMI = user.currentWeight/(heightInMeter*heightInMeter)
    #diet target
    if user.BMI < 18.5 :
        user.dietTarget = 'Gain'
        dietTarget = 'Gain'
        user.image = "BMI/underweight.png"
    
    elif user.BMI >= 18.5 and user.BMI <= 24.9 :
        user.dietTarget = 'Keep Fit'
        dietTarget = 'Keep Fit'
        user.image = "BMI/normal.png"

    else :
        user.dietTarget = 'Loss'
        dietTarget = 'Loss' 
        if user.BMI >= 25 and user.BMI <= 29.9 :
            user.image = "BMI/overweight.png"
        elif user.BMI >= 30 and user.BMI <= 34.9 :
            user.image = "BMI/obesity.PNG"
        elif user.BMI >= 35 :
            user.image = "BMI/extreme_obesity.png"

    #goal weight
    targetMbi = (24.9+18.5)/2
    if dietTarget=='Loss' or dietTarget == 'Gain':
        user.goalWeight = targetMbi * (heightInMeter*heightInMeter)
        
    else:
        user.goalWeight = user.currentWeight
     
    
    user.save()
    serializers = UserSerializer(user)
    return Response(serializers.data)

#Delete user profile
@api_view(['DELETE'])
def deletUser(request,userId):
    user = get_object_or_404(User,pk=userId)
    user.delete()
    return Response("Success")


### Recipes Views ###
# View All Categories
@api_view(['Get'])
def categoryList(request) :
    category = Category.objects.all()
    serializer = CategorySerializer(category , many = True) 
    return Response(serializer.data)

# Filter All Recipes
@api_view(['Get'])
def filterRecipes(request) :
    lowCarb = SubCategory.objects.get(name = 'Low-Carb')
    lowFat = SubCategory.objects.get(name = 'Low-Fat')
    highProtein = SubCategory.objects.get(name = 'High-Protein')
    sub1 = SubCategory.objects.get(name = '50 - 200')
    sub2 = SubCategory.objects.get(name = '200 - 400')
    sub3 = SubCategory.objects.get(name = '400 - 600')
    sub4 = SubCategory.objects.get(name = '600 - 800')
    sub5 = SubCategory.objects.get(name = '800 - 1000')
    recipes = Recipe.objects.all()
    for recipe in recipes :
        carbs = recipe.carbs
        fat = recipe.fat
        protein = recipe.protein
        cal = recipe.calories
        if ( carbs / cal ) >= 0.1 and ( carbs / cal ) <= 0.2 :
            lowCarb.recipes.add(recipe)
        if ( fat / cal ) <= 0.03 :
            lowFat.recipes.add(recipe)
        if ( protein / cal ) >= 0.03 :
            highProtein.recipes.add(recipe)
        if ( recipe.calories ) >= 50 and ( recipe.calories ) <= 200 :
            sub1.recipes.add(recipe)
        if ( recipe.calories ) > 200 and ( recipe.calories ) <= 400 :
            sub2.recipes.add(recipe)
        if ( recipe.calories ) > 400 and ( recipe.calories ) <= 600 :
            sub3.recipes.add(recipe)
        if ( recipe.calories ) > 600 and ( recipe.calories ) <= 800 :
            sub4.recipes.add(recipe)
        if ( recipe.calories ) > 800 and ( recipe.calories ) <= 1000 :
            sub5.recipes.add(recipe)
        
# View All Recipes & Search Results
@api_view(['Get'])
def recipeList(request , pk) :
    recipes = Recipe.objects.filter(name__icontains = pk)
    serializer = RecipeSerializer(recipes , many = True) 
    return Response(serializer.data)

### Diet Views ###
# View All  Diets
@api_view(['Get'])
def dietList(request) :
    diet = Diet.objects.all()
    serializer = DietSerializer(diet , many = True) 
    return Response(serializer.data)

# View Diet Details
@api_view(['Get'])
def dietDetails(request , pk) :
    diet = get_object_or_404(Diet , pk = pk)
    serializer = DietSerializer(diet) 
    return Response(serializer.data)

### Favorite Views ###
# View My Fvorite
@api_view(['GET'])
def getMyFavorite(request):
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    favorite = user.favorite
    serializers = FavoriteSerializer(favorite)
    return Response(serializers.data)

# Add Recipe To Favorite
@api_view(['GET'])
def addToFavorite(request,recipeId):
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    recipe = get_object_or_404(Recipe,pk=recipeId)
    favorite = user.favorite
    user.favorite.recipes.add(recipe)
    count = user.favorite.userRecipes
    user.favorite.userRecipes = user.favorite.recipes.count()
    user.save()
    favorite.save()
    return Response(user.favorite.userRecipes)
    
# Delete Recipe From Favorite
@api_view(['GET'])
def deletFromFavorite(request,recipeId):
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    recipe = get_object_or_404(Recipe,pk=recipeId)
    favorite = user.favorite
    user.favorite.recipes.remove(recipe)
    user.favorite.userRecipes = user.favorite.recipes.count()
    user.save()
    favorite.save()
    return Response(user.favorite.userRecipes)

### Challenge Views ###
# View All Challenges
@api_view(['GET'])
def challengeList (request) :
    challenge = Challenge.objects.all()
    serializer = ChallengeSerializer(challenge , many = True) 
    return Response(serializer.data)

# Start A Challenge
@api_view(['GET'])   
def startChallenge(request,challengeId):
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    challenge = get_object_or_404(Challenge,pk=challengeId)
    userChallenge = UserChallenge()
    userChallenge.user = user
    userChallenge.challenge = challenge
    userChallenge.save()
    return Response(userChallenge.startTime)

# Finish A Challenge
@api_view(['GET','PATCH'])
def finishChallenge(request,userChallengeId):
    userChallenge = get_object_or_404(UserChallenge,pk=userChallengeId)
    userChallenge.endTime = datetime.datetime.now()
    context ={
        "start":userChallenge.startTime,
        "end":userChallenge.endTime
    }
    userChallenge.save()
    return Response( context)

@api_view(['GET']) 
def getMyDairy (request) :
    userID = request.user.id
    user = get_object_or_404(User , user_id = userID) 
    dairy = user.dairy
    serializers = DairySerializer(dairy)
    return Response(serializers.data)
    

@api_view(['GET']) 
def addMeal(request , pk , meal) :
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    recipe = get_object_or_404(Recipe , pk = pk)
    dairy = user.dairy
    if meal == 'breakfast' :
        user.dairy.breakfast.add(recipe)
    elif meal == 'lunch' :
        user.dairy.lunch.add(recipe)
    elif meal == 'dinner' :
        user.dairy.dinner.add(recipe)
    elif meal == 'snack' :
        user.dairy.snack.add(recipe)

    user.dairy.eatenCalories += recipe.calories
    user.save()
    dairy.save()
    serializers = DairySerializer(dairy)
    return Response(serializers.data)
    
### Rate View ###
# Rate A Recipe
@api_view(['POST'])
def rateRecipe (request , pk) :
    userID = request.user.id 
    userRate = request.data['user_rate']

    user = get_object_or_404(User , user_id = userID)
    recipe = get_object_or_404(Recipe , pk = pk)
    recipeReview = RecipeReview.objects.filter(user_id = user.id).filter(recipe_id = recipe.id).first()
    if recipeReview == None : 
        review = RecipeReview()
        review.user = user
        review.recipe = recipe
        review.rating = userRate
        recipe.rating = (recipe.rating + userRate) / 2
        review.save()
    else :
        oldRate = recipeReview.rating
        oldRecipeRate = (2 * recipe.rating) - oldRate
        recipeReview.rating = userRate
        recipe.rating = (oldRecipeRate + userRate) / 2
        recipeReview.save()
    recipe.save()
    serializers = RecipeSerializer(recipe)
    return Response(serializers.data)

# Calculate Total Calories Per Day
@api_view(['GET'])
def getTotalCaloriesPerDay(request):
    userID = request.user.id
    user = get_object_or_404(User,user_id=userID)
    caloriesPerDay = (user.changeRate * 7000 ) / 7
    calories = user.userCalories()
    if user.dietTarget == "Keep Fit" :
        user.dairy.totalCalories = calories
    elif user.dietTarget == 'Loss' : 
        user.dairy.totalCalories = calories - caloriesPerDay
    elif user.dietTarget == 'Gain' :
        user.dairy.totalCalories = calories + caloriesPerDay
    user.dairy.save()
    user.save()
    serializers = DairySerializer(user.dairy)
    return Response(serializers.data)

# View All Folllowers Of A Diet
@api_view(['Get'])
def getFollowers(request , pk):    
    diet = get_object_or_404(Diet , pk = pk)
    return Response(diet.users.count())

# Follow A Diet
@api_view(['Get'])
def followDiet(request , pk):
    userId = request.user.id
    user = get_object_or_404(User , user_id = userId)
    diet = get_object_or_404(Diet , pk = pk)
    user.diet = diet
    diet.users.add(user)
    user.save()
    diet.save()
    return Response(diet.users.count())

# Un-Follow A Diet
@api_view(['Get'])
def unFollowDiet(request , pk):
    userId = request.user.id
    user = get_object_or_404(User , user_id = userId)
    diet = get_object_or_404(Diet , pk = pk)
    diet.users.remove(user)
    user.diet = None
    user.save()
    diet.save()
    return Response(diet.users.count())

# # Start An Excercise
# @api_view(['POST'])   
# def startExercise(request,excerciseId):
#     userId = request.user.id
#     user = get_object_or_404(User,user_id=userId)
#     excercise = get_object_or_404(Exercise,pk=excerciseId)
#     userExcercise = UserExercise()
#     weight = user.currentWeight
#     height = user.height
#     lengthOfTime = request.data['lengthOfTime']
#     lengthOfTimeBerHour = lengthOfTime / 60
#     age = datetime.datetime.now().year-user.birthDate.year
#     if user.gender == "male":
#         bmr = 5 + (9.99 * weight) + (6.25 * height) - (4.92 * age)
    
#     else :
#         bmr = 161 + (9.99* weight) + (6.25 * height) - (4.92 * age)

#     userExcercise.lengthOfTime = request.data['lengthOfTime']

#     if excercise.name == "run":
#         userExcercise.burntCalories =(lengthOfTime * 12.5 * weight * 3.5) / 200
    
#     elif excercise.name == "slow walk":
#          userExcercise.burntCalories =(lengthOfTimeBerHour*bmr*2.3)/24

#     elif excercise.name == "quick walk":
#          userExcercise.burntCalories =(lengthOfTimeBerHour*bmr*3.3)/24

#     userExcercise.user = user
#     userExcercise.exercise = excercise
#     user.dairy.burnetCalories += userExcercise.burntCalories
#     user.dairy.save()
#     userExcercise.save()
    
#     return Response(user.dailyPage.burnetCalories)

# Start An Excercise
@api_view(['POST'])   
def startExercise(request):
    userId = request.user.id
    user = get_object_or_404(User,user_id=userId)
    # excercise = get_object_or_404(Exercise,pk=excerciseId)
    exercise = request.data['exerciseName']
    # userExcercise = UserExercise()
    weight = user.currentWeight
    height = user.height
    lengthOfTime = int(request.data['lengthOfTime'])
    lengthOfTimeBerHour = lengthOfTime / 60
    age = datetime.datetime.now().year-user.birthDate.year
    if user.gender == "male":
        bmr = 5 + (9.99 * weight) + (6.25 * height) - (4.92 * age)
    
    else :
        bmr = 161 + (9.99* weight) + (6.25 * height) - (4.92 * age)

    # userExcercise.lengthOfTime = request.data['lengthOfTime']

    if exercise == "Run":
        burntCalories = (lengthOfTime * 12.5 * weight * 3.5) / 200
    
    elif exercise == "Slow Walk":
        burntCalories = (lengthOfTimeBerHour*bmr*2.3)/24

    elif exercise == "Quick Walk":
        burntCalories = (lengthOfTimeBerHour*bmr*3.3)/24

    # userExcercise.user = user
    # userExcercise.exercise = exercise
    user.dairy.burnetCalories += burntCalories
    user.dairy.save()
    # userExcercise.save()
    
    return Response(user.dairy.burnetCalories)

# Drink Water
@api_view(['POST'])
def addWaterCup(request):
    user = request.user.id
    userDiet = get_object_or_404(User,user_id=user)
    userDiet.dairy.water.numberOfCup = request.data['numberOfCup']
    userDiet.dairy.water.sizeOfCup = request.data['sizeOfCup']
    userDiet.dairy.water.literIsDrink = userDiet.dairy.water.numberOfCup * userDiet.dairy.water.sizeOfCup/1000
    userDiet.dairy.water.save()
    userDiet.dairy.save()
    return Response(userDiet.dairy.water.literIsDrink)

