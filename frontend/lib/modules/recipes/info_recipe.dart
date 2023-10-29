// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_print, no_logic_in_create_state, prefer_const_constructors_in_immutables

import 'dart:convert';
import 'package:diet_app/constants.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models.dart';

class InfoRecipe extends StatefulWidget {
  final ModelRecipes recipe;
   InfoRecipe({ 
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  State<InfoRecipe> createState() => _InfoRecipeState(recipe: recipe);
}

class _InfoRecipeState extends State<InfoRecipe> {
  ModelRecipes recipe;
  int indexActive = 0;
  bool isFavorite = false;
  int rateUser = 0;

  _InfoRecipeState({
    required this.recipe
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: recipe.name),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets${recipe.image}',
                  width: (MediaQuery.of(context).size.width),
                  height: 300,
                  fit: BoxFit.fill,
                ),
                getSizedBoxHeight(),
                // name & favorite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: getPadding(vertical: 0),
                        child: Text(
                          recipe.name,
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: getPadding(vertical: 0),
                      child: IconButton(
                        onPressed: (){
                          setState(() {
                            isFavorite = !isFavorite;
                            addFavorite(recipe.id, isFavorite);
                          });
                        },
                        icon: isFavorite
                        ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                        : Icon(Icons.favorite_border),
                      ),
                    )
                  ],
                ),
                getSizedBoxHeight(),
                // kcal & fat & protein & carbs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Kcal\r\n${recipe.calories}'),
                    Text('Fat\r\n${recipe.fat}'),
                    Text('Protein\r\n${recipe.protein}'),
                    Text('Carb\r\n${recipe.carbs}'),
                  ],
                ),
                getSizedBoxHeight(),
                // Description
                Container(
                  padding: getPadding(vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getTitle('Description'),
                          getTitle('Serving ${recipe.serving}')
                        ],
                      ),
                      getSizedBoxHeight(),
                      Text(recipe.description),
                    ],
                  ),
                ),
                getSizedBoxHeight(),
                // ingredients & steps
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          indexActive = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: indexActive == 0 ? secondColor : null,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        alignment: Alignment.center,
                        width: (MediaQuery.of(context).size.width)/2 - 30,
                        child: getTitle("Ingredients"),
                        ),
                    ),
            
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          indexActive = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: indexActive == 1 ? secondColor : null,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        alignment: Alignment.center,
                        width: (MediaQuery.of(context).size.width)/2 - 30,
                        child: getTitle("Instructions"),
                      ),
                    ),
                  ],
                ),
                getSizedBoxHeight(),
                getPart(),
                getSizedBoxHeight(),
                // Rate
                Container(
                  padding: getPadding(vertical: 0),
                  child: getTitle('Rate: (${recipe.rating})'),
                ),
                getSizedBoxHeight(),
                Container(
                  padding: getPadding(vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                rateUser = 1;
                                addRating(recipe.id, rateUser);
                              });
                            },
                            child: rateUser < 1 ? Icon(Icons.star_border) : Icon(Icons.star, color: Colors.yellow),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                rateUser = 2;
                                addRating(recipe.id, rateUser);
                              });
                            },
                            child: rateUser < 2 ? Icon(Icons.star_border) : Icon(Icons.star, color: Colors.yellow),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                rateUser = 3;
                                addRating(recipe.id, rateUser);
                              });
                            },
                            child: rateUser < 3 ? Icon(Icons.star_border) : Icon(Icons.star, color: Colors.yellow),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                rateUser = 4;
                                addRating(recipe.id, rateUser);
                              });
                            },
                            child: rateUser < 4 ? Icon(Icons.star_border) : Icon(Icons.star, color: Colors.yellow),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                rateUser = 5;
                                addRating(recipe.id, rateUser);
                              });
                            },
                            child: rateUser < 5 ? Icon(Icons.star_border) : Icon(Icons.star, color: Colors.yellow),
                          ),
                        ],
                      ),
                      PopupMenuButton(
                        child: CircleAvatar(
                          backgroundColor: mainColor,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.add),
                        ),
                        itemBuilder: (context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            onTap: (){},
                            child: ListTile(
                              leading: Image.asset('assets/icons/breakfast.png'),
                              title: Text('Add Breakfast'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: (){},
                            child: ListTile(
                              leading: Image.asset('assets/icons/lunch.png'),
                              title: Text('Add Lunch'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: (){},
                            child: ListTile(
                              leading: Image.asset('assets/icons/dinner.png'),
                              title: Text('Add Dinner'),
                            ),
                          ),
                          PopupMenuDivider(),
                          PopupMenuItem(
                            onTap: (){},
                            child: ListTile(
                              leading: Image.asset('assets/icons/snack.png'),
                              title: Text('Add Snack'),
                            ),
                          ),      
                        ],
                      ),
                    ],
                  ),
                ),
                getSizedBoxHeight(),
 
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPart(){
    // steps
    if (indexActive == 1){
      return Container(
        padding: getPadding(vertical: 0),
        child: Text(
          recipe.steps,
          style: TextStyle(
            fontSize: 15
          ),
        ),
      );
    }
    // ingredients
    return Container(
        padding: getPadding(vertical: 0),
        child: Text(
          recipe.ingredients,
          style: TextStyle(
            fontSize: 15
          ),
        ),
      );
  }

  addFavorite(int idRecipe, isFav) async {
    var token = await getToken();
    String urlAdd = "http://$localhost:8000/diet/add-to-favorite/$idRecipe/";
    String urlDelete = "http://$localhost:8000/diet/delete-from-favorite/$idRecipe/";
    String url = urlAdd;
    if(!isFav) url = urlDelete;
    await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT $token',
      },
    );
  }

  addRating(int idRecipe, int rate) async {
    var token = await getToken();
    String url = "http://$localhost:8000/diet/rate-recipe/$idRecipe/";
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT $token',
      },
      body: {
        "user_rate": rate
      },
      encoding: Encoding.getByName("utf-8")
    );
    print(response.body);
  }


}

