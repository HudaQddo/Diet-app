// ignore_for_file: prefer_const_constructors

import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({ Key? key }) : super(key: key);

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  double sliderValue = 2;
  double sizeCup = 250;
  int numberOfCupsInAliter = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
        child: Container(
          padding: getPadding(),
          color: Colors.white,
          child: Column(
            children: [
              // Water Goal
              Container(
                padding: getPadding(vertical: 25),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getTitle("Dairy Goal"),
                        Text(
                          '${(sliderValue*numberOfCupsInAliter).ceilToDouble().toInt()} Cups',
                          style: TextStyle(
                            fontSize: 16
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$sliderValue',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text('Liters')
                      ],
                    ),
                    Slider.adaptive(
                      min: 2,
                      max: 5,
                      value: sliderValue,
                      divisions: 12, 
                      onChanged: (value){
                        setState(() {
                          sliderValue = value;
                        });
                      },
                    )
                    
                  ],
                ),
              ),
              getSizedBoxHeight(height: 25),
              // water cup size
              Container(
                padding: getPadding(vertical: 25),
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        getTitle("Cup size")
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('assets/icons/water.png', scale: 0.5,),
                        getSizedBoxHeight(),
                        Text('$sizeCup ml'),
                      ],
                    ),
                    Slider.adaptive(
                      min: 250,
                      max: 500,
                      divisions: 5,
                      value: sizeCup, 
                      onChanged: (value){
                        setState(() {
                          sizeCup = value;
                          numberOfCupsInAliter = (1000/sizeCup).ceilToDouble().toInt();
                        });
                      },
                    )
                  ],
                ),
              ),
              getSizedBoxHeight(height: 25),
              defaultButton(
                function: (){}, 
                text: 'Save',
              )
            ],
          ),
        ),
      ),
    );
  }
}