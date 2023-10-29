// ignore_for_file: no_logic_in_create_state, prefer_const_constructors, avoid_unnecessary_containers, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:diet_app/modules/appPage.dart';
import 'package:diet_app/modules/personalPages/personal_page.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models.dart';

class EditPage extends StatefulWidget {
  final String title;
  const EditPage({ Key? key, required this.title}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState(title: title);
}

class _EditPageState extends State<EditPage> {
  int indexSelected = -1;
  int indexOflist = 0;
  int shortestHeight = 140;
  int tallestHeight = 220;

  int indexOflistNormal = 0;
  int shortestWeightNormal = 40;
  int tallestWeightNormal = 120;
  int indexOflistDecimal = 0;
  int shortestWeightDecimal = 0;
  int tallestWeightDecimal = 9;

  Map dictionary = {
    'Activity Level': ['Little or No Activity', 'Lightly Active', 'Moderately Active', 'Very Active'],
    'Active Diet': ['Classic', 'Vegeterian', 'Vegan', 'High Protein', 'Low Fat', 'Low Carb'],
    'Diseases': ['Diabates', 'Cholesterol'],
    'Food Allergies': ['Egg' ,'Fish', 'Peanuts', 'Dairy Products', 'Strawberry', 'Eggplant', 'Chicken', 'Tomato', 'Cheese', 'Pepper'],
    'Rate of change per week': ['0.25','0.5','0.75','1']
  };

  Map keys = {
    'Activity Level': ['LITTLE', 'LIGHT', 'MODEREATE', 'VERY'],
    'Active Diet': ['CLASSIC', 'VEGETERIAN', 'VEGAN', 'HIGH PROTEIN', 'LOW FAT', 'LOW CARB'],
    'Diseases' : ['NO','DI','CH'],
    'Food Allergies':['EGG' ,'FISH', 'PEANUTS', 'DAIRY PRODUCTS', 'STRAWBERRY', 'EGGPLANT', 'CHICKEN', 'TOMATO', 'CHEESE', 'PEPPER'],
    'Rate of change per week': [0.25,0.5,0.75,1]
  };

  Map urls = {
    'Active Diet': 'http://$localhost:8000/diet/update-diet-type/',
    'Activity Level': 'http://$localhost:8000/diet/update-activity-rate/',
    'Height' : 'http://$localhost:8000/diet/update-height/',
    'Rate of change per week' : 'http://$localhost:8000/diet/update-change-rate/',
    'Current Weight' : 'http://$localhost:8000/diet/update-current-weight/',
    'Diseases' : '',
    'Food Allergies': ''
  };
  

  String title;
  _EditPageState({
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: title),
      body: SafeArea(
        child: Container(
          padding: getPadding(),
          child: Column(
            children: [
              if(title != 'Current Weight' && title != 'Height')Expanded(
                child: ListView.builder(
                  itemCount: dictionary[title].length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          indexSelected = index;
                        });
                      },
                      child: Container(
                        padding: getPadding(),
                        margin: getPadding(vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: indexSelected == index ? mainColor : Colors.grey.shade300,
                        ),
                        child: Text(dictionary[title][index]),
                      ),
                    );
                  },
                ),
              ),
              if(title == 'Current Weight')Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 250,
                      child: ListWheelScrollView(
                        useMagnifier: true,
                        magnification: 1.5,
                        diameterRatio: 3,
                        itemExtent: 50,
                        squeeze: 0.5,
                        onSelectedItemChanged: (index){
                          setState(() {
                            indexOflistNormal = index;
                          });
                        },
                        physics: FixedExtentScrollPhysics(),
                        children: getListOfNumber(shortestWeightNormal, tallestWeightNormal, indexOflistNormal + shortestWeightNormal),
                      ),
                    ),
                    Text(
                      '.',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 250,
                      child: ListWheelScrollView(
                        useMagnifier: true,
                        magnification: 1.5,
                        diameterRatio: 3,
                        itemExtent: 50,
                        squeeze: 0.5,
                        onSelectedItemChanged: (index){
                          setState(() {
                            indexOflistDecimal = index;
                          });
                        },
                        physics: FixedExtentScrollPhysics(),
                        children: getListOfNumber(shortestWeightDecimal, tallestWeightDecimal, indexOflistDecimal + shortestWeightDecimal),
                      ),
                    ),
                    Text(
                      'KG',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              if(title == 'Height') Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 250,
                      child: ListWheelScrollView(
                        useMagnifier: true,
                        magnification: 1.5,
                        diameterRatio: 3,
                        itemExtent: 50,
                        squeeze: 0.5,
                        onSelectedItemChanged: (index){
                          setState(() {
                            indexOflist = index;
                          });
                        },
                        physics: FixedExtentScrollPhysics(),
                        children: getListOfNumber(shortestHeight, tallestHeight, indexOflist + shortestHeight),
                      ),
                    ),
                    getSizedBoxHeight(),
                    Text(
                      'CM',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      if(title != 'Current Weight' && title != 'Height'){
                        var str = keys[title][indexSelected];
                        update(title, str);
                      }
                      else if(title == 'Current Weight'){
                        double weight = indexOflistNormal + shortestWeightNormal + (indexOflistDecimal + shortestWeightDecimal)*0.1;
                        update(title, weight);
                      }
                      else{
                        int height = indexOflist + shortestHeight;
                        update(title, height);
                      }
                      var token = await getToken();
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context){
                            return AppPage(token: token,indexPage: 4,);
                          },
                        ),
                      );
                    }, 
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
              getSizedBoxHeight()
            ],
          ),
        ),
      ),
    );
  }

  update(String title, value) async {
    var token = await getToken();
    String url = urls[title];
    String key = "";
    if(title == "Height")
      key = 'height';
    if(title == "Active Diet")
      key = 'dietType';
    if(title == "Activity Level")
      key = 'activityRate';
    if(title == "Rate of change per week")
      key = 'changeRate';
    if(title == "Current Weight")
      key = 'currentWeight';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        // 'Content-Type': 'application/json',
        // 'Accept': 'application/json',
        'Authorization': 'JWT $token',
      },
      body: {
        key: value.toString()
      },
      // encoding: Encoding.getByName("utf-8")
    );
  }


}