import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import 'styles.dart';
import 'making.dart';

class DetectionPage extends StatefulWidget {
  final name;
  DetectionPage({@required this.name});

  @override
  State<DetectionPage> createState() => _DetectionPage();
}

class _DetectionPage extends State<DetectionPage> {

  @override
  Widget build(BuildContext context) {
    final name = widget.name;
    DatabaseReference snapshot =
    FirebaseDatabase.instance.refFromURL(DB_URL).child("Queue");

    final deviceWidth = MediaQuery.of(context).size.width;
    final standardWidth = 411.43;
    final designWidth = deviceWidth / standardWidth;

    snapshot.onChildChanged.listen((event) {
      Get.off(() => MakingPage());
    });

    return Scaffold(
      backgroundColor: Color(0xFF282828),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Column(
            children: [
              Logo2(),
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
                    if (streamSnapshot.data!.hasChild("pump_1")){
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                FloatingActionButton(
                                  disabledElevation: 0,
                                  mini: true,
                                  elevation: 0,
                                  backgroundColor: Color(0x00FFFFFF),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                  child: Container(
                                      width: 250*designWidth,
                                      height: 250*designWidth,
                                      child: Lottie.asset("asset/loading.json", repeat: true,)
                                  ),
                                ),
                              ],
                            ),
                            Container(height: 10,),
                            Text('기기의 버튼을 눌러주세요', style: TextStyle(color: Colors.white, fontSize: 20),),
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