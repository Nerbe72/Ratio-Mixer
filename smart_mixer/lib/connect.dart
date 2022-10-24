import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'styles.dart';
import 'detection.dart';

List<String> ingredients = [];
List<int> ingredients_amount = [];
List<SliderController> sliders = [];
Map<String, int> ingredient_set = {};

class ConnectionPage extends StatelessWidget {
  final name, log_length;
  final Iterable<DataSnapshot>? log_list;

  const ConnectionPage({@required this.name, this.log_length, this.log_list});

  @override
  Widget build(BuildContext context) {
    DatabaseReference snapshot =
        FirebaseDatabase.instance.refFromURL(DB_URL).child("cocktail recipe");
    ingredients.clear();
    ingredients_amount.clear();

    //init 초기화
    ingredient_set.removeWhere((key, value) => true);
    sliders.removeWhere((element) => true);
    // ingredients.removeWhere((element) => true);
    // ingredients_amount.removeWhere((element) => true);

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: Scaffold(
        backgroundColor: defaultBlack,
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: StreamBuilder<DataSnapshot>(
                    stream:  snapshot.get().asStream(),
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
                          Container(height: 20,),
                          Logo2(),
                          Container(height: 20,),
                          Container(
                            alignment: Alignment.center,
                            height: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                Container(
                                  height: 350,
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    child: GridView.builder(
                                      physics: ClampingScrollPhysics(),
                                      itemCount: 4,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        mainAxisSpacing: 1,
                                        crossAxisSpacing: 1,
                                      ),
                                      itemBuilder: (context, index) {
                                        try{
                                          if (streamSnapshot.data!.child(name).children.length < index+1) {
                                            ingredient_set.addAll({'null_'+(index - streamSnapshot.data!.child(name).children.length).toString():0});
                                          } else {
                                            // log_list에 값이 있으면 그 값을 넣음
                                            if (log_list == null){
                                              ingredient_set.addAll(
                                                  {streamSnapshot.data!.child(name).children.elementAt(index).key.toString()
                                                      : int.parse(streamSnapshot.data!.child(name).children.elementAt(index).value.toString())} as Map<String , int>);
                                            } else {
                                              ingredient_set.addAll(
                                                  {streamSnapshot.data!.child(name).children.elementAt(index).key.toString()
                                                      : int.parse(log_list!.elementAt(index+1).value.toString())} as Map<String , int>);
                                              sliders.add(SliderController(double.parse(log_list!.elementAt(index+1).value.toString())));
                                            }
                                          }

                                          return Container(
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: Color(0xFF535353),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 60,
                                                        alignment: Alignment.center,
                                                        child: ListView.builder(
                                                          scrollDirection: Axis.horizontal,
                                                          shrinkWrap: true,
                                                          itemCount: index+1,
                                                          itemBuilder: (ctx, idx){
                                                            return Image.asset("asset/jigger.png", width: 10, height: 20,);
                                                          },
                                                        ),
                                                      ),
                                                      Text(
                                                        (ingredient_set.keys.elementAt(index).toString() != ("null_"+(index - streamSnapshot.data!.child(name).children.length).toString()) ? ingredient_set.keys.elementAt(index).toString() : " "),
                                                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }catch (Exception){
                                          return Container(
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text("재료상태를 확인해주세요", style: TextStyle(color: Colors.white, fontSize: 20),),
                          Container(height: 20,),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 55,
                                  child: TextButton(
                                    child: Text("확인했습니다", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFF536FFC),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                    ),
                                    onPressed: () {
                                      // if (ingredient_set.length <4) {
                                      //   for (var i = 0; i<=4-ingredient_set.length; i++){
                                      //     ingredient_set.addAll({'null_'+i.toString(): 0} as Map<String , int>);
                                      //   }
                                      // }

                                      if (ingredient_set.length == 4){
                                        var ingredient_list = { 'name': name,
                                          'user': FirebaseAuth.instance.currentUser?.uid.toString(),
                                          'pump_1': ingredient_set.values.elementAt(0),
                                          'pump_2': ingredient_set.values.elementAt(1),
                                          'pump_3': ingredient_set.values.elementAt(2),
                                          'pump_4': ingredient_set.values.elementAt(3),
                                          'statue':0};
                                        FirebaseDatabase.instance.refFromURL(DB_URL).child("Queue").set(ingredient_list);
                                      };

                                      // FirebaseDatabase.instance.refFromURL(DB_URL).child("log").child(FirebaseAuth.instance.currentUser!.uid.toString()).push().set({name:""});

                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetectionPage(name: name)));
                                    },
                                  ),
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
