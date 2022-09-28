import 'package:flutter/material.dart';

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
        child: Column(
          children: <Widget>[
            Logo(),
            Container(height: 80,),

            //기존회원
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(0.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                side: BorderSide(width: 2.0, color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('기존회원', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                      Container(height: 20,),
                      Text('MEMBER', style: TextStyle(color: Colors.grey, fontSize: 40, fontFamily: 'mmd'),),
                    ],
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignInPage(),),
                );
              },
            ),

            Container(height: 20,),

            //회원가입
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(0.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                side: BorderSide(width: 2.0, color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('회원가입', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                      Container(height: 20,),
                      Text('SIGN UP', style: TextStyle(color: Colors.grey, fontSize: 40, fontFamily: 'mmd'),),
                    ],
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUpPage(),),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
