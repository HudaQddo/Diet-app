// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:diet_app/constants.dart';
import 'package:diet_app/modules/informationStart/dislike_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class ActiveStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  final Map<String,dynamic> info;
  const ActiveStartScreen({ 
    Key? key ,
    required this.countDash,
    required this.indexDash,
    required this.info
  }) : super(key: key);

  @override
  State<ActiveStartScreen> createState() => _ActiveStartScreenState(countOfDash: countDash, indexOfDash: indexDash, info: info);
}

class _ActiveStartScreenState extends State<ActiveStartScreen> {
  int indexOfDash;
  int countOfDash;
  List<List<String>> arrayActives = [['Little or No Activity', 'Mostly sitting through the day (eg. Desk Job, Bank Teller'], 
  ['Lightly Active', 'Mostly Standing through the day (eg. Sales Associate, Teacher'], 
  ['Moderately Active', 'Mostly walking or doing physical activities through the day (eg. Tour Guide, Waiter'], 
  ['Very Active', 'Mostly doing heavy physical activites through the day (eg. Gym Instructor, Construction Worker']];
  List <String> key = ['LITTLE', 'LIGHT', 'MODEREATE' , 'VERY' ];
  List<IconData> arrayIcons = [Icons.event_seat, Icons.boy, Icons.directions_walk, Icons.directions_run];
  int numOfActive = -1;

  Map<String,dynamic> info;
  _ActiveStartScreenState({
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
                        'How active are you?',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      getSizedBoxHeight(height: 25),
                      Column(
                        children: listActives(),
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
                onPressed: numOfActive > -1 ? (){
                          Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) {
                                  info['activityRate'] = key[numOfActive];
                                  return DislikeStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1, info: info);
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

  List<Widget> listActives(){
    List<Widget> list = [];
    for(int i=0;i<arrayActives.length;i++){
      list.add(buildActive(i));
    }
    return list;
  }

  Widget buildActive(int ind){
    return GestureDetector(
      onTap: (){
        setState(() {
          numOfActive = ind;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        margin: EdgeInsets.all(7.0),
        width: double.maxFinite,
        child: Row(
          children: [
            Icon(arrayIcons[ind]),
            getSizedBoxWidth(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    arrayActives[ind][0],
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  getSizedBoxHeight(),
                  Text(
                    arrayActives[ind][1],
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: numOfActive == ind? mainColor : Colors.grey[350],
          borderRadius: BorderRadius.circular(15.0)
        ),
      ),
    );
  }

}