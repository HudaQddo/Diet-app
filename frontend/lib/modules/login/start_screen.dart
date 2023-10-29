// ignore_for_file: prefer_const_constructors

import 'package:diet_app/modules/informationStart/name_start_screen.dart';
import 'package:diet_app/modules/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../shared/components/components.dart';
import 'package:http/http.dart' as http;

class StartScreen extends StatefulWidget {
  const StartScreen({ Key? key }) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: getPadding(),
          color: Colors.white,
          alignment: AlignmentDirectional.center,
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/newLogo.png',
                  width: MediaQuery.of(context).size.width - 100,
                ),
              ),
              defaultButton(
                text: 'get started',
                function: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => NameStartScreen(countDash: 11, indexDash: 1),
                    ),
                  );
                },
                width: 200.0
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a member?',
                  ),
                  getSizedBoxWidth(),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    }, 
                    child: Text(
                      'sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
    
                ],
              ),
              getSizedBoxHeight(height: 50),
            ],
          ),
        ),
      ),
    );
  }

}