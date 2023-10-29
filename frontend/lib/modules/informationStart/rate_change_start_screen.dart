// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:diet_app/modules/informationStart/diet_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class RateChangeStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  final Map<String,dynamic> info;
   RateChangeStartScreen({
    Key? key,
    required this.countDash,
    required this.indexDash,
    required this.info
  }) : super(key: key);

  @override
  State<RateChangeStartScreen> createState() => _RateChangeStartScreenState(countOfDash: countDash, indexOfDash: indexDash, info: info);
}

class _RateChangeStartScreenState extends State<RateChangeStartScreen> {
  int indexOfDash;
  int countOfDash;
  double valueSlider = 0.25;

  Map<String,dynamic> info;
  _RateChangeStartScreenState({
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
                  Column(
                    children: [
                      Text(
                        'If you were to lose or gain weight, how fast do you want to reach your goal?',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      getSizedBoxHeight(height: 25),
                      Slider.adaptive(
                        min: 0.25,
                        max: 1,
                        value: valueSlider,
                        divisions: 3, 
                        onChanged: (value){
                          setState(() {
                            valueSlider = value;
                          });
                        },
                      ),
                      getSizedBoxHeight(),
                      Text(
                        '$valueSlider KG',
                        style:  TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      getSizedBoxHeight(),
                      Text(
                        'Per week',
                        style: TextStyle(
                          fontSize: 15.0,
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
                        info['changeRate'] = valueSlider;
                        return DietStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1, info: info);
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