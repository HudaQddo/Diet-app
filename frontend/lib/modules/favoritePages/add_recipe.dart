// ignore_for_file: avoid_unnecessary_containers

import 'package:diet_app/constants.dart';
import 'package:diet_app/main.dart';
import 'package:diet_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({ Key? key }) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberOfPersonController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  List<String> food = ['food 1', 'food 2', 'food 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Add Recipe"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: getPadding(),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultInput(
                        controller: nameController, 
                        type: TextInputType.name, 
                        validate: (value){}, 
                        text: 'name', 
                        prefix: Icons.title
                      ),
                      getSizedBoxHeight(),
                      defaultInput(
                        controller: numberOfPersonController, 
                        type: TextInputType.number, 
                        validate: (value){}, 
                        text: 'number of person', 
                        prefix: Icons.title
                      ),
                      getSizedBoxHeight(),
                      defaultInput(
                        controller: timeController,
                        type: TextInputType.number, 
                        validate: (value){}, 
                        text: 'time by minute', 
                        prefix: Icons.title
                      ),
                      getSizedBoxHeight(),
                      Container(
                        padding: getPadding(vertical: 0),
                        child: getTitle('Food:')
                      ),
                      Container(
                        padding: getPadding(),
                        child: Column(
                          children: getFood(),
                        ),
                      ),
                      getSizedBoxHeight(),
                      Container(
                        padding: getPadding(),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          children: [
                            defaultInput(
                              controller: nameController, 
                              type: TextInputType.name, 
                              validate: (value){}, 
                              text: 'Food', 
                              prefix: Icons.title
                            ),
                            getSizedBoxHeight(),
                            defaultInput(
                              controller: nameController, 
                              type: TextInputType.number, 
                              validate: (value){}, 
                              text: 'Quantity', 
                              prefix: Icons.title
                            ),
                            getSizedBoxHeight(),
                            defaultButton(
                              width: 200,
                              color: mainColor,
                              function: (){}, 
                              text: 'Add food',
                            ),
                          ],
                        ),
                      ),
                      getSizedBoxHeight(),
                      // defaultInput(
                      //   controller: nameController, 
                      //   type: TextInputType.number, 
                      //   validate: (value){}, 
                      //   text: 'number of person', 
                      //   prefix: Icons.title
                      // ),
                      // getSizedBoxHeight(),
                      // defaultInput(
                      //   controller: nameController, 
                      //   type: TextInputType.number, 
                      //   validate: (value){}, 
                      //   text: 'number of person', 
                      //   prefix: Icons.title
                      // ),
                      // getSizedBoxHeight(),
                    ],
                  ),
                ),
                defaultButton(
                  function: (){},
                  text: 'Add recipe'
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }

  getFood(){
    List<Widget> list = [];
    for(int i=0;i<food.length;i++){
      Widget w = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${food[i]}'),
            GestureDetector(
              onTap: (){
                setState(() {
                  food.removeAt(i);
                });
              },
              child: Icon(Icons.close)
            )
          ],
        )
      );
      list.add(w);
    }
    if(list.isEmpty){
      list.add(Text('No food yet!'));
    }
    return list;
  }
}