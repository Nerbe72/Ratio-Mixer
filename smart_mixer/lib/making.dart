import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';

import 'finish.dart';
import 'styles.dart';

class MakingPage extends StatefulWidget {
  final name;
  MakingPage({@required this.name});

  @override
  State<MakingPage> createState() => _MakingPageState();
}

class _MakingPageState extends State<MakingPage> {

  @override
  Widget build(BuildContext context) {
    final name = widget.name;
    DatabaseReference snapshot =
    FirebaseDatabase.instance.refFromURL(DB_URL).child("Queue");

    snapshot.onChildRemoved.listen((event) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FinishPage()));
    });

    return WillPopScope(
      onWillPop: () {
        Fluttertoast.showToast(msg: "제작 완료까지 뒤로가기가 금지됩니다.");
        return Future(() => false); }, //뒤로가기 방지
      child: Scaffold(
        backgroundColor: defaultBlack,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text(
                name, style: TextStyle(color: Colors.white, fontSize: 40),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 500,
                alignment: Alignment.center,
                child: StreamBuilder<DataSnapshot>(
                  stream: snapshot.get().asStream(),
                  builder: (context, streamSnapshot) {
                    if (streamSnapshot.connectionState == ConnectionState.waiting){
                      return Container(
                        height: 100,
                      );
                    }

                    if (streamSnapshot.data!.hasChild(name)){
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("asset/bottle_open.png"),
                            Text('재료를 주입중입니다.', style: TextStyle(color: Colors.white, fontSize: 20),),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        height: 100,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}