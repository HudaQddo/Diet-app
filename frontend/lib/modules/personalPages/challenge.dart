// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'package:diet_app/models.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class Challenge extends StatefulWidget {
  final ModelChallenge challenge;
  const Challenge({ 
    Key? key ,
    required this.challenge,
  }) : super(key: key);

  @override
  State<Challenge> createState() => _ChallengeState(challenge: challenge);
}

class _ChallengeState extends State<Challenge> {
  bool isStarted = false;
  DateTime dateStart = DateTime(2022,7,15);
  DateTime dateNow = DateTime.now();
  List<int> timer = [0,0,0,0];
  List<int> numberOfDayInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  
  ModelChallenge challenge;
  _ChallengeState({
    required this.challenge,
  });
  
  @override
  Widget build(BuildContext context) {
    timer = getTimer();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          dateNow = DateTime.now();
          timer = getTimer();
        });
      }
    });
    
    return Scaffold(
      appBar: getAppBar(title: challenge.name),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets${challenge.image}',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 2 /5,
                    fit: BoxFit.fill,
                  ),
                  getSizedBoxHeight(),
                  Text(
                    challenge.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [ 
                    if(isStarted)Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildNumber(timer[0], 'Day'),
                        getSizedBoxWidth(),
                        buildDivider(),
                        getSizedBoxWidth(),
                        buildNumber(timer[1], 'Hour'),
                        getSizedBoxWidth(),
                        buildDivider(),
                        getSizedBoxWidth(),
                        buildNumber(timer[2], 'Min'),
                        getSizedBoxWidth(),
                        buildDivider(),
                        getSizedBoxWidth(),
                        buildNumber(timer[3], 'Sec'),
                        getSizedBoxWidth(),
                      ],
                    ),
                    defaultButton(
                      function: (){
                        setState(() {
                          isStarted = !isStarted;
                          if(isStarted){
                            dateStart = DateTime.now();
                          }
                          startChallenge(challenge.id, isStarted);
                        });
                      }, 
                      text: isStarted? 'End':'Start',
                      width: MediaQuery.of(context).size.width/2,
                    ),
                  ],
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }

  getTimer(){
    Duration timer = dateNow.difference(dateStart);
    if(timer.inDays == 30){
      isStarted = false;
    }
    return [timer.inDays,timer.inHours%24,timer.inMinutes%(60), timer.inSeconds%(60)];
  }

  buildDivider() {
    return Text(':', style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 30.0,
    ),);
  }

  buildNumber(int num, String name){
    return Column(
      children: [
        Text(
          num.toString().padLeft(2, '0'),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24.0,
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 10
          ),
        ),
      ],
    );
  }

  startChallenge(int challengeID, isStart) async {
    String urlStart = "http://$localhost:8000/diet/start-challenge/$challengeID/";
    String urlEnd = "http://$localhost:8000/diet/end-challenge/$challengeID/";
    
    String url = urlStart;
    if(!isStart) {
      url = urlEnd;
    }
    String token = await getToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT $token',
      },
    );
  }
  
}
