// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, curly_braces_in_flow_control_structures

import 'package:diet_app/modules/informationStart/height_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';


class BirthdayStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  final Map<String,dynamic> info;
  const BirthdayStartScreen({ 
    Key? key ,
    required this.countDash,
    required this.indexDash,
    required this.info
  }) : super(key: key);

  @override
  State<BirthdayStartScreen> createState() => _BirthdayStartScreenState(countOfDash: countDash, indexOfDash: indexDash, info: info);
}

class _BirthdayStartScreenState extends State<BirthdayStartScreen> {
  int indexOfDash;
  int countOfDash;
  DateTime selectedDate = DateTime.now();
  final firstDate = DateTime(2000);
  final lastDate = DateTime(2025);

  Map<String,dynamic> info;

  _BirthdayStartScreenState({
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
                        'What is your birthday?',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      getSizedBoxHeight(),
                      Text('$selectedDate'.split(' ')[0]),
                      getSizedBoxHeight(),
                      Divider(),
                      getSizedBoxHeight(),
                      defaultButton(
                        function: (){
                          _selectDate(context);
                        }, 
                        text: 'Choose Date',
                        width: 150.0
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
                          info['birthDate'] = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                          return HeightStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1, info: info);
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

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: firstDate,
        lastDate: lastDate,

      );
    if (selected != null){
      setState(() {
        selectedDate = selected;
      });
    }

  }
  
}