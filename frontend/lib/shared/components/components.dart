// ignore_for_file: prefer_const_constructors, unused_import, avoid_print

import 'dart:convert';

import 'package:diet_app/constants.dart';
import 'package:diet_app/modules/recipes/info_recipe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

AppBar getAppBar({String title = "Healthy Me", automaticallyImplyLeading = true}){
  return AppBar(
    title: Text(title),
    automaticallyImplyLeading: automaticallyImplyLeading,
  );
}

SizedBox getSizedBoxWidth({
  double width = 15,
}) =>
SizedBox(
  width: width,
);

SizedBox getSizedBoxHeight({
  double height = 15,
}) =>
SizedBox(
  height: height,
);

EdgeInsets getPadding({
  double horizontal = 20,
  double vertical = 15,
}) => 
EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);

Text getTitle(text) => 
Text(
  text,
  style: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    letterSpacing: 1
  ),
);

Widget defaultButton({
  double width = double.infinity,
  required var function,
  required String text,
  var color,
  bool isUpperCase = true,
}) => 
Container(
              width: width,
              height: 40.0,
              decoration: BoxDecoration(
                color: color ?? mainColor,
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: MaterialButton(
                onPressed: function, 
                child: Text(
                  isUpperCase? text.toUpperCase() : text,
                  style:  TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 2.0,
                  ),
                ),              
              ),
            );

Widget defaultInput({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  onSubmit,
  onChange,
  onTap,
  required validate,
  required String text,
  required IconData prefix,
  suffix,
  suffixPressed
}) => 
TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  onTap: onTap,
  readOnly: onTap != null ? true: false,
  decoration: InputDecoration(
    labelText: text,
    labelStyle:  TextStyle(
      fontSize: 15.0,
    ),
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed, 
      icon: Icon(suffix)
    ): null,
    border: OutlineInputBorder(
      borderSide:  BorderSide(
        width: 5.0,
      ),
      borderRadius: BorderRadius.circular(15.0)
    ),
  ),
);

Widget buildSlideDash(currentDash , indexDash){
  Color color = Colors.grey;
  if(indexDash > currentDash){
    color =  mainColor;
  }
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 3.0),
    width: 17.0,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5.0)
    ),
  );

}

Widget defaultPosition(int indexDash, int countDash){
  return Positioned(
          top: 30.0,
          child: Container(
            height: 8.0,
            width: countDash * 23.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index) => buildSlideDash(index, indexDash),
              itemCount: countDash,
            ),
          ),
        );
}

Widget defaultBackButton({
  required var onPressed,
  double bottom = 30.0,
}) =>
Positioned.directional(
  textDirection: TextDirection.ltr,
  bottom: bottom,
  start: 0.0,
  child: TextButton(
    onPressed: onPressed, 
    child: Row(
      children: [
        Icon(Icons.navigate_before),
        Text('Back'),
      ],
    ),
  ),    
);

Widget defaultNextButton({
  required var onPressed,
  double bottom = 30.0,
}) =>
Positioned.directional(
  textDirection: TextDirection.ltr,
  bottom: bottom,
  end: 0.0,
  child: TextButton(
    onPressed: onPressed, 
    child: Row(
      children:  [
        Text('Next'),
        Icon(Icons.navigate_next),
      ],
    ),
  ),    
);

List<Widget> getListOfNumber(int smallest,int biggest, int current){
  List<Widget> list = [];
  while(smallest <= biggest){
    list.add(
      Container(
        padding:  EdgeInsets.all(10.0),
        margin:  EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: current == smallest ? mainColor : null,
          borderRadius: BorderRadius.circular(15.0)
        ),
        width: 60.0,
        height: 50.0,
        child: Center(child: Text(
          '$smallest',
          style: TextStyle(
            color: current == smallest ? Colors.white : Colors.black
          ),
        )),
      )
    );
    smallest++;
  }
  return list;
}

Widget createCart({
  required String url, 
  required String name, 
  required var onTap,
  double width = 150,
  // double height = 150,
  bool isRecipe = true,
  onTapFav
}) =>
Stack(
  alignment: Alignment.topRight,
  children: [
    GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    url,
                    width: width,
                    height: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            getSizedBoxHeight(),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'mainFontFamily',
                fontWeight: FontWeight.w500,
                fontSize: width > 150 ? 18 : 14,
              ),
            )
          ],
        ),
      ),
    ),
    // if(isRecipe)GestureDetector(
    //   onTap: onTapFav ?? (){},
    //   child: Container(
    //     padding: EdgeInsets.all(7),
    //     margin: EdgeInsets.all(5),
    //     decoration: BoxDecoration(
    //       color: Colors.grey.shade200,
    //       borderRadius: BorderRadius.circular(50)
    //     ),
    //     child: url == 'assets/images/pizza.jpg' 
    //     ? Icon(Icons.favorite, color: Colors.red,)
    //     : Icon(Icons.favorite_border),
    //   ),
    // )
  ],
);

Widget rowRecipes(context,List<String> cardsImage, List<String> cardsName){
  return Container(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return createCart(
                url: 'assets/images/${cardsImage[index]}',
                name: cardsName[index],
                onTap: (){
                // Navigator.push(
                //   context, 
                //   MaterialPageRoute(
                //     builder: (context) => InfoRecipe(imageRecipe: 'assets/images/${cardsImage[index]}', nameRecipe: cardsName[index]),
                //   ),
                // );
              }
              );
            },
            separatorBuilder: (context,index){
              return getSizedBoxWidth();
            },
          ),
        );
}

Future<String> getToken() async {
  // print(usernameLocal + " " + passwordLocal);
  var response = await http.post(
    Uri.parse('http://$localhost:8000/auth/jwt/create/'),
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: {
      "username" : usernameLocal,
      "password" : passwordLocal,
    },
  // encoding: Encoding.getByName("utf-8")
  );

  // print("inner get token");
  String token = jsonDecode(response.body)['access'];
  // print(token.runtimeType);
  // print("token in get token in components: " + token);
  return token;
}
