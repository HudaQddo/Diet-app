import 'package:diet_app/modules/recipes/sub_category.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import 'info_recipe.dart';

class Category extends StatefulWidget {
  final String title;
  const Category({ 
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  State<Category> createState() => _CategoryState(title: title);
}

class _CategoryState extends State<Category> {
  String title;
  // String url = 'assets/images/pizza.jpg';
  List<String> cardsName = ['spaghetti','pizza','salad','chicken','soup'];
  List<String> cardsImage = ['spaghetti.jpg','pizza.jpg','salad.jpg','chicken.jpg','soup.jpg'];

  // List<String> categories = ['Time', 'Calories', 'Diet'];
  List<String> categories = ['Breakfast', 'Lunch', 'Dinner', 'Snack', 'Few', 'Medium', 'Many', 'Vegan', 'Keto', 'Standard', 'Low Carb'];
  // List<List<String>> images = [['breakfast.jpg', 'lunch.jpg', 'dinner.jpg', 'snack.jpg'], ['spaghetti.jpg','salad.jpg','soup.jpg'], ['spaghetti.jpg','salad.jpg','chicken.jpg','soup.jpg']];


  _CategoryState({
    required this.title
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: title),
      body: SafeArea(
        child: Container(
          padding:  getPadding(),
          child: ListView.separated(
            itemBuilder: (context, index) => getRowSubCategory(index),
            separatorBuilder: (context, index) => getSizedBoxHeight(height: 30), 
            itemCount: categories.length,
          )
        ),
      ),
    );
 
  }

  Widget getRowSubCategory(int indexCategory){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTitle(categories[indexCategory]),
              TextButton(
                onPressed: (){
                  // Navigator.push(
                  //   context, 
                  //   MaterialPageRoute(
                  //     builder: (context) => SubCategory(title: categories[indexCategory],),
                  //   ),
                  // );
                }, 
                child: Text('More'),
              )
            ],
          ),
          getSizedBoxHeight(),
          Container(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => createCart(
                url: 'assets/images/${cardsImage[index]}',
                name: cardsName[index],
                onTap: (){
                  // Navigator.push(
                  //   context, 
                  //   MaterialPageRoute(
                  //     builder: (context) => InfoRecipe(imageRecipe: 'assets/images/${cardsImage[index]}', nameRecipe: cardsName[index],),
                  //   ),
                  // );
                }
              ), 
              separatorBuilder: (context,index) => getSizedBoxWidth(), 
              itemCount: cardsImage.length,
            ),
          )
        ],
      ),
    );
  }

}