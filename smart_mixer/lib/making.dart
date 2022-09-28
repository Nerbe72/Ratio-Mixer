import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';

import 'finish.dart';
import 'styles.dart';

class MakingPage extends StatefulWidget {
  final name;
  MakingPage({@required this.name});

  static const routeName = "/making_page";

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
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => FinishPage()));
    });

    Future.delayed(Duration(milliseconds: 5000));

    return WillPopScope(

      onWillPop: () {
        return Future(()=> true);
        // Fluttertoast.showToast(msg: "제작 완료까지 뒤로가기가 금지됩니다.");
        // return Future(() => false); }, //뒤로가기 방지
      },
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
                height: 600,
                alignment: Alignment.center,
                child: StreamBuilder<DataSnapshot>(
                  stream: snapshot.get().asStream(),
                  builder: (context, streamSnapshot) {
                    if (streamSnapshot.connectionState == ConnectionState.waiting){
                      return Container(
                        height: 100,
                      );
                    }
                    if (streamSnapshot.data!.hasChild("pump_1")){
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: Lottie.asset("asset/loading.json", repeat: false,),
                            ),
                            Container(height: 10,),
                            Text('장치의 버튼을 눌러주세요', style: TextStyle(color: Colors.white, fontSize: 20),),
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