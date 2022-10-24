import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'styles.dart';
import 'finish.dart';

class MakingPage extends StatefulWidget {
  const MakingPage({Key? key}) : super(key: key);

  @override
  State<MakingPage> createState() => _MakingPageState();
}

class _MakingPageState extends State<MakingPage> {
  Timer? _timer;
  int test = 0;

  void initState(){
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 5), (timer){
      setState(() {
        if (test == 0)
          test = 1;
        else
          test = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    DatabaseReference snapshot =
    FirebaseDatabase.instance.refFromURL(DB_URL).child("Queue");

    snapshot.onChildRemoved.listen((event) {
      _timer?.cancel();
      Get.off(() => FinishPage());
      // Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => FinishPage()));
    });

    return WillPopScope(
      onWillPop: () {
        Fluttertoast.showToast(msg: "제작 완료까지 뒤로가기가 금지됩니다.");
        return Future(() => false);
      }, //뒤로가기 방지
      child: Scaffold(
        backgroundColor: test == 0 ? Color(0xFF282828) : Color(0xFF282627),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
            child: Column(
              children: [
                Logo2(),
                Container(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 250,
                        child:
                        test == 0 ?
                        Lottie.asset("asset/pour.json", repeat: true, filterQuality: FilterQuality.low, frameRate: FrameRate.max,)
                        : Lottie.asset("asset/shake.json", repeat: true, filterQuality: FilterQuality.low, frameRate: FrameRate.max,),
                      ),
                      Text(
                        test == 0 ? "재료를 주입 중입니다" : "스마트 믹싱 중입니다",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
