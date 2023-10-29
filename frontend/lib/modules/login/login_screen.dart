// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:diet_app/constants.dart';
import 'package:diet_app/modules/appPage.dart';
import 'package:flutter/material.dart';
import '../../shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKeyUsername = GlobalKey<FormState>();
  var formKeyPassword = GlobalKey<FormState>();
  bool isPass = true;
  bool isRemmember = false;
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: getPadding(),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: Row(
                      children: [
                        Icon(Icons.navigate_before),
                        Text('Back'),
                      ],
                    ),
                  ),
                ],
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/picLogo.jpg',
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                      getSizedBoxHeight(),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                          color: Colors.grey
                        ),
                      ),
                      getSizedBoxHeight(height: 50),
                      Form(
                        key: formKeyUsername,
                        child: defaultInput(
                          controller: usernameController, 
                          type: TextInputType.name, 
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
                            return null;
                          }, 
                          text: 'Username', 
                          prefix: Icons.person_pin_rounded,
                        ),
                      ),
                      getSizedBoxHeight(),
                      Form(
                        key: formKeyPassword,
                        child: defaultInput(
                          controller: passwordController, 
                          type: TextInputType.visiblePassword, 
                          isPassword: isPass,
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
                      getSizedBoxHeight(height: 5),
                      // Remmember me
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //       value: isRemmember, 
                      //       onChanged: (value){
                      //         setState(() {
                      //           isRemmember = !isRemmember;
                      //         });
                      //       },
                      //     ),
                      //     Text("Remmember me"),
                      //   ],
                      // ),
                      getSizedBoxHeight(height: 50),
                      defaultButton(
                        function: () async {
                          if(formKeyUsername.currentState!.validate() && formKeyPassword.currentState!.validate()){
                            // print(usernameController.text);
                            // print(passwordController.text);
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
            ]
          ),
        ),
      ),
    );
  }
}
