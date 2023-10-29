// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:diet_app/constants.dart';
import 'package:diet_app/models.dart';
import 'package:diet_app/modules/recipes/info_recipe.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Diet extends StatefulWidget {
  final ModelDiet diet;
  const Diet({ 
    Key? key, 
    required this.diet,
  }) : super(key: key);

  @override
  State<Diet> createState() => _DietState(diet: diet);
}

class _DietState extends State<Diet> {
  bool isFollow = false;

  ModelDiet diet;
  _DietState({
    required this.diet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: diet.name),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView.separated(
            itemBuilder: (context,index) => getRow(index), 
            separatorBuilder: (context,index) => getSizedBoxHeight(), 
            itemCount: diet.numberOfDays + 1,
          )
        ),
      ),
    );
  }

  Widget getRow(int indexRow){
    if (indexRow == 0)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets${diet.image}',
                height: 250,
                width: (MediaQuery.of(context).size.width),
                fit: BoxFit.fitWidth,
                color: Colors.white.withOpacity(0.5),
                colorBlendMode: BlendMode.modulate
              ),
              Text(
                diet.name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3
                ),
              ),
            ],
          ),
          getSizedBoxHeight(),
          // Description
          Container(
            padding: getPadding(),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitle('Description'),
                      getSizedBoxHeight(),
                      Container(
                        child: Text(
                          diet.description,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                getSizedBoxWidth(),
                defaultButton(
                  function: (){
                    setState(() {
                      isFollow = !isFollow;
                      followDiet(diet.id, isFollow);
                    });
                  }, 
                  text: isFollow? 'Unfollow' : 'Follow',
                  width: 100,
                  color: isFollow? Colors.red : mainColor,
                ),
              ],
            ),
          ),
        ],
      );

    return Container(
      padding: getPadding(vertical: 0),
      child: getDay(indexRow - 1)
    );
  }

  getDay(int indexDay){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitle(diet.dailyDiets[indexDay].name),
        getSizedBoxHeight(),
        Container(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index) => getMeal(diet.dailyDiets[indexDay].recipes[index]),
            separatorBuilder: (context,index) => getSizedBoxWidth(), 
            itemCount: diet.dailyDiets[indexDay].recipes.length,
          ),
        ),
      ],
    );
  }

  getMeal(ModelRecipes recipe){
    return Column(
      children: [
        Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.w500
          ),
        ),
        Container(
          height: 200,
          child: createCart(
            url: 'assets${recipe.image}', 
            name: recipe.name,
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => InfoRecipe(recipe: recipe),
                ),
              );
            },
            isRecipe: false,
          ),
        ),
      ],
    );
  }

  followDiet(int idDiet, isFollowed) async {
    var token = await getToken();
    String urlFollow = "http://$localhost:8000/diet/follow-diet/$idDiet/";
    String urlUnFollow = "http://$localhost:8000/diet/un-follow-diet/$idDiet/";
    String url = urlFollow;
    if(!isFollow) url = urlUnFollow;
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT $token',
      },
      // body: {},
      // encoding: Encoding.getByName("utf-8")
    );
    print(response.body);
  }


}