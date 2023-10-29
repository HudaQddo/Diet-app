// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print, curly_braces_in_flow_control_structures, no_logic_in_create_state

import 'dart:convert';
import 'dart:math';

import 'package:diet_app/constants.dart';
import 'package:diet_app/modules/personalPages/challenge.dart';
import 'package:diet_app/modules/personalPages/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models.dart';
import '../../shared/components/components.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PersonalPage extends StatefulWidget {
  final ModelUser user;
  const PersonalPage({ Key? key, required this.user }) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState(user: user);
}

class _PersonalPageState extends State<PersonalPage> {
  List<String> textBMI = ['You are underweight, and this is usually an indication of malnutrition',
  'The BMI value is within the normal height and weight, it is better for you to maintain your current weight',
  'You are overweight, you must follow a diet to lose excess weight and it is recommended to exercise to lose weight',
  'You suffer from obesity, and obesity can be treated through two basic steps: diet and exercise'];

  Map dictionary = {
    'Activity Level': ['Little', 'Moderate', 'Active', 'Very Active'],
    'Active Diet': ['Classic', 'Vegeterian', 'Vegan', 'High Protein', 'Low Fat', 'Low Carb'],
    'Diseases': ['Diabates', 'Cholesterol'],
    'Food Allergies': ['egg' ,'fish', 'peanuts', 'dairy products', 'strawberry', 'eggplant', 'chicken', 'tomato', 'cheese', 'pepper'],
    'Rate of change per week': ['0.25','0.5','0.75','1']
  };

  Map keys = {
    'Activity Level': ['LITTLE', 'LIGHT', 'MODEREATE', 'VERY'],
    'Active Diet': ['CLASSIC', 'VEGETERIAN', 'VEGAN', 'HIGH PROTEIN', 'LOW FAT', 'LOW CARB'],
    'Diseases' : ['NO','DI','CH'],
    'Food Allergies':['EGG' ,'FISH', 'PEANUTS', 'DAIRY PRODUCTS', 'STRAWBERRY', 'EGGPLANT', 'CHICKEN', 'TOMATO', 'CHEESE', 'PEPPER'],
    'Rate of change per week': ['0.25','0.5','0.75','1']
  };

  Map urls = {
    'Active Diet': 'http://$localhost:8000/diet/update-diet-type/',
    'Activity Level': 'http://$localhost:8000/diet/update-activity-rate/',
    'Height' : 'http://$localhost:8000/diet/update-height/',
    'Rate of change per week' : 'http://$localhost:8000/diet/update-change-rate/',
    'Current Weight' : 'http://$localhost:8000/diet/update-current-weight/',
    'Diseases' : '',
    'Food Allergies': ''
  };
  
  ModelUser user;
  _PersonalPageState({
    required this.user
  });
 
