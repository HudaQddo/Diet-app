// ignore_for_file: prefer_const_constructors

import 'package:diet_app/modules/informationStart/rate_change_start_screen.dart';
import 'package:diet_app/modules/informationStart/register_reason_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';


class CurrentWeigthStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  final Map<String,dynamic> info;
  const CurrentWeigthStartScreen({ 
    Key? key ,
    required this.countDash,
    required this.indexDash,
    required this.info
  }) : super(key: key);

  @override
  State<CurrentWeigthStartScreen> createState() => _CurrentWeigthStartScreen(countOfDash: countDash, indexOfDash: indexDash, info: info);
}

class _CurrentWeigthStartScreen extends State<CurrentWeigthStartScreen> {
  int indexOfDash;
  int countOfDash;
  int indexOflistNormal = 0;
  int shortestWeightNormal = 40;
  int tallestWeightNormal = 120;
  int indexOflistDecimal = 0;
  int shortestWeightDecimal = 0;
  int tallestWeightDecimal = 9;

  Map<String,dynamic> info;

  _CurrentWeigthStartScreen({
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
              Column(
                children: [
                  getSizedBoxHeight(height: 75),
                  Text(
                    'What is your current weight?',
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
                        info['currentWeight'] = shortestWeightNormal + indexOflistNormal + ((shortestWeightDecimal + indexOflistDecimal)*0.1);
                        return RateChangeStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1, info: info);
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

}