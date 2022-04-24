import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_mixer/making.dart';

import 'styles.dart';

class ConnectionPage extends StatelessWidget {
  final name;

  const ConnectionPage({@required this.name});

  @override
  Widget build(BuildContext context) {
    DatabaseReference snapshot =
        FirebaseDatabase.instance.refFromURL(DB_URL).child("cocktail recipe");

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: Scaffold(
        backgroundColor: defaultBlack,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                Container(
                  child: StreamBuilder<DataSnapshot>(
                    stream: snapshot.get().asStream(),
                    builder: (context, streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Loading",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      if (streamSnapshot.connectionState == ConnectionState.none) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Error",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Text(
                            "재료를 우측부터 순서대로 연결해주세요",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),

                          Container(
                            alignment: Alignment.center,
                            height: 300,
                            child: ListView.builder(
                              itemCount:
                                  streamSnapshot.data!.child(name).children.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    streamSnapshot.data!
                                            .child(name)
                                            .children
                                            .elementAt(index)
                                            .key
                                            .toString(),
                                    style:
                                        TextStyle(color: Colors.white, fontSize: 30),
                                  ),
                                );
                              },
                            ),
                          ),

                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextButton(
                                  child: Text("start", style: TextStyle(color: Colors.white, fontSize: 25),),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFF536FFC),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MakingPage(name: name)));
                                    var entry = {name:{'s':0}};
                                    FirebaseDatabase.instance.refFromURL(DB_URL).child("Queue").set(entry);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
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
