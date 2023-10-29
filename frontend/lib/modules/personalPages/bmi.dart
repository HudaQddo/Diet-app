// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  final double weight;
  final double height;
  const BMI({ 
    Key? key,
    required this.weight,
    required this.height
  }) : super(key: key);

  @override
  State<BMI> createState() => _BMIState(weight: weight, height: height);
}

class _BMIState extends State<BMI> {
  final double weight;
  final double height;
  _BMIState({
    required this.weight,
    required this.height
  });
  @override
  Widget build(BuildContext context) {
    double bmi = weight / pow(height/100, 2);
    return Scaffold(
      appBar: getAppBar(title: 'BMI'),
      body: SafeArea(
        child: Container(
          padding: getPadding(),
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(bmi <= 18.5)Column(
                children: [
                  getTitle('Your BMI: ${bmi.toStringAsFixed(1)}'),
                  getSizedBoxHeight(),
                  Image.asset(
                    'images/underWeight.png',
                    height: 200,
                  ),
                  getSizedBoxHeight(),
                  Text(
                    'You are underweight, and this is usually an indication of malnutrition',
                    maxLines: 4,
                  ),
                ],
              ),
              if(bmi > 18.5 && bmi <= 24.9)Column(
                children: [
                  getTitle('Your BMI: ${bmi.toStringAsFixed(1)}'),
                  getSizedBoxHeight(),
                  Image.asset(
                    'images/normalWeight.png',
                    height: 200,
                  ),
                  getSizedBoxHeight(),
                  Text(
                    'The BMI value is within the normal height and weight, it is better for you to maintain your current weight',
                    maxLines: 4,
                  ),
                ],
              ),
              if(bmi > 24.9 && bmi <= 29.9)Column(
                children: [
                  getTitle('Your BMI: ${bmi.toStringAsFixed(1)}'),
                  getSizedBoxHeight(),
                  Image.asset(
                    'images/overWeight.png',
                    height: 200,
                  ),
                  getSizedBoxHeight(),
                  Text(
                    'You are overweight, you must follow a diet to lose excess weight and it is recommended to exercise to lose weight',
                    maxLines: 4,
                  ),
                ],
              ),
              if(bmi > 29.9)Column(
                children: [
                  getTitle('Your BMI: ${bmi.toStringAsFixed(1)}'),
                  getSizedBoxHeight(),
                  Image.asset(
                    'images/obese.png',
                    height: 200,
                  ),
                  getSizedBoxHeight(),
                  Text(
                    'You suffer from obesity, and obesity can be treated through two basic steps: diet and exercise',
                    maxLines: 4,
                  ),
                ],
              ),
              
              Image.asset(
                'images/bmi.png',
                // height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}