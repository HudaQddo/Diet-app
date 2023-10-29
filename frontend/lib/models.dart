
// ignore_for_file: non_constant_identifier_names


class ModelCategory {
  final int id;
  final String name;
  final List<ModelSubCategory> subCategories;
  
  ModelCategory({
    required this.id,
    required this.name,
    required this.subCategories
  });

  factory ModelCategory.fromJson(Map<String,dynamic>json){
    return ModelCategory(
      id: json['id'], 
      name: json['name'], 
      subCategories: json['subCategories']
    );
  }
}

class ModelSubCategory {
  final int id;
  final String name;
  final String image;
  final List<ModelRecipes> recipes;
  
  ModelSubCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.recipes
  });

  factory ModelSubCategory.fromJson(Map<String,dynamic>json){
    return ModelSubCategory(
      id: json['id'], 
      name: json['name'], 
      image: json['image'],
      recipes: json['recipes']
    );
  }
}

class ModelRecipes {
  final int id;
  final String name;
  final String image;
  final int serving;
  final String description;
  final String ingredients;
  final String steps;
  final int calories;
  final double fat;
  final double carbs;
  final double protein;
  final double rating;
  
  ModelRecipes({
    required this.id,
    required this.image,
    required this.name,
    required this.serving,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.calories,
    required this.fat,
    required this.carbs,
    required this.protein,
    required this.rating,
  });
  factory ModelRecipes.fromJson(Map<String,dynamic>json){
    return ModelRecipes(
      id: json['id'], 
      name: json['name'], 
      image: json['image'],
      serving: json['serving'],
      description: json['description'],
      ingredients: json['ingredients'],
      steps: json['steps'],
      calories: json['calories'],
      fat: json['fat'],
      carbs: json['carbs'],
      protein: json['protein'],
      rating: json['rating'],
    );
  }
}

class ModelDiet {
  final int id;
  final String name;
  final String image;
  final String description;
  final int numberOfDays;
  List<ModelDailyDiet> dailyDiets;
  
  ModelDiet({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.numberOfDays,
    required this.dailyDiets
  });
  factory ModelDiet.fromJson(Map<String,dynamic>json){
    return ModelDiet(
      id: json['id'], 
      name: json['name'], 
      image: json['image'],
      description: json['description'],
      numberOfDays: json['numberOfDays'],
      dailyDiets: json['dailyDiets']
    );
  }
}

class ModelDailyDiet {
  final int id;
  final String name;
  final List<ModelRecipes> recipes;
  
  ModelDailyDiet({
    required this.id,
    required this.name,
    required this.recipes
  });
  factory ModelDailyDiet.fromJson(Map<String,dynamic>json){
    return ModelDailyDiet(
      id: json['id'], 
      name: json['name'],
      recipes: json['recipes']
    );
  }
}

class ModelChallenge {
  final int id;
  final String name;
  final String image;

  ModelChallenge({
    required this.id,
    required this.name,
    required this.image
  });
  factory ModelChallenge.fromJson(Map<String,dynamic>json){
    return ModelChallenge(
      id: json['id'], 
      name: json['name'],
      image: json['image']
    );
  }
}

class ModelExercise {
  final String name;

  ModelExercise({
    required this.name,
  });
  factory ModelExercise.fromJson(Map<String,dynamic>json){
    return ModelExercise(
      name: json['name'],
    );
  }
}

// class ModelFavorite {
//   final List<ModelRecipes> recipes;
//   ModelFavorite({
//     required this.recipes
//   });
//   factory ModelFavorite.fromJson(Map<String,dynamic>json){
//     return ModelFavorite(
//       recipes: json['recipes'],
//     );
//   }
// }

class ModelUser {
  final int id;
  final int user_id;
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final int height;
  final String createTime;
  final double startWeight;
  final double currentWeight;
  final String gender;
  final double goalWeight;
  final double BMI;
  final double changeRate;
  final String dietTarget;
  final String dietType;
  final String activityRate;
  final String ilnesses;
  // final List<ModelChallenge> challenges;
  // final List<ModelExercise> exercises;
  // ModelDiet? diet;
  // final ModelDairy dairy;
  // final List<String> foodAllergies;
  // final int favorite;
  final String image;


  ModelUser({
    required this.id,
    required this.user_id,
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.height,
    required this.createTime,
    required this.startWeight,
    required this.currentWeight,
    required this.gender,
    required this.goalWeight,
    required this.BMI,
    required this.changeRate,
    required this.dietTarget,
    required this.dietType,
    required this.activityRate,
    // required this.foodAllergies,
    required this.ilnesses,
    // required this.challenges,
    // required this.exercises,
    // this.diet,
    // required this.dairy,
    // required this.favorite,
    required this.image,
  });
  factory ModelUser.fromJson(Map<String,dynamic>json){
    return ModelUser(
      id: json['id'], 
      user_id: json['user_id'], 
      username: json['username'], 
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      height: json['height'],
      createTime: json['createTime'],
      startWeight: json['startWeight'],
      currentWeight: json['currentWeight'],
      gender: json['gender'],
      goalWeight: json['goalWeight'],
      BMI: json['BMI'],
      changeRate: json['changeRate'],
      dietTarget: json['dietTarget'],
      dietType: json['dietType'],
      activityRate: json['activityRate'],
      ilnesses: json['ilnesses'],
      // challenges: json['challenges'],
      // exercises: json['exercises'],
      // diet: json['diet'],
      // dairy: json['dairy'],
      // favorite: json['favorite'],
      // foodAllergies: json['foodAllergies'],
      image: json['image'],
    );
  }
}

class ModelDairy {
  final ModelUser user;
  final ModelWater water;
  final List<ModelRecipes> breakfast;
  final List<ModelRecipes> lunch;
  final List<ModelRecipes> dinner;
  final List<ModelRecipes> snack;
  final double totalCalories;
  final double eatenCalories;
  final double burnetCalories;

  ModelDairy({
    required this.user,
    required this.water,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
    required this.totalCalories,
    required this.eatenCalories,
    required this.burnetCalories
  });

  factory ModelDairy.fromJson(Map<String,dynamic>json){
    return ModelDairy(
      user: json['user'], 
      water: json['water'],
      breakfast: json['breakfast'],
      lunch: json['lunch'],
      dinner: json['dinner'],
      snack: json['snack'],
      totalCalories: json['totalCalories'],
      eatenCalories: json['eatenCalories'],
      burnetCalories: json['burnetCalories'],
    );
  }
}

class ModelWater {
  final int numberOfCup;
  final double sizeOfCup;
  final double literIsDrink;
  final double numberOfLiter;


  ModelWater({
    required this.numberOfCup,
    required this.sizeOfCup,
    required this.literIsDrink,
    required this.numberOfLiter
  });

  factory ModelWater.fromJson(Map<String,dynamic>json){
    return ModelWater(
      numberOfCup: json['numberOfCup'], 
      sizeOfCup: json['sizeOfCup'],
      literIsDrink: json['literIsDrink'],
      numberOfLiter: json['numberOfLiter'],
    );
  }

}

