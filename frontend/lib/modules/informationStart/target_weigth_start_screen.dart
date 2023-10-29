// ignore_for_file: prefer_const_constructors

import 'package:diet_app/modules/informationStart/rate_change_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class TargetWeigthStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  const TargetWeigthStartScreen({ Key? key , required this.countDash, required this.indexDash}) : super(key: key);

  @override
  State<TargetWeigthStartScreen> createState() => _TargetWeigthStartScreen(countOfDash: countDash, indexOfDash: indexDash);
}

class _TargetWeigthStartScreen extends State<TargetWeigthStartScreen> {
  int indexOfDash;
  int countOfDash;
  // int _selectedItemIndex = 0;
  int indexOfListNormal = 0;
  int shortestWeightNormal = 40;
  int tallestWeightNormal = 120;
  int indexOfListDecimal = 0;
  int shortestWeightDecimal = 0;
  int tallestWeightDecimal = 9;

  _TargetWeigthStartScreen({required this.countOfDash, required this.indexOfDash});

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
              Column(
                children: [
                  getSizedBoxHeight(height: 75),
                  Text(
                    'What is the target weight you want to reach?',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  getSizedBoxHeight(height: 25),
                  Row(
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
                              indexOfListNormal = index;
                            });
                          },
                          physics: FixedExtentScrollPhysics(),
                          children: getListOfNumber(shortestWeightNormal, tallestWeightNormal, indexOfListNormal + shortestWeightNormal),
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
                              indexOfListDecimal = index;
                            });
                          },
                          physics: FixedExtentScrollPhysics(),
                          children: getListOfNumber(shortestWeightDecimal, tallestWeightDecimal, indexOfListDecimal + shortestWeightDecimal),
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
                ],
              ),
              
              defaultBackButton(
                onPressed: (){
                          Navigator.pop(context);
                        }, 
              ),
              defaultNextButton(
                onPressed: (){
                            // Navigator.push(
                            //   context, 
                            //   MaterialPageRoute(
                            //     builder: (context) => RateChangeStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1),
                            //   ),
                            // );
                          }, 
              ),

            ]
          ),
        ),
      ),
    );
  }

}