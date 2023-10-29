from django.urls import path
from . import views

urlpatterns = [
# Favorite URLs
    path ('add-to-favorite/<int:recipeId>/' , views.addToFavorite), 
    path ('delete-from-favorite/<int:recipeId>/' , views.deletFromFavorite),
    path ('get-favorite/' , views.getMyFavorite),

# User URLs
    path('get-user/<int:id>/', views.getUser),
    path('get-all-users/', views.getAllUser),
    path('create-user/', views.createUser),
    # path('update-user/<int:id>/', views.updateUser),
    path('delete-user/<int:userId>/', views.deletUser),
    path('get-my-profile/', views.getMyProfile),

# Update info user URLs
    path('update-current-weight/', views.updateCurrentWeight),
    path('update-height/', views.updateHeight),
    path('update-diet-type/', views.updateDietType),
    path('update-change-rate/', views.updateChangeRate),
    path('update-activity-rate/', views.updateActivityRate),
    

# Challenge URLs
    path('challenges-list/' , views.challengeList),
    path('start-challenge/<int:challengeId>/', views.startChallenge),
    path('end-challenge/<int:userChallengeId>/', views.finishChallenge),

# Excersise URLs
    path('start-excercise/', views.startExercise),

# Recipes URLs
    path ('categories-list/' , views.categoryList),
    path ('recipe-list/<str:pk>/', views.recipeList),
    # path ('recipe-details/<int:pk>/' , views.recipeDetails), 
    path ('rate-recipe/<int:pk>/', views.rateRecipe),
    path ('get-total-calories/' , views.getTotalCaloriesPerDay),

# Diet URLs
    path ('diet-list/' , views.dietList),
    path ('diet-details/<int:pk>/' , views.dietDetails), 
    path ('follow-diet/<int:pk>/' , views.followDiet),
    path ('un-follow-diet/<int:pk>/' , views.unFollowDiet),
    path ('get-followers/<int:pk>/' , views.getFollowers),

    path('add-meal/<int:pk>/<str:meal>/',views.addMeal),
    path('get-my-dairy/',views.getMyDairy),
]