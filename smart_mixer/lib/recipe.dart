import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import 'styles.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272727),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
        child: Column(
          children: <Widget>[
            Logo2(),
            Container(height: 30,),
            Container(height: 200, width: 400, color: Colors.black, child: Text('슬라이드 카드 형식으로 추천', style: TextStyle(color: Colors.white),),),
            Container(height: 20,),
            GroupButton(
              isRadio: true,
              borderRadius: BorderRadius.circular(15.0),
              buttonWidth: 100,
              buttons: const ['럼', '데킬라', '진', '위스키', '보드카'],
              onSelected: (index, isSelected) => print('$index button is selected'),
            ),
          ],
        ),
      ),
    );
  }
}
