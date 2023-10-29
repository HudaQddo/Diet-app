// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:diet_app/constants.dart';
import 'package:diet_app/modules/informationStart/active_start_screen.dart';
import 'package:diet_app/modules/informationStart/birthday_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DietStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  final Map<String,dynamic> info;
  const DietStartScreen({ 
    Key? key,
    required this.countDash,
    required this.indexDash,
    required this.info
  }) : super(key: key);

  @override
  State<DietStartScreen> createState() => _DietStartScreenState(countOfDash: countDash, indexOfDash: indexDash, info: info);
}

class _DietStartScreenState extends State<DietStartScreen> {
  int indexOfDash;
  int countOfDash;
  List<String> arrayDiet = ['Classic', 'Low Carb', 'Low fat', 'High protein', 'Vegetarian', 'Vegan'];
  List<String> key = ['CLASSIC' , 'LOW CARB' , 'LOW FAT' , 'HIGH PROTEIN' , 'VEGETARIAN' , 'VEGAN'];
  int numOfDiet = -1;

  Map<String,dynamic> info;
  _DietStartScreenState({
    required this.countOfDash,
    required this.indexOfDash,
    required this.info
  });
  

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: getPadding(),
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              defaultPosition(indexOfDash, countOfDash),
              Column(
                children: [
                  getSizedBoxHeight(height: 75),
                  Column(
                    children: [
                      Text(
                        'Pick your diet',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      getSizedBoxHeight(),
                      Container(
                        height: heightScreen - 250.0,
                        child: ListView(
                          children: listDiets(),
                        ),
                      ),
                    
                    ],
                  ),
                ],
              ),
              defaultBackButton(
                onPressed: (){
                          Navigator.pop(context);
                        }, 
              ),
              defaultNextButton(
                onPressed: numOfDiet > -1 ? (){
                          Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) {
                                  info['dietType'] = key[numOfDiet];
                                  return ActiveStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1, info: info);
                                }
                              ),
                            );
                        } : null, 
              ),

            ]
          ),
        ),
      ),
    );
  }

  List<Widget> listDiets(){
    List<Widget> list = [];
    for(int i=0;i<arrayDiet.length;i++){
      list.add(buildDiet(i));
    }
    return list;
  }

  Widget buildDiet(int index){
    return GestureDetector(
            onTap: (){
              setState(() {
                numOfDiet = index;
              });
            },
            child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    margin: EdgeInsets.all(7.0),
                    width: double.maxFinite,
                    child: Text(
                      arrayDiet[index],
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: numOfDiet == index? mainColor : Colors.grey[350],
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                  ),
          );
  }

}