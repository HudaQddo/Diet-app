import 'dart:math';

import 'package:flutter/material.dart';

import '../../models.dart';
import '../../shared/components/components.dart';
import 'info_recipe.dart';

class SubCategory extends StatefulWidget {
  final ModelSubCategory subCategory;
  const SubCategory({ 
    Key? key,
    required this.subCategory
  }) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState(subCategory: subCategory);
}

class _SubCategoryState extends State<SubCategory> {
  ModelSubCategory subCategory;
  // String url = 'assets/images/pizza.jpg';
  int number = 10;

  _SubCategoryState({
    required this.subCategory
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: subCategory.name),
      body: SafeArea(
        child: Container(
          padding:  getPadding(),
          color: Colors.white,
          child: ListView.separated(
            itemBuilder: (context, index) {
              if(index == number){
                return Container(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        number += 10;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Load more'),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                );
              }
              return Container(
                alignment: Alignment.center,
                height: 350,
                child: createCart(
                  url: 'assets${subCategory.recipes[index].image}', 
                  name: subCategory.recipes[index].name,
                  width: 300,
                  onTapFav: (){
                    setState(() {
                      // if(url == 'assets/images/pizza.jpg')
                      //   url = 'assets/images/salad.jpg';
                      // else
                      //   url = 'assets/images/pizza.jpg';
                      // // print('fav');
                    });
                  },
                  onTap: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => InfoRecipe(recipe: subCategory.recipes[index],),
                      ),
                    );
                  },
                ),
              );
            }, 
            separatorBuilder: (context, index) => getSizedBoxHeight(height: 30), 
            itemCount: min(number + 1,subCategory.recipes.length),
          )
        ),
      ),
    );
 
  }

}