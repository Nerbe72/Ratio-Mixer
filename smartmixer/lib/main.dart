import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      )
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      home: AnimatedSplashScreen(
        splash: Image.asset('asset/splash.png'),
        nextScreen: MyHomePage(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 200.0,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Container(
              child: Image.asset('asset/logo.png'),
              alignment: Alignment.center,
              width: 250.0,
              padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){},
                child: Text(
                  '로그인',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            //좌우 슬라이드 카드 형식의 사용자 맞춤 제품 추천
            
            //좌우 슬라이드 카드 형식의 베이스 주류에 따라 분류된 칵테일 나열
            

          ],
        ),
      ),
    );
  }
}
