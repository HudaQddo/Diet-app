// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// Color mainColor = Color.fromARGB(255, 100, 215, 104);
// Color mainColor = Color.fromARGB(255, 176, 230, 0);
Color mainColor = Colors.green;
Color secondColor = Color.fromARGB(255, 121, 255, 190);
// Color thirdColor = Color(0xFFF2F5C8);
Color thirdColor = Colors.grey.shade300;
Color fourthColor = Color(0xFFE8E8A6);

String localhost = '192.168.225.114';
String usernameLocal = 'huda.qddo';
String passwordLocal = 'hudaqddo123456';

setUser(String user, String pass){
  usernameLocal = user;
  passwordLocal = pass;
}