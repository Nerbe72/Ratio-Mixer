import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:word_break_text/word_break_text.dart';

import 'connect.dart';

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

Widget Logo3() {
  return Column(
    children: <Widget>[
      Image.asset('asset/logo3.png', fit: BoxFit.fitWidth,),
      Container( height: 10,),
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

final recommendController = GroupButtonController(
  selectedIndex: 0
);

Color defaultBlack = Color(0xFF272727);

String? nullableString(Iterable<DataSnapshot>? data, int index) {
  if (data?.length == 0) {
    return "";
  }
  return data?.elementAt(index).key.toString();
}

InkWell iterateCard(Iterable<DataSnapshot>? data, int index,BuildContext context){
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConnectionPage(name: data!.elementAt(index).key.toString())));
    },
    child: Container(
      constraints: BoxConstraints(
        minHeight: 50,
        maxHeight: 100,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withAlpha(950),
                Color(0xFF7742FA),
              ])),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(0xFF626262),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //todo : 이미지 삽입
                  constraints: BoxConstraints(
                    minHeight: 70,
                    minWidth: 70,
                    maxHeight: 90,
                    maxWidth: 90,
                  ),
                  color: Colors.white,
                ),
              ),
              Container(
                width: 95,
                alignment: Alignment.center,
                child: WordBreakText(
                  nullableString(data, index) ?? "",
                  spacingByWrap: true,
                  wrapAlignment: WrapAlignment.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}