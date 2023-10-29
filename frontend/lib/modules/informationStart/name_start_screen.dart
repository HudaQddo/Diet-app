// ignore_for_file: prefer_const_constructors

import 'package:diet_app/modules/informationStart/gender_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class NameStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  const NameStartScreen({
    Key? key,
    required this.countDash,
    required this.indexDash,
  }) : super(key: key);

  @override
  State<NameStartScreen> createState() => _NameStartScreenState(countOfDash: countDash, indexOfDash: indexDash);
}

class _NameStartScreenState extends State<NameStartScreen> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var firstNameKey = GlobalKey<FormState>();
  var lastNameKey = GlobalKey<FormState>();
  int indexOfDash;
  int countOfDash;
  bool activeNext = false;

  Map<String,dynamic> info = {};

  _NameStartScreenState({
    required this.countOfDash,
    required this.indexOfDash,
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
                        'What is your name?',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      getSizedBoxHeight(height: 25),
                      Form(
                        key: firstNameKey,
                        child: defaultInput(
                          controller: firstNameController, 
                          type: TextInputType.name, 
                          onSubmit: (value){
                            setState(() {
                              firstNameKey.currentState!.validate();
                            });
                          },
                          onChange: (value){
                            setState(() {
                              firstNameKey.currentState!.validate();
                            });
                          },
                          validate: (value){
                            if(value == null || value.isEmpty){
                              activeNext = false;
                              return 'Please enter your first name!';
                            }
                            activeNext = true;
                            return null;
                          }, 
                          text: 'First Name', 
                          prefix: Icons.person,
                        ),
                      ),
                      getSizedBoxHeight(),
                      Form(
                        key: lastNameKey,
                        child: defaultInput(
                          controller: lastNameController, 
                          type: TextInputType.name, 
                          onSubmit: (value){
                            setState(() {
                              lastNameKey.currentState!.validate();
                            });
                          },
                          onChange: (value){
                            setState(() {
                              lastNameKey.currentState!.validate();
                            });
                          },
                          validate: (value){
                            if(value == null || value.isEmpty){
                              activeNext = false;
                              return 'Please enter your last name!';
                            }
                            activeNext = true;
                            return null;
                          }, 
                          text: 'Last Name', 
                          prefix: Icons.person,
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
                onPressed: activeNext? (){
                  if(firstNameKey.currentState!.validate() && lastNameKey.currentState!.validate()){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) {
                          info['firstName'] = firstNameController.text;
                          info['lastName'] = lastNameController.text;
                          return GenderStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1, info: info);
                        }
                      ),
                    );
                  }
                } : null, 
              ),

            ]
          ),
        ),
      ),
    );
  }

}