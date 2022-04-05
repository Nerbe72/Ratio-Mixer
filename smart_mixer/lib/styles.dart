import 'package:flutter/material.dart';

Widget Logo() {
  return Column(
    children: <Widget>[
      Image.asset('asset/logo.png', fit: BoxFit.fitWidth,),
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
    )
);

InputDecoration textFieldStyle = InputDecoration(
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