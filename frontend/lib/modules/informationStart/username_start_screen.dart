// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, avoid_print

import 'dart:convert';

import 'package:diet_app/models.dart';
import 'package:diet_app/modules/appPage.dart';
import 'package:diet_app/modules/diaryPages/diary_page.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class UsernameStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  final Map<String,dynamic> info;
  const UsernameStartScreen({ 
    Key? key ,
    required this.countDash,
    required this.indexDash,
    required this.info
  }) : super(key: key);

  @override
  State<UsernameStartScreen> createState() => _UsernameStartScreenState(countOfDash: countDash, indexOfDash: indexDash, info: info);
}

class _UsernameStartScreenState extends State<UsernameStartScreen> {
  int indexOfDash;
  int countOfDash;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKeyUsername = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyConfirmPassword = GlobalKey<FormState>();
  bool isPass = true;
  bool isConfirmPass = true;
  
  Map<String,dynamic> info;
  _UsernameStartScreenState({
    required this.countOfDash,
    required this.indexOfDash,
    required this.info
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: getPadding(),
          color: Colors.white,
          child: Column(
            children: [
              getSizedBoxHeight(),
              Container(
                height: 8.0,
                width: countOfDash * 23.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index) => buildSlideDash(index, indexOfDash),
                  itemCount: countOfDash,
                ),
              ),
              // defaultPosition(indexOfDash, countOfDash),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: getPadding(horizontal: 0),
                    child: Column(
                      children: [
                        getSizedBoxHeight(height: 75),
                        Image.asset(
                          'assets/images/picLogo.jpg',
                          width: 200,
                          fit: BoxFit.fill,
                        ),
                        getSizedBoxHeight(),
                        Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            color: Colors.grey
                          ),
                        ),
                        getSizedBoxHeight(height: 25),
                        // username
                        Form(
                          key: formKeyUsername,
                          child: defaultInput(
                            controller: usernameController, 
                            type: TextInputType.name, 
                            onSubmit: (value){
                              setState(() {
                                formKeyUsername.currentState!.validate();
                              });
                              
                            },
                            onChange: (value){
                              setState(() {
                                formKeyUsername.currentState!.validate();
                              });
                              
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username must not be empty';
                              }
                              // must add username not valide
                              // else if(! value.endsWith('@gmail.com')){
                              //   return 'This email not valide';
                              // }
                              return null;
                            }, 
                            text: 'Username', 
                            prefix: Icons.person_pin_rounded,
                          ),
                        ),
                        getSizedBoxHeight(),
                        // email
                        Form(
                          key: formKeyEmail,
                          child: defaultInput(
                            controller: emailController, 
                            type: TextInputType.emailAddress, 
                            onSubmit: (value){
                              setState(() {
                                formKeyEmail.currentState!.validate();
                              });
                            },
                            onChange: (value){
                              setState(() {
                                formKeyEmail.currentState!.validate();
                              });
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email must not be empty';
                              }
                              else if(! value.endsWith('@gmail.com')){
                                return 'This email not valide';
                              }
                              return null;
                            }, 
                            text: 'Email', 
                            prefix: Icons.mail,
                          ),
                        ),
                        getSizedBoxHeight(),
                        // password
                        Form(
                          key: formKeyPassword,
                          child: defaultInput(
                            controller: passwordController, 
                            type: TextInputType.visiblePassword, 
                            isPassword: isPass,
                            onSubmit: (value){
                              setState(() {
                                formKeyPassword.currentState!.validate();
                              });
                            },
                            onChange: (value){
                              setState(() {
                                formKeyPassword.currentState!.validate();
                              });
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password must not be empty';
                              }
                              else if(value.length < 8){
                                return 'This password too short';
                              }
                              return null;
                            }, 
                            text: 'Password', 
                            prefix: Icons.lock,
                            suffix: isPass? Icons.visibility: Icons.visibility_off,
                            suffixPressed: (){
                              setState(() {
                                isPass = !isPass;
                              });
                            }
                          ),
                        ),
                        getSizedBoxHeight(),
                        // confirm password
                        Form(
                          key: formKeyConfirmPassword,
                          child: defaultInput(
                            controller: confirmPasswordController, 
                            type: TextInputType.visiblePassword, 
                            isPassword: isConfirmPass,
                            onSubmit: (value){
                              setState(() {
                                formKeyConfirmPassword.currentState!.validate();
                              });
                            },
                            onChange: (value){
                              setState(() {
                                formKeyConfirmPassword.currentState!.validate();
                              });
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password must not be empty';
                              }
                              else if(value != passwordController.text){
                                return 'Password does not match';
                              }
                              return null;
                            }, 
                            text: 'Confirm Password', 
                            prefix: Icons.lock,
                            suffix: isConfirmPass? Icons.visibility: Icons.visibility_off,
                            suffixPressed: (){
                              setState(() {
                                isConfirmPass = !isConfirmPass;
                              });
                            }
                          ),
                        ),
                        getSizedBoxHeight(height: 50),
                        defaultButton(
                          function: () async {
                            if(formKeyEmail.currentState!.validate() && formKeyUsername.currentState!.validate() && formKeyPassword.currentState!.validate() && formKeyConfirmPassword.currentState!.validate()){
                              // print(usernameController.text);
                              // print(emailController.text);
                              // print(passwordController.text);
                              info['username'] = usernameController.text;
                              info['email'] = emailController.text;
                              info['password'] = passwordController.text;
                              createUser(info);
                              setUser(usernameController.text, passwordController.text);
                              String token = await getToken();
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => AppPage(token: token,indexPage: 0,),
                                ),
                              );
                            }
                          }, 
                          text: 'login',
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              defaultBackButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
              ),

            ]
          ),
        ),
      ),
    );
  }


  createUser(Map<String,dynamic> info) async {
    await http.post(
      Uri.parse('http://$localhost:8000/diet/create-user/'),
      headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
      },
      body: {
          "username" : info['username'],
          "firstName": info['firstName'],
          "lastName": info['lastName'],
          "email" : info['email'],
          "password" :info['password'],
          "birthDate": info['birthDate'],
          "height": (info['height']).toString(),
          "currentWeight": (info['currentWeight']).toString(),
          "gender": info['gender'],
          "changeRate": (info['changeRate']).toString(),
          "dietType": info['dietType'],
          "activityRate": info['activityRate'],
          "ilnesses": info['ilnesses']
      },
      encoding: Encoding.getByName("utf-8")
    );
  }
}
