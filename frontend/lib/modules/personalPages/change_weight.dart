// ignore_for_file: prefer_const_constructors

import 'package:diet_app/modules/appPage.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class ChangeWeight extends StatefulWidget {
  const ChangeWeight({ Key? key }) : super(key: key);

  @override
  State<ChangeWeight> createState() => _ChangeWeightState();
}

class _ChangeWeightState extends State<ChangeWeight> {
  // TextEditingController weightController = TextEditingController();
  int indexOfListNormal = 0;
  int shortestWeightNormal = 40;
  int tallestWeightNormal = 120;
  int indexOfListDecimal = 0;
  int shortestWeightDecimal = 0;
  int tallestWeightDecimal = 9;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: getPadding(),
        color: Colors.white,
        child: Column(
          children: [
            getSizedBoxHeight(height: 100),
            getTitle('What is your current weight?'),
            getSizedBoxHeight(),
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
            Expanded(child: getSizedBoxHeight()),
            defaultButton(
              function: (){
                
                // Navigator.push(
                //   context, 
                //   MaterialPageRoute(
                //     builder: (context) => AppPage(token: token,),
                //   ),
                // );
              }, 
              text: 'Save',
              width: 100
            ),
            getSizedBoxHeight()
          ],
        ),
      ),
    );
  }
}