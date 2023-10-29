// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:diet_app/modules/informationStart/username_start_screen.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class DiseasesStartScreen extends StatefulWidget {
  final int countDash;
  final int indexDash;
  final Map<String,dynamic> info;
  const DiseasesStartScreen({ 
    Key? key ,
    required this.countDash,
    required this.indexDash,
    required this.info
  }) : super(key: key);

  @override
  State<DiseasesStartScreen> createState() => _DiseasesStartScreenState(countOfDash: countDash, indexOfDash: indexDash, info: info);
}

class _DiseasesStartScreenState extends State<DiseasesStartScreen> {
  int indexOfDash;
  int countOfDash;
  List<String> arrayMedical = ['Diabetes', 'Cholesterol', 'Hypertension' ,'Kidney disease'];
  List<int> indexMedical = [];
  List<String> key = [ 'NO' , 'DI' , 'CH'];
  Map<String,dynamic> info;
  _DiseasesStartScreenState({
    required this.countOfDash,
    required this.indexOfDash,
    required this.info
  });

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
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
                        'Any Medical Condition we should be aware of?',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      getSizedBoxHeight(height: 25),
                      Container(
                        height: heightScreen - 250.0,
                        child: ListView(
                          children: listMedical(),
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
                onPressed: (){
                  Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) {
                          info['ilnesses'] = 'NO';
                          return UsernameStartScreen(countDash: countOfDash, indexDash: indexOfDash + 1, info: info);
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

  List<Widget> listMedical(){
    List<Widget> list = [];
    for(int i=0;i<arrayMedical.length;i++){
      list.add(buildMedical(i));
    }
    return list;
  }

  Widget buildMedical(int index){
    return GestureDetector(
            onTap: (){
              setState(() {
                if(!indexMedical.contains(index)){
                  indexMedical.add(index);
                }
                else{
                  indexMedical.remove(index);
                }
              });
            },
            child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    margin: EdgeInsets.all(7.0),
                    child: Text(
                      arrayMedical[index],
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: indexMedical.contains(index)? mainColor : Colors.grey[350],
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                  ),
          );
  }

}