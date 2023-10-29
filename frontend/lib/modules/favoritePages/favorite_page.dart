// ignore_for_file: unused_import, prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';

import 'package:diet_app/constants.dart';
import 'package:diet_app/models.dart';
import 'package:diet_app/modules/favoritePages/add_recipe.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../recipes/info_recipe.dart';
import 'package:http/http.dart' as http;

class FavoritePage extends StatefulWidget {
  const FavoritePage({ Key? key }) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int number = 10;

  GetUserFavorite getUserFavorite = GetUserFavorite();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: getPadding(),
          color: Colors.white,
          child: FutureBuilder<List<ModelRecipes>>(
                future: getUserFavorite.getUserFavorite(),
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List<ModelRecipes>;
                    if(data.isEmpty){
                      return Center(child: Text('Your favorite list is empty!'));
                    }
                    return Container(
                      // height: 200,
                      child: ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (context, index) => Container(
                            alignment: Alignment.center,
                            height: 350,
                            child: createCart(
                              url: 'assets${data[index].image}', 
                              name: data[index].name,
                              width: 300,
                              onTapFav: (){
                                setState(() {
                                  // if(url == 'assets/images/pizza.jpg')
                                  //   url = 'assets/images/salad.jpg';
                                  // else
                                  //   url = 'assets/images/pizza.jpg';
                                  // // print('fav');
                                });
                              },
                              onTap: (){
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => InfoRecipe(recipe: data[index],),
                                  ),
                                );
                              },
                            ),
                          ),
                        separatorBuilder: (context, index) => getSizedBoxHeight(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
          // child: ListView.separated(
          //   itemBuilder: (context, index) {
          //     if(index == number){
          //       return Container(
          //         child: GestureDetector(
          //           onTap: (){
          //             setState(() {
          //               number += 10;
          //             });
          //           },
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text('Load more'),
          //               Icon(Icons.keyboard_arrow_down)
          //             ],
          //           ),
          //         ),
          //       );
          //     }
          //     return Container(
          //       alignment: Alignment.center,
          //       height: 350,
          //       child: createCart(
          //         url: 'assets/images/salad.jpg', 
          //         name: 'Salad',
          //         width: 300,
          //         onTap: (){
          //           // Navigator.push(
          //           //   context, 
          //           //   MaterialPageRoute(
          //           //     builder: (context) => InfoRecipe(imageRecipe: 'assets/images/pizza.jpg', nameRecipe: 'Pizza'),
          //           //   ),
          //           // );
          //         },
          //       ),
          //     );
          //   }, 
          //   separatorBuilder: (context, index) => getSizedBoxHeight(height: 30), 
          //   itemCount: number + 1,
          // )
        ),
      );
    // return SafeArea(
    //   child: Container(
    //     padding: getPadding(),
    //     // color: mainColor,
    //     child: Column(
    //       children: [
    //         Expanded(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               getTitle('Recipes'),
    //               // getSizedBoxHeight(height: 25),
    //               Container(
    //                 height: 200,
    //                 child: ListView.separated(
    //                   scrollDirection: Axis.horizontal,
    //                   itemBuilder: (context,index) => createCart(
    //                     url: 'assets/images/pizza.jpg',
    //                     name: 'Pizza',
    //                     onTap: (){}
    //                   ), 
    //                   separatorBuilder: (context,index) => getSizedBoxWidth(), 
    //                   itemCount: 5
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           height: 2,
    //           color: Colors.grey[300],
    //         ),
    //         Expanded(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               getTitle('My Recipes'),
    //               // getSizedBoxHeight(height: 25),
    //               Container(
    //                 height: 200,
    //                 child: ListView.separated(
    //                   scrollDirection: Axis.horizontal,
    //                   itemBuilder: (context,index) => createCart(
    //                     url: 'assets/images/pizza.jpg',
    //                     name: 'Pizza',
    //                     onTap: (){}
    //                   ), 
    //                   separatorBuilder: (context,index) => getSizedBoxWidth(), 
    //                   itemCount: 5
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: [
    //             IconButton(
    //               iconSize: 50,
    //               onPressed: (){
    //                 Navigator.push(
    //                       context, 
    //                       MaterialPageRoute(
    //                         builder: (context) => AddRecipe(),
    //                       ),
    //                     );
    //               }, 
    //               icon: CircleAvatar(
    //                 radius: 25,
    //                 backgroundColor: mainColor,
    //                 foregroundColor: Colors.white,
    //                 child: Icon(Icons.add),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   )
    // );
  }
}

class GetUserFavorite {
  late String token;

  Future<List<ModelRecipes>> getUserFavorite() async {
    String baseUrl = "http://$localhost:8000/diet/get-favorite/";
    token = await getToken();
    Uri url = Uri.parse(baseUrl);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT $token',
      },
    );
    if(response.statusCode == 200){
      var items = jsonDecode(response.body);

      List<ModelRecipes> listRecipes = [];
      for (var recipeItem in items['recipes']){
        ModelRecipes recipeObj = ModelRecipes(
          id: recipeItem['id'], 
          name: recipeItem['name'], 
          image: recipeItem['image'],
          serving: recipeItem['serving'],
          description: recipeItem['description'],
          ingredients: recipeItem['ingredients'],
          steps: recipeItem['steps'],
          calories: recipeItem['calories'],
          fat: recipeItem['fat'],
          carbs: recipeItem['carbs'],
          protein: recipeItem['protein'],
          rating: recipeItem['rating'],
        );
        listRecipes.add(recipeObj);
      }
      return listRecipes;
    }
    else {
      throw Exception('Fail');  
    }

  }
  

}