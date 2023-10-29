// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models.dart';
import 'diet.dart';
import 'package:http/http.dart' as http;

class DietsPage extends StatefulWidget {
  const DietsPage({ Key? key }) : super(key: key);

  @override
  State<DietsPage> createState() => _DietsPageState();
}

class _DietsPageState extends State<DietsPage> {
  bool isFollowDiet = false;
  List<String> categoriosDiets = ["Vegan", "Low carb", "Hight Protein"];
  List<List<String>> nameDiets = [["5-Day", "7-Day"], ["5-Day", "7-Day"], ["5-Day", "7-Day"]];
  List<List<String>> imageDiets = [['assets/images/vegan.jpg', 'assets/images/vegan2.jpg'], ['assets/images/lowCarb.jpg', 'assets/images/lowCarb2.jpg'], ['assets/images/highProtein.jpg', 'assets/images/highProtein2.jpg']];

  GetDiet getDiet = GetDiet();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: getPadding(vertical: 15),
        color: Colors.white,
        child: Column(
          children: [
            // GestureDetector(
            //   onTap: (){
            //     Navigator.push(
            //       context, 
            //       MaterialPageRoute(
            //         builder: (context) => Diet(nameDiet: 'My Diet', imageDiet: 'assets/images/myDiet.jpg',),
            //       ),
            //     );
            //   },
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: [
            //       Image.asset(
            //         'assets/images/myDiet.jpg',
            //         height: 200,
            //         width: (MediaQuery.of(context).size.width),
            //         fit: BoxFit.fitWidth,
            //         color: Colors.white.withOpacity(0.5),
            //         colorBlendMode: BlendMode.modulate
            //       ),
            //       Text(
            //         'My Diet',
            //         style: TextStyle(
            //           fontSize: 25,
            //           fontWeight: FontWeight.bold,
            //           letterSpacing: 3
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // getSizedBoxHeight(),
            // Expanded(
            //   child: ListView.separated(
            //     itemBuilder: (context,index) => Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           categoriosDiets[index],
            //           style: TextStyle(
            //             fontSize: 17,
            //             fontWeight: FontWeight.bold,
            //             letterSpacing: 1,
            //           ),
            //         ),
            //         getSizedBoxHeight(),
            //         Container(
            //           height: MediaQuery.of(context).size.width / 2 + 10,
            //           child: ListView.separated(
            //             scrollDirection: Axis.horizontal,
            //             itemBuilder: (context,ind) => Container(
            //               height: MediaQuery.of(context).size.width / 2 + 10,
            //               child: createCart(
            //                 url: imageDiets[index][ind],
            //                 name: nameDiets[index][ind],
            //                 width: MediaQuery.of(context).size.width / 2 - 30,
            //                 onTap: (){
            //                   Navigator.push(
            //                     context, 
            //                     MaterialPageRoute(
            //                       builder: (context) => Diet(nameDiet: nameDiets[index][ind], imageDiet: imageDiets[index][ind],),
            //                     ),
            //                   );
            //                 },
            //                 isRecipe: false,
            //               ),
            //             ),
            //             separatorBuilder: (contextt,ind) => getSizedBoxWidth(),
            //             itemCount: nameDiets[index].length,
            //           ),
            //         ),
            //       ],
            //     ),
            //     separatorBuilder: (context,index) => getSizedBoxHeight(),
            //     itemCount: categoriosDiets.length,
            //   ),
            // ),

            Expanded(
              child: FutureBuilder<List<ModelDiet>>(
                future: getDiet.getAllDiets(),
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List<ModelDiet>;
                    return Container(
                      height: 400,
                      child: ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (context, index) => Container(
                          alignment: Alignment.center,
                          height: 350,
                          child: createCart(
                            url: 'assets${data[index].image}',
                            name: data[index].name,
                            width: 300,
                            onTap: (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => Diet(diet: data[index],),
                                ),
                              );
                            },
                            isRecipe: false,
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
            ),
          
          ],
        ),
      ),
    );
  }

}

class GetDiet {

  Future<List<ModelDiet>> getAllDiets() async {
    List<ModelDiet> listDiets = [];

    String baseUrl = "http://$localhost:8000/diet/diet-list/";

    Uri url = Uri.parse(baseUrl);
    final response = await http.get(url,);
    if(response.statusCode == 200){
      var items = jsonDecode(response.body);

      for(var item in items){
        List<ModelDailyDiet> listDailyDiet = [];

        for (var dailyItem in item['dailyDiets']){
          List<ModelRecipes> listRecipes = [];

          for (var recipeItem in dailyItem['recipes']){
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

          ModelDailyDiet dailyObj = ModelDailyDiet(
            id: dailyItem['id'], 
            name: dailyItem['name'],
            recipes: listRecipes
          );
          listDailyDiet.add(dailyObj);
        }

        ModelDiet dietObj = ModelDiet(
          id: item['id'], 
          name: item['name'],
          image: item['image'],
          description: item['description'],
          numberOfDays: item['numberOfDays'],
          dailyDiets: listDailyDiet
        );
        listDiets.add(dietObj);
      }
      return listDiets;
    }
    else {
      throw Exception('Fail');  
    }
  }
  
}

