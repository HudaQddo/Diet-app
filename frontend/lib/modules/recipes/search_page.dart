// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:math';

import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models.dart';
import 'info_recipe.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  int number = 10;
  List<ModelRecipes> listRecipes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: searchController,
          keyboardType: TextInputType.text,
          onFieldSubmitted: (value){
            setState(() {
              getResultSearch(searchController.text);
            });
          },
          onChanged: (value){
            setState(() {
              getResultSearch(searchController.text);
            });
          },
          validator: (value){
            setState(() {
              if(value != null)
                getResultSearch(searchController.text);
            });
          },       
          style: TextStyle(
            color: Colors.white
          ),
          cursorWidth: 1,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.white
            ),
            focusColor: Colors.white,
            prefixIcon: Icon(Icons.search,color: Colors.white),
            fillColor: Colors.white,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: getPadding(),
          color: Colors.white,
          child: Expanded(
            child: listRecipes.isNotEmpty ? FutureBuilder<List<ModelRecipes>>(
              future: getResultSearch(searchController.text),
              initialData: listRecipes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<ModelRecipes>;
                  return Container(
                    child: ListView.separated(
                      itemCount: min(number + 1, listRecipes.length),
                      itemBuilder: (context, index) {
                        if(index == number){
                          return Container(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  number += 10;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Load more'),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              ),
                            ),
                          );
                        }
                        return Container(
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
                        );
                      },
                      separatorBuilder: (context, index) => getSizedBoxHeight(height: 30),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator());
              },
            )
            : Center(child: Text('Search')),
          ),
        ),
      ),
    );
  }

  Future<List<ModelRecipes>> getResultSearch(String keySearch) async {

    String baseUrl = "http://$localhost:8000/diet/recipe-list/$keySearch/";

    Uri url = Uri.parse(baseUrl);
    final response = await http.get(url,);
    listRecipes = [];
    if(response.statusCode == 200){
      var items = jsonDecode(response.body);

      for(var item in items){
        ModelRecipes recipeObj = ModelRecipes(
          id: item['id'], 
          name: item['name'], 
          image: item['image'],
          serving: item['serving'],
          description: item['description'],
          ingredients: item['ingredients'],
          steps: item['steps'],
          calories: item['calories'],
          fat: item['fat'],
          carbs: item['carbs'],
          protein: item['protein'],
          rating: item['rating'],
        );
        listRecipes.add(recipeObj);
      }
      return listRecipes;
    }
    else {
      return [];  
    }
  }
  
}
