// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:diet_app/constants.dart';
import 'package:diet_app/modules/informationStart/diseases_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class DislikeStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  final Map<String,dynamic> info;
  const DislikeStartScreen({ 
    Key? key ,
    required this.countDash,
    required this.indexDash,
    required this.info
  }) : super(key: key);

  @override
  State<DislikeStartScreen> createState() => _DislikeStartScreenState(countOfDash: countDash, indexOfDash: indexDash, info: info);
}

class _DislikeStartScreenState extends State<DislikeStartScreen> {
  int indexOfDash;
  int countOfDash;
  List<String> arrayFood = ['Egg' ,'Fish', 'Peanuts', 'Dairy Products', 'Strawberry', 'Eggplant', 'Chicken', 'Tomato', 'Cheese', 'Pepper'];
  List<int> indexFood = [];

  Map<String,dynamic> info;
  _DislikeStartScreenState({
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
                        'What foods do you dislike and are allergic to?',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      getSizedBoxHeight(),
                      Container(
                        height: heightScreen - 250.0,
                        child: ListView(
                          children: listFood(),
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
                onPressed: (){
                  Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) {
                          // info[''] = '';
                          return DiseasesStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1, info: info);
                        }
                      ),
                    );
                }, 
              ),

            ]
          ),
        ),
      ),
    );
  }

  List<Widget> listFood(){
    List<Widget> list = [];
    for(int i=0;i<arrayFood.length;i++){
      list.add(buildFood(i));
    }
    return list;
  }

  Widget buildFood(int index){
    return GestureDetector(
      onTap: (){
        setState(() {
          if(!indexFood.contains(index)){
            indexFood.add(index);
          }
          else{
            indexFood.remove(index);
          }
        });
      },
      child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              margin: EdgeInsets.all(7.0),
              child: Text(
                arrayFood[index],
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              decoration: BoxDecoration(
                color: indexFood.contains(index)? mainColor : Colors.grey[350],
                borderRadius: BorderRadius.circular(15.0)
              ),
            ),
    );
  }


}