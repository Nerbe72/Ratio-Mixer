import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'styles.dart';
import 'singup.dart';
import 'signin.dart';

class SignTempPage extends StatefulWidget {
  const SignTempPage({Key? key}) : super(key: key);

  @override
  State<SignTempPage> createState() => _SignTempPageState();
}

class _SignTempPageState extends State<SignTempPage> {
  @override
  Widget build(BuildContext context) {
    //로그인/회원가입 화면
    return Scaffold(
      backgroundColor: defaultBlack,
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 50, 50, 10),
        child: ListView(
          children: <Widget>[
            Logo(),
            Container(height: 70,),

            //기존회원
            OutlinedButton(
              style: buttonStyle,
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('기존회원', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                      Container(height: 20,),
                      Text('MEMBER', style: TextStyle(color: Color(0xFF505050), fontSize: 40, fontFamily: 'mmd'),),
                    ],
                  ),
                ),
              ),
              onPressed: () {
                Get.to(SignInPage());
              },
            ),

            Container(height: 20,),

            //회원가입
            OutlinedButton(
              style: buttonStyle,
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('회원가입', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                      Container(height: 20,),
                      Text('APPLY', style: TextStyle(color: Color(0xFF505050), fontSize: 35, fontFamily: 'mmd'),),
                    ],
                  ),
                ),
              ),
              onPressed: () {
                Get.to(SignUpPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
