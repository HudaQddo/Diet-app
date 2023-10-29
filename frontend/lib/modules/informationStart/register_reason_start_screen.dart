// ignore_for_file: prefer_const_constructors

import 'package:diet_app/constants.dart';
import 'package:diet_app/modules/informationStart/diet_start_screen.dart';
import 'package:diet_app/modules/informationStart/target_weigth_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class RegisterReasonStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  const RegisterReasonStartScreen({ 
    Key? key , 
    required this.countDash, 
    required this.indexDash
  }) : super(key: key);

  @override
  State<RegisterReasonStartScreen> createState() => _RregisterReasonStateStartScreen(countOfDash: countDash, indexOfDash: indexDash);
}

class _RregisterReasonStateStartScreen extends State<RegisterReasonStartScreen> {
  int indexOfDash;
  int countOfDash;
  List<String> arrayReasons = ['Increase Weight', 'Lose Weight', 'Keep Fit'];
  List<IconData> arrayIcons = [Icons.add, Icons.remove, Icons.fitness_center];
  int numOfReason = -1;

  _RregisterReasonStateStartScreen({
    required this.countOfDash, 
    required this.indexOfDash
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
                        'what do you want to do?',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      getSizedBoxHeight(height: 25),
                      Column(
                        children: listReasons(),
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
                onPressed: numOfReason > -1 ? (){
                          // Navigator.push(
                          //     context, 
                          //     MaterialPageRoute(
                          //       builder: (context) => numOfReason != 2 ? TargetWeigthStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1) : DietStartScreen(countDash: countOfDash - 2, indexDash: indexOfDash + 1),
                          //     ),
                          //   );
                        } : null, 
              ),
            ]
          ),
        ),
      ),
    );
  }

  List<Widget> listReasons(){
    List<Widget> list = [];
    for(int i=0;i<arrayReasons.length;i++){
      list.add(buildReason(i));
    }
    return list;
  }

  Widget buildReason(int index){
    return GestureDetector(
      onTap: (){
        setState(() {
          numOfReason = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        margin: EdgeInsets.all(7.0),
        width: double.maxFinite,
        child: Row(
          children: [
            Icon(arrayIcons[index]),
            getSizedBoxWidth(),
            Text(
              arrayReasons[index],
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: numOfReason == index? mainColor : Colors.grey[350],
          borderRadius: BorderRadius.circular(15.0)
        ),
      ),
    );
  }

}