  @override
  Widget build(BuildContext context) {    
    return SafeArea(
      child: Container(
              padding: getPadding(),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BMI    
                    Container(
                      padding: getPadding(vertical: 0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets${user.image}',
                            height: 150,
                          ),
                          getSizedBoxWidth(),
                          Expanded(
                            child: Column(
                              children: [
                                getTitle('Your BMI: '),
                                getSizedBoxHeight(),
                                getTitle(user.BMI.toStringAsFixed(1))
                                // getSizedBoxHeight(),
                                // Text(
                                //   textBMI[0],
                                //   maxLines: 4,
                                //   textAlign: TextAlign.center,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Fixed details
                    Container(
                      padding: getPadding(vertical: 20),
                      child: getTitle("Fixed Details"),
                    ),
                    Container(
                      padding: getPadding(),
                      color: Colors.grey[300],
                      child: Column(
                        children: [
                          // Goal
                          getRow('assets/icons/goal.png', 'Goal', user.dietTarget, false),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Goal weight
                          getRow('assets/icons/weight.png', 'Goal Weight', user.goalWeight.toStringAsFixed(1), false),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Name
                          getRow('assets/icons/name.png', 'Name', user.firstName + " " + user.lastName, false),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Email
                          getRow('assets/icons/gmail.png', 'Email', user.email, false),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Gender
                          getRow('assets/icons/gender.png', 'Gender', user.gender == 'F'?'Female':'Male', false),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Birthday
                          getRow('assets/icons/birthday.png', 'Birthday', '${user.birthDate.year}-${user.birthDate.month}-${user.birthDate.day}', false),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Start weight
                          getRow('assets/icons/weight.png', 'Started Weight', '${user.startWeight}', false),
                          
                        ],
                      ),
                    ),
          
                    // Variable details
                    Container(
                      padding: getPadding(vertical: 20),
                      child: getTitle("Variable Details"),
                    ),
                    Container(
                      padding: getPadding(),
                      color: Colors.grey[300],
                      child: Column(
                        children: [
                          // Birthday
                          getRow('assets/icons/weight.png', 'Current Weight', '${user.currentWeight}', true),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Active diet
                          getRow('assets/icons/diet.png', 'Active Diet', user.dietType, true),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Activity level
                          getRow('assets/icons/activity.png', 'Activity Level', user.activityRate, true),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Height
                          getRow('assets/icons/length.png', 'Height', '${user.height}', true),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Rate of change per week
                          getRow('assets/icons/rateChange.png', 'Rate of change per week', '${user.changeRate}', true),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Diseases
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/icons/sickes.png'),
                              getSizedBoxWidth(),
                              Expanded(
                                child: Text(
                                  'Diseases:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(getListWithNumber(dictionary['Diseases'])),
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  // getAlert('Diseases');
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => EditPage(title: 'Diseases'),
                                    ),
                                  );
                                }, 
                                icon: Image.asset('assets/icons/edit.png')
                              )
                            ],
                          ),
                          getSizedBoxHeight(),
                          getLine(),
                          getSizedBoxHeight(),
                          // Food Allergies
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/icons/noFood.png'),
                              getSizedBoxWidth(),
                              Expanded(
                                child: Text(
                                  'Food Allergies:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(getListWithNumber(dictionary['Food Allergies'])),
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  // getAlert('Food Allergies');
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => EditPage(title: 'Food Allergies'),
                                    ),
                                  );
                                }, 
                                icon: Image.asset('assets/icons/edit.png')
                              )
                            ],
                          ),
                          
                        ],
                      ),
                    ),
          
                    // Slider Weight
                    Container(
                      padding: getPadding(vertical: 20),
                      child: getTitle("My progress"),
                    ),
                    Container(
                      padding: getPadding(),
                      child: Column(
                        children: [
                          Text(
                            user.dietTarget == 'Keep Fit'
                            ? 'You must keep fit'
                            : 'You must ${user.dietTarget} ${(user.currentWeight - user.goalWeight).abs()} kg!'
                          ),
                          getSizedBoxHeight(),
                          if(user.dietTarget != 'Keep Fit')Text('Just ${(((user.goalWeight-user.currentWeight).abs())/user.changeRate).ceil()} weeks until you reach your goal'),
                          if(user.dietTarget != 'Keep Fit')getSizedBoxHeight(),
                          Slider.adaptive(
                            min: 0,
                            max: max((user.currentWeight - user.startWeight).abs(),(user.goalWeight - user.startWeight).abs()),
                            value: min((user.currentWeight - user.startWeight).abs(),(user.goalWeight - user.startWeight).abs()),
                            // label: currentWeight.toString(),
                            onChanged: (value){},
                          ),
                          Container(
                            padding: getPadding(vertical: 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.grey,
                                        height: 4,
                                      ),
                                      // getSizedBoxHeight(),
                                      Text('1')
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.yellow,
                                        height: 4,
                                      ),
                                      // getSizedBoxHeight(),
                                      Text('2')
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.orange,
                                        height: 4,
                                      ),
                                      // getSizedBoxHeight(),
                                      Text('3')
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.green,
                                        height: 4,
                                      ),
                                      // getSizedBoxHeight(),
                                      Text('4')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                    // Challenges
                    Container(
                      padding: getPadding(vertical: 20),
                      child: getTitle("Challenges"),
                    ),
                    Container(
                      child: FutureBuilder<List<ModelChallenge>>(
                        future: getAllChallenges(),
                        // initialData: [],
                        builder: (context, snapshot) {
                          late final data = snapshot.data as List<ModelChallenge>;
                          if (snapshot.hasData) {
                            return Container(
                              height: 200,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index) => Container(
                                  height: 200,
                                  child: createCart(
                                      url: 'assets${data[index].image}',
                                      name: data[index].name,
                                      isRecipe: false,
                                      onTap: (){
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(
                                            builder: (context) => Challenge(challenge: data[index]),
                                          ),
                                        );
                                      }
                                    ), 
                                ),
                                separatorBuilder: (context, index) => getSizedBoxWidth(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    
                  ],
                ),
              ),
            )
          
    );

  }

  Widget getRow(image, title, value, bol) {
    return Row(
      children: [
        Image.asset(image),
        getSizedBoxWidth(),
        getExpanded(text: title + ':', isTitle: true),
        getExpanded(text: value),
        if(bol)IconButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => EditPage(title: title),
              ),
            );
          },
          icon: Image.asset('assets/icons/edit.png')
        ),
      ],
    );
  }

  Widget getExpanded({text, isTitle = false}) => Expanded(
    child: Container(
      padding: EdgeInsets.only(right: 10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isTitle ? FontWeight.w700 : FontWeight.w400,
          fontSize: isTitle ? 16 : 14,
        ),
      ),
    ),
  );

  String getListWithNumber(List<String> list) {
    String l = "";
    for(int i=0;i<list.length;i++){
      l += "${i+1}. " + list[i] + "\n";
    }
    return l;
  }

  Widget getLine(){
    return Container(
      height: 2,
      color: Colors.white,
    );
  }

  Future<List<ModelChallenge>> getAllChallenges() async {
    List<ModelChallenge> listChallenges = [];
    String baseUrl = "http://$localhost:8000/diet/challenges-list/";

    Uri url = Uri.parse(baseUrl);
    final response = await http.get(url,);
    if(response.statusCode == 200){
      var items = jsonDecode(response.body);

      for(var item in items){
        ModelChallenge challengeObj = ModelChallenge(
          id: item['id'], 
          name: item['name'],
          image: item['image'],
        );
        listChallenges.add(challengeObj);
      }
      return listChallenges;
    }
    else {
      throw Exception('Fail');  
    }
  }
  
}



