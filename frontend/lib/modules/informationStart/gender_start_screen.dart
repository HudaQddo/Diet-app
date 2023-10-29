// ignore_for_file: prefer_const_constructors

import 'package:diet_app/constants.dart';
import 'package:diet_app/modules/informationStart/birthday_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GenderStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  final Map<String,dynamic> info;
  const GenderStartScreen({
    Key? key ,
    required this.countDash,
    required this.indexDash,
    required this.info
  }) : super(key: key);

  @override
  State<GenderStartScreen> createState() => _GenderStartScreenState(countOfDash: countDash, indexOfDash: indexDash, info: info);
}

class _GenderStartScreenState extends State<GenderStartScreen> {
  bool isMale = true;
  int indexOfDash;
  int countOfDash;
  int? groupValue = 0;

  Map<String,dynamic> info;

  _GenderStartScreenState({
    required this.countOfDash,
    required this.indexOfDash,
    required this.info
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: getPadding(),
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              defaultPosition(indexOfDash, countOfDash),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    getSizedBoxHeight(height: 75),
                    Column(
                      children: [
                        Text(
                          'What is your gender?',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        getSizedBoxHeight(height: 25),
                        CupertinoSlidingSegmentedControl<int>(
                          backgroundColor:  CupertinoColors.white,
                          thumbColor: mainColor,
                          groupValue: groupValue,
                          children: {
                            0: buildSegment(Icons.male, 'Male'),
                            1: buildSegment(Icons.female, 'Female')
                          },
                          onValueChanged: (value){
                            setState(() {
                              groupValue = value;
                              if(value == 0){
                                isMale = true;
                              }
                              else{
                                isMale = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),

                  ],
                ),
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
                          info['gender'] = isMale? "M" : "F";
                          return BirthdayStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1, info: info);
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

  Widget buildSegment(IconData icon,String name){
    return Container(
      padding: EdgeInsets.all(40.0),
      child: Column(
        children: [
          Icon(
            icon,
            size: 50.0,
          ),
          getSizedBoxHeight(),
          Text(
            name,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0)
      ),
    );
  }

}