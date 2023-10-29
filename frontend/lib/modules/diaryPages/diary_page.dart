// ignore_for_file: prefer_const_constructors, unused_import, no_logic_in_create_state, avoid_print

import 'dart:convert';

import 'package:diet_app/constants.dart';
import 'package:diet_app/modules/diaryPages/choose_exercises.dart';
import 'package:diet_app/modules/diaryPages/choose_meal.dart';
import 'package:diet_app/modules/diaryPages/water_page.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import '../../models.dart';
import 'package:http/http.dart' as http;

class DiaryPage extends StatefulWidget {
  final ModelUser user;
  const DiaryPage({ Key? key, required this.user }) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPage(user: user);
}

class _DiaryPage extends State<DiaryPage> {
  // double calorieBurned = 500;
  // double calorieEaten = 1520;
  // double calorieLeft = 780;
  int numberOfCupWater = 0;
  double amountWater = 2.3;
  int sizeCup = 200;

  ModelUser user;
  _DiaryPage({
    required this.user
  });
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: getPadding(),
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              getTitle("Diary"),
              getSizedBoxHeight(),
              // Details Calories
              Container(
                padding: getPadding(),
                alignment: Alignment.center,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: FutureBuilder<List<double>>(
                  future: getTotalCalories(),
                  builder:(context, snapshot) {
                    late List<double> calories = snapshot.data as List<double>;
                    if(snapshot.hasData){
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${calories[0].ceil()}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Text(
                                  "Eaten",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                )
                              ],
                            ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(width: 5, color: mainColor),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${calories[1].ceil()}',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Text(
                                  "kcal Left",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${calories[2].ceil()}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Text(
                                  "Burned",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                )
                              ],
                            ),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              getSizedBoxHeight(),
              // Add Water
              Container(
                padding: getPadding(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: fourthColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset('assets/icons/water.png'),
                            Text(
                              '$numberOfCupWater',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ]
                        ),
                        getSizedBoxWidth(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add water',
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            getSizedBoxHeight(height: 5),
                            Text('You should drink ${(amountWater*1000/sizeCup).ceil()} Cups'),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  if (numberOfCupWater > 0)
                                    numberOfCupWater -= 1;
                                });
                              }, 
                              icon: Icon(Icons.remove),
                            ),
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  numberOfCupWater += 1;
                                });
                              }, 
                              icon: Icon(Icons.add),
                            ),
                            // IconButton(
                            //   onPressed: (){
                            //     Navigator.push(
                            //       context, 
                            //       MaterialPageRoute(
                            //         builder: (context) => WaterPage(),
                            //       ),
                            //     );
                            //   }, 
                            //   icon: Icon(Icons.settings)
                            // ),
                            
                          ],
                        ),
                        // Image.asset('assets/icons/waterBOT.png'),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeCup += 50;
                              if(sizeCup > 300){
                                sizeCup = 200;
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Image.asset('assets/icons/waterBOT.png'),
                              Text('$sizeCup'),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              getSizedBoxHeight(),
              // Add Breakfast
              Container(
                padding: getPadding(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: fourthColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/icons/breakfast.png'),
                        getSizedBoxWidth(),
                        Text(
                          'Add Breakfast',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => ChooseMeal(typeMeal: "Breakfast",),
                          ),
                        );
                      }, 
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              getSizedBoxHeight(),
              // Add Lunch
              Container(
                padding: getPadding(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: fourthColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/icons/lunch.png'),
                        getSizedBoxWidth(),
                        Text(
                          'Add Lunch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => ChooseMeal(typeMeal: "Lunch",),
                          ),
                        );
                      }, 
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              getSizedBoxHeight(),
              // Add Dinner
              Container(
                padding: getPadding(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: fourthColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/icons/dinner.png'),
                        getSizedBoxWidth(),
                        Text(
                          'Add Dinner',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => ChooseMeal(typeMeal: "Dinner",),
                          ),
                        );
                      }, 
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              getSizedBoxHeight(),
              // Add Snack
              Container(
                padding: getPadding(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: fourthColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/icons/snack.png'),
                        getSizedBoxWidth(),
                        Text(
                          'Add Snack',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => ChooseMeal(typeMeal: "Snack",),
                          ),
                        );
                      }, 
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              getSizedBoxHeight(),
              // Add Exercise
              Container(
                padding: getPadding(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: fourthColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/icons/exercise.png'),
                        getSizedBoxWidth(),
                        Text(
                          'Add Exercise',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => ChooseExercises(),
                          ),
                        );
                      }, 
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              getSizedBoxHeight(),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<double>> getTotalCalories() async {
    String url = "http://$localhost:8000/diet/get-total-calories/";
    String token = await getToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT $token',
      },
    );
    double total = jsonDecode(response.body)["totalCalories"];
    double eaten = jsonDecode(response.body)["eatenCalories"];
    double burned = jsonDecode(response.body)["burnetCalories"];
    double left = total - eaten + burned;
    // print("total: $total , eaten: $eaten , burned: $burned , left: $left");
    return [eaten, left, burned];
  }
  
}