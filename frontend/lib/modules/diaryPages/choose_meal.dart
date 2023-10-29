// ignore_for_file: prefer_const_constructors

import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../recipes/search_page.dart';

class ChooseMeal extends StatefulWidget {
  final String typeMeal;
  const ChooseMeal({ 
    Key? key,
    required this.typeMeal
    }) : super(key: key);

  @override
  State<ChooseMeal> createState() => _ChooseMealState(typeMeal: typeMeal);
}

class _ChooseMealState extends State<ChooseMeal> {
  String typeMeal;
  TextEditingController searchController = TextEditingController();
  List<String> trackedRecipes = [];

  _ChooseMealState({
    required this.typeMeal
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: typeMeal),
      body: SafeArea(
        child: Container(
          padding: getPadding(),
          color: Colors.white,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getSizedBoxHeight(),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                  );
                },
                child: Container(
                  padding: getPadding(),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey
                    ),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      getSizedBoxWidth(),
                      Text('Search')
                    ],
                  ),
                ),
              ),
              // Container(
              //   height: (MediaQuery.of(context).size.height) / 2 - 100,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Column(
              //         children: [
              //           getTitle("Recommend"),
              //           getSizedBoxHeight(),
              //           Container(
              //             height: 2,
              //             color: Colors.grey[300],
              //           ),
              //         ],
              //       ),
              //       Container(
              //         height: 190,
              //         child: ListView.separated(
              //           scrollDirection: Axis.horizontal,
              //           itemBuilder: (context,index) => createCart(
              //             url: 'assets/images/pizza.jpg',
              //             name: 'Pizza',
              //             onTap: (){}
              //           ), 
              //           separatorBuilder: (context, index) => getSizedBoxWidth(), 
              //           itemCount: 5,
              //         ),
              //       ),   
              //     ],
              //   ),
              // ),
              getSizedBoxHeight(),
              Expanded(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        getTitle("Tracked Food"),
                        getSizedBoxHeight(),
                        Container(
                          height: 2,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    getSizedBoxHeight(),
                    Expanded(
                      child: trackedRecipes.isNotEmpty
                      ? ListView.separated(
                        itemBuilder: (context,index) => Container(
                          alignment: Alignment.center,
                          height: 350,
                          // width: MediaQuery.of(context).size.width,
                          child: createCart(
                            url: 'assets/images/pizza.jpg',
                            name: trackedRecipes[index],
                            width: 300,
                            onTap: (){
                              // Navigator.push(
                              //   context, 
                              //   MaterialPageRoute(
                              //     builder: (context) => InfoRecipe(nameRecipe: trackedRecipes[index], imageRecipe: 'assets/images/pizza.jpg',),
                              //   ),
                              // );
                            }
                          ),
                        ), 
                        separatorBuilder: (context,index) => getSizedBoxHeight(),
                        itemCount: trackedRecipes.length,
                      )
                      : Center(child: Text("You haven\'t tracked any food yet")),
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
}