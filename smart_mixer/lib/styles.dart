import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:firebase_database/firebase_database.dart';

String DB_URL = "https://smart-mixer-tukorea-s4-6-default-rtdb.firebaseio.com/";

int tabIndex = 1;

Widget Logo() {
  return Column(
    children: <Widget>[
      Image.asset('asset/logo.png', fit: BoxFit.fitWidth,),
      Container( height: 10,),
      Text('mixer that mixes the ratio', style: TextStyle(fontSize: 15, color: Colors.white,),),
    ],
  );
}

Widget Logo2() {
  return Column(
    children: <Widget>[
      Image.asset('asset/logo2.png', fit: BoxFit.fitWidth,),
      Container( height: 10,),
      Text('mixer that mixes the ratio', style: TextStyle(fontSize: 15, color: Colors.white,),),
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
    borderSide: BorderSide(color: Colors.deepPurpleAccent),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);

ButtonStyle buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed))
      return Colors.blue;
    return Color(0xFF272727);
  }),
  shape: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),);
      }),
  side: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
    return BorderSide(width: 2.0, color: Color(0xFF7A7A7A));
  }),
  textStyle: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed))
      return TextStyle(color: Colors.white, fontSize: 35, fontFamily: 'mmd');
    return TextStyle(color: Color(0xFF505050), fontSize: 35, fontFamily: 'mmd');
  }),
);

final gController = GroupButtonController(
    selectedIndex: 0
);

final uController = GroupButtonController(
    selectedIndex: 0
);

class SliderController {
  double sliderValue;
  SliderController(this.sliderValue);
}

Color defaultBlack = Color(0xFF272727);

String? nullableString(Iterable<DataSnapshot>? data, int index) {
  if (data?.length == 0) {
    return "";
  }
  return data?.elementAt(index).key.toString();
}