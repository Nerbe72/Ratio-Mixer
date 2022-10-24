import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'nav.dart';
import 'sign_temp.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF272727),
    );
  }

  void initState() {
    super.initState();

    // _logout();
    _auth();
  }

  void dispose() {
    super.dispose();
  }

  _auth() {
    Future.delayed(const Duration(milliseconds: 10), () {
      //자동 로그인 확인
      if(FirebaseAuth.instance.currentUser == null) {
        Get.offAll(() => const SignTempPage());
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NavBar()));
        Fluttertoast.showToast(msg: "자동로그인 되었습니다");
      }
    });
  }

  _logout() async{
    await FirebaseAuth.instance.signOut();
  }
}