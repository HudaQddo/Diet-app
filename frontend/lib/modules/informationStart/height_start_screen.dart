// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:diet_app/modules/informationStart/current_weigth_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class HeightStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  final Map<String,dynamic> info;
  const HeightStartScreen({ 
    Key? key ,
    required this.countDash,
    required this.indexDash,
    required this.info
  }) : super(key: key);

  @override
  State<HeightStartScreen> createState() => _HeightStartScreenState(countOfDash: countDash, indexOfDash: indexDash, info:info);
}

class _HeightStartScreenState extends State<HeightStartScreen> {
  int indexOfDash;
  int countOfDash;
  int indexOflist = 0;
  int shortestHeight = 140;
  int tallestHeight = 220;

  Map<String,dynamic> info;

  _HeightStartScreenState({
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
                          'How tall are you?',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        getSizedBoxHeight(height: 25),
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
                        info['height'] = shortestHeight + indexOflist;
                        return CurrentWeigthStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1, info: info);
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