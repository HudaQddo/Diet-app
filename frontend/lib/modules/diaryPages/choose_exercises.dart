// ignore_for_file: prefer_const_constructors, unused_import, avoid_print

import 'dart:convert';

import 'package:diet_app/constants.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../appPage.dart';

class ChooseExercises extends StatefulWidget {
  const ChooseExercises({ Key? key }) : super(key: key);

  @override
  State<ChooseExercises> createState() => ChooseExercisesState();
}

class ChooseExercisesState extends State<ChooseExercises> {
  TextEditingController walkController = TextEditingController();
  TextEditingController runController = TextEditingController();

  bool isFastWalk = false;
  bool isWalk = false;
  bool isRun = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add exersice'),
      ),
      body: SafeArea(
        child: Container(
          padding: getPadding(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: getPadding(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icons/walk.png'),
                          Text('Walking general'),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isWalk = !isWalk;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.keyboard_arrow_down)
                        )
                      )
                    ],
                  ),
                ),
                getSizedBoxHeight(),
                if(isWalk)Container(
                  padding: getPadding(),
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitle('How many minutes did you walk?'),
                      getSizedBoxHeight(),
                      TextFormField(
                        controller: walkController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Time in minutes',
                          prefixIcon: Icon(Icons.timer),
                        ),
                      ),
                      getSizedBoxHeight(),
                      getTitle('Walking type:'),
                      Row(
                        children: [
                          Checkbox(
                            value: !isFastWalk,
                            onChanged: (bool? value) {
                              setState(() {
                                isFastWalk = false;
                              });
                            },
                          ),
                          getSizedBoxWidth(),
                          Text('Slow walk')
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isFastWalk,
                            onChanged: (bool? value) {
                              setState(() {
                                isFastWalk = true;
                              });
                            },
                          ),
                          getSizedBoxWidth(),
                          Text('Fast walk')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          defaultButton(
                            width: 100,
                            function: () async {
                                int time = int.parse(walkController.text.toString());
                                print("time $time isFastWalk $isFastWalk");
                                startExercise(isFastWalk?"Quick Walk":"Slow Walk", time);

                                var token = await getToken();
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context){
                                      return AppPage(token: token,indexPage: 0,);
                                    },
                                  ),
                                );
                              
                            }, 
                            text: 'Add',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                getSizedBoxHeight(),
                Container(
                  padding: getPadding(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icons/run.png'),
                          Text('Running general'),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isRun = !isRun;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.keyboard_arrow_down)
                        )
                      )
                    ],
                  ),
                ),
                getSizedBoxHeight(),
                if(isRun)Container(
                  padding: getPadding(),
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitle('How many minutes did you Run?'),
                      getSizedBoxHeight(),
                      TextFormField(
                        controller: runController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Time in minutes',
                          prefixIcon: Icon(Icons.timer),
                        ),
                      ),
                      getSizedBoxHeight(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          defaultButton(
                            width: 100,
                            function: () async {
                                int time = int.parse(walkController.text.toString());
                                startExercise("Run", time);

                                var token = await getToken();
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context){
                                      return AppPage(token: token,indexPage: 0,);
                                    },
                                  ),
                                );
                              
                            }, 
                            text: 'Add',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  startExercise(String exerciseName, int length) async {
  String url = "http://$localhost:8000/diet/start-excercise/";
  
  String token = await getToken();
  var response = await http.post(
      Uri.parse(url),
      headers: {
        // 'Content-Type': 'application/json',
        // 'Accept': 'application/json',
        'Authorization': 'JWT $token',
      },
      body: {
        "exerciseName":exerciseName,
        "lengthOfTime":length.toString()
      },
      encoding: Encoding.getByName("utf-8")
    );
    print(response.body);
}


}