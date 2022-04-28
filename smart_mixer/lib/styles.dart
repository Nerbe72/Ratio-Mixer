import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

String DB_URL = "https://smart-mixer-tukorea-s4-6-default-rtdb.firebaseio.com/";

Widget Logo() {
  return Column(
    children: <Widget>[
      Image.asset('asset/logo.png', fit: BoxFit.fitWidth,),
      Container( height: 10,),
      Text('mixer that mixes the ratio', style: TextStyle(fontSize: 20, color: Colors.white,),),
    ],
  );
}

Widget Logo2() {
  return Column(
    children: <Widget>[
      Image.asset('asset/logo2.png', fit: BoxFit.fitWidth,),
      Container( height: 10,),
      Text('mixer that mixes the ratio', style: TextStyle(fontSize: 20, color: Colors.white,),),
    ],
  );
}

BoxDecoration textFieldBoxStyle = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  gradient: LinearGradient(
    colors: [Colors.grey, Color(0xFF272727)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
);

InputDecoration textFieldStyle = InputDecoration(
  hoverColor: Colors.white,
  isDense: true,
  contentPadding: EdgeInsets.only(left: 12,top: 8,bottom: 8),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);

final gController = GroupButtonController(
    selectedIndex: 0
);

Color defaultBlack = Color(0xFF272727);