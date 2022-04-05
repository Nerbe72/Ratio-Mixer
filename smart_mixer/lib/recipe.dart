import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 50,),
        Text('레시피', style: TextStyle(color: Colors.white),),
      ],
    );
  }
}
