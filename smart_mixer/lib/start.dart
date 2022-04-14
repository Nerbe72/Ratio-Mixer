import 'package:flutter/material.dart';
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
      if(FirebaseAuth.instance.currentUser == null) {
        Get.off(() => const SignTempPage());
      } else {
        Get.off(NavBar());
      }
    });
  }

  _logout() async{
    await FirebaseAuth.instance.signOut();
  }
}