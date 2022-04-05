import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'start.dart';
import 'styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartMixer Demo',
      theme: ThemeData(
        backgroundColor: Color(0xFF272727),
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<Widget> futureCall() async {
    return Future.value(new StartPage());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Color(0xFF272727),
      splashIconSize: (ScreenUtil.defaultSize.height/3)*2,
      splash: Padding(
        padding: EdgeInsets.only(left: 50, right: 50),
          child: Column(
            children: <Widget>[
              Logo(),
              Container( height: 150,),
              CircularProgressIndicator(color: Colors.orange, backgroundColor: Colors.blueAccent,),
            ],
          ),
        ),
      nextScreen: StartPage(),
      duration: 2000,
    );
  }
}




