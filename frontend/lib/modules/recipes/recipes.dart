// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:diet_app/modules/recipes/search_page.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models.dart';
import '../../shared/components/components.dart';
import 'sub_category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Recipes extends StatefulWidget {
   Recipes({ Key? key }) : super(key: key);

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  GetCategory getCategory = GetCategory();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: getPadding(),
        color: Colors.white,
        height: (MediaQuery.of(context).size.height),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              },
              child: Container(
                padding: getPadding(),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey
                  ),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    getSizedBoxWidth(),
                    Text('Search')
                  ],
                ),
              ),
            ),
            getSizedBoxHeight(),
            Expanded(
              child: FutureBuilder<List<ModelCategory>>(
                future: getCategory.getAllCategories(),
                initialData: [],
                builder: (context, snapshot) {
                  late final data = snapshot.data as List<ModelCategory>;
                  if (snapshot.hasData) {
                    return Container(
                      height: 200,
                      child: ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (context, index) => getRowSubCategory(data[index]),
                        separatorBuilder: (context, index) => getSizedBoxHeight(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          
          ],
        ),
      ),
    );
  }

  Widget getRowSubCategory(ModelCategory category){
    // if (categories[indexCategory] == 'For you')
    //   return GestureDetector(
    //     onTap: (){
    //       Navigator.push(
    //         context, 
    //         MaterialPageRoute(
    //           builder: (context) => Category(title: 'For you'),
    //         ),
    //       );
    //     },
    //     child: Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         Image.asset(
    //           'assets/images/forYou.jpg',
    //           height: 200,
    //           width: (MediaQuery.of(context).size.width),
    //           fit: BoxFit.fitWidth,
    //           color: Colors.white.withOpacity(0.5),
    //           colorBlendMode: BlendMode.modulate
    //         ),
    //         Text(
    //           categories[indexCategory],
    //           style: TextStyle(
    //             fontSize: 25,
    //             fontWeight: FontWeight.bold,
    //             letterSpacing: 3
    //           ),
    //         ),
    //       ],
    //     ),
    //   );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitle(category.name),
          getSizedBoxHeight(),
          Container(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: category.subCategories.length,
              itemBuilder: (context, index) => createCart(
                url: 'assets${category.subCategories[index].image}',
                name: category.subCategories[index].name,
                isRecipe: false,
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => SubCategory(subCategory: category.subCategories[index],),
                    ),
                  );
                }
              ), 
              separatorBuilder: (context,index) => getSizedBoxWidth(), 
            ),
          )
        ],
      ),
    );
  }
  
}

class GetCategory {

  Future<List<ModelCategory>> getAllCategories() async {
    List<ModelCategory> listCategory = [];
    String baseUrl = "http://$localhost:8000/diet/categories-list/";

    Uri url = Uri.parse(baseUrl);
    final response = await http.get(url,);
    if(response.statusCode == 200){
      var items = jsonDecode(response.body);

      for(var item in items){
        List<ModelSubCategory> listSubCategory = [];

        for (var subItem in item['subCategories']){
          List<ModelRecipes> listRecipes = [];

          for (var recipeItem in subItem['recipes']){
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

          ModelSubCategory subObj = ModelSubCategory(
            id: subItem['id'], 
            name: subItem['name'], 
            image: subItem['image'],
            recipes: listRecipes
          );
          listSubCategory.add(subObj);
        }

        ModelCategory categoryObj = ModelCategory(
          id: item['id'], 
          name: item['name'], 
          subCategories: listSubCategory
        );
        listCategory.add(categoryObj);
      }
      return listCategory;
    }
    else {
      throw Exception('Fail');  
    }
  }
  
}


