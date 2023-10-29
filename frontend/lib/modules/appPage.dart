// ignore_for_file: unused_import, prefer_const_constructors, curly_braces_in_flow_control_structures, no_logic_in_create_state, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:diet_app/modules/personalPages/change_weight.dart';
import '../models.dart';
import 'diaryPages/diary_page.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../shared/components/components.dart';
import 'diets/diets_page.dart';
import 'favoritePages/favorite_page.dart';
import 'personalPages/personal_page.dart';
import 'recipes/recipes.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';



class AppPage extends StatefulWidget {
  final String token;
  final int indexPage;
  const AppPage({ Key? key, required this.token, required this.indexPage }) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState(token: token, indexPage:indexPage);
}

class _AppPageState extends State<AppPage> {
  DateTime dateRegister = DateTime(2022,7,20);
  DateTime dateNow = DateTime.now();
  bool onAlarm = true;

  String token;
  int indexPage;
  // GetUserProfile getUserProfile = GetUserProfile();
  _AppPageState({
    required this.token,
    required this.indexPage
  });
  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(days: 1), (Timer t) => alarmTime());
    return Scaffold(
        appBar: getAppBar(automaticallyImplyLeading: false),
        body: FutureBuilder<ModelUser>(
          future: getUserProfile(),
          builder: (context,snapshot) {
            late ModelUser user = snapshot.data as ModelUser;
            if(snapshot.hasData){
              return getPage(indexPage, user);

            }else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          }
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: mainColor,
          unselectedItemColor: Colors.grey,
          currentIndex: indexPage,
          onTap: (value){
            setState(() {
              indexPage = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Diary'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: 'Recipes'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.widgets_rounded),
              label: 'Diets'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Personal Page'
            ),
          ],
        ),
      );
  }

  Widget getPage(pageIndex, ModelUser user) {
    if (pageIndex == 0) // Diary page
      return DiaryPage(user: user,);
    else if (pageIndex == 1) // Recipes page
      return Recipes();
    else if (pageIndex == 2) // Diets page
      return DietsPage();
    else if (pageIndex == 3) // Favorites page
      return FavoritePage();
    else // Personal page
      return PersonalPage(user: user,);
  }

  alarmTime(){
    int days = 0, hours = 0, minutes = 0, seconds = 0;
    seconds = dateNow.second - dateRegister.second;
    if(seconds < 0){
      seconds += 60;
    }
    if(seconds > 0){
      minutes++;
    }

    minutes += dateNow.minute - dateRegister.minute;
    if(minutes < 0){
      minutes += 60;
    }
    if(minutes > 0){
      hours++;
    }

    hours += dateNow.hour - dateRegister.hour;
    if(hours < 0){
      hours += 24;
    }
    if(hours > 0){
      days++;
    }
    
    days += dateNow.day - dateRegister.day - 1;
    if(days < 0){
      days += 30;
    }
    if(days == 30){
      // stop challenge
    }
    onAlarm = onAlarm && (days % 7 == 0 ? true : false);
  }

  Future<ModelUser> getUserProfile() async {
    String baseUrl = "http://$localhost:8000/diet/get-my-profile/";
    Uri url = Uri.parse(baseUrl);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT $token',
      },
    );
    if(response.statusCode == 200){
      var item = jsonDecode(response.body);

      ModelUser user = ModelUser(
        id: (item['id']), 
        user_id: item['user_id'], 
        username: item['username'], 
        email: item['email'],
        password: item['password'],
        firstName: item['firstName'],
        lastName: item['lastName'],
        birthDate: DateFormat('yyyy-mm-dd').parse(item['birthDate']),
        height: (item['height']),
        createTime: item['createTime'],
        startWeight: (item['startWeight']),
        currentWeight: (item['currentWeight']),
        gender: item['gender'],
        goalWeight: item['goalWeight'],
        BMI: (item['BMI']),
        changeRate: (item['changeRate']),
        dietTarget: item['dietTarget'],
        dietType: item['dietType'],
        activityRate: item['activityRate'],
        ilnesses: item['ilnesses'],
        // challenges: item['challenges'],
        // exercises: item['exercises'],
        // diet: item['diet'],
        // dairy: item['dairy'],
        // favorite: item['favorite'],
        // foodAllergies: item['foodAllergies'],
        image: item['image'],
      );
      return user;
    }
    else {
      throw Exception('Fail');  
    }

  }
  
}
