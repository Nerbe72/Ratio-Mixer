import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_mixer/making.dart';

import 'styles.dart';

List<String> ingredients = [];

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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                ingredients.add(streamSnapshot.data!
                                    .child(name)
                                    .children
                                    .elementAt(index)
                                    .key
                                    .toString());

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
                                  child: Text("제작", style: TextStyle(color: Colors.white, fontSize: 25),),
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

                                    if (ingredients.length <4) {
                                      for (var i = 0; i<4-ingredients.length; i++){
                                        ingredients.add('null');
                                      }
                                    }

                                    var ingredient_list = {
                                      'pump_1': {'name': "Pump 1", 'pin':12, 'value': ingredients[0]},
                                      'pump_2': {'name': "Pump 2", 'pin':16, 'value': ingredients[1]},
                                      'pump_3': {'name': "Pump 3", 'pin':20, 'value': ingredients[2]},
                                      'pump_4': {'name': "Pump 4", 'pin':21, 'value': ingredients[3]},
                                    };
                                    FirebaseDatabase.instance.refFromURL(DB_URL).child("push").set(ingredient_list);

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
