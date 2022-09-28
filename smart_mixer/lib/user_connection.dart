import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_mixer/making.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'styles.dart';

List<String> ingredients = [];
List<int> ingredients_amount = [];
List<SliderController> sliders = [];
Map<String, int> ingredient_set = {};

class UserConnectionPage extends StatelessWidget {
  final name, log_length;
  final Iterable<DataSnapshot> log_list;

  const UserConnectionPage({required this.name,required this.log_length, required this.log_list});

  @override
  Widget build(BuildContext context) {
    DatabaseReference snapshot =
    FirebaseDatabase.instance.refFromURL(DB_URL).child("cocktail recipe");
    ingredients.clear();
    ingredients_amount.clear();

    //init 초기화
    ingredient_set.removeWhere((key, value) => true);
    sliders.removeWhere((element) => true);

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
                          Text(
                            "재료의 비율을 설정해주세요",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),

                          Container(
                            alignment: Alignment.center,
                            height: 640,
                            child: ListView.builder(
                              itemCount:streamSnapshot.data!.child(name).children.length,
                              itemBuilder: (context, index) {

                                ingredient_set.addAll(
                                    {streamSnapshot.data!.child(name).children.elementAt(index).key.toString()
                                        : int.parse(log_list.elementAt(index+1).value.toString())} as Map<String , int>);
                                sliders.add(SliderController(double.parse(log_list.elementAt(index+1).value.toString())));

                                return Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Container(height: 30,),
                                      Text(
                                        streamSnapshot.data!
                                            .child(name)
                                            .children
                                            .elementAt(index)
                                            .key
                                            .toString(),
                                        style: TextStyle(color: Colors.white, fontSize: 30),
                                      ),
                                      StatefulBuilder(
                                        builder: (BuildContext context, void Function(void Function()) SBsetState) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: SfSliderTheme(
                                                  data: SfSliderThemeData(
                                                    tickSize: Size(5, 5),
                                                    thumbColor: Colors.white,
                                                    activeLabelStyle: TextStyle(color: Colors.white, fontSize: 12, fontStyle: FontStyle.normal),
                                                    inactiveLabelStyle: TextStyle(color: Colors.white, fontSize: 12, fontStyle: FontStyle.normal),
                                                  ),
                                                  child: SfSlider(
                                                    value: sliders[index].sliderValue,
                                                    min: 10,
                                                    max: 150,
                                                    interval: 20,
                                                    showLabels: true,
                                                    enableTooltip: true,
                                                    showDividers: true,
                                                    stepSize: 5,
                                                    onChanged: (dynamic value) {
                                                      SBsetState(()=>sliders[index].sliderValue = double.parse(value.toStringAsFixed(0)));
                                                      ingredient_set[ingredient_set.keys.elementAt(index)] = sliders[index].sliderValue.toInt();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 55,
                                                child: Text(
                                                  int.parse(sliders[index].sliderValue.toStringAsFixed(0)).toString(),
                                                  style: TextStyle(color: Colors.white, fontSize: 30),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                child: Container(
                                                  width: 35,
                                                  child: Text(
                                                    "ml",
                                                    style: TextStyle(color: Colors.white, fontSize: 30),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextButton(
                                  child: Text("요청", style: TextStyle(color: Colors.white, fontSize: 25),),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFF536FFC),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),
                                  onPressed: () {
                                    // var entry_sub = {};
                                    // for (var i = 0; i<ingredients.length; i++){
                                    //   entry_sub.addAll({ingredients[i]: ingredients_amount[i]});
                                    // }
                                    // var entry = {name: entry_sub};
                                    //
                                    // FirebaseDatabase.instance.refFromURL(DB_URL).child("Queue").set(entry);

                                    if (ingredient_set.length <4) {
                                      for (var i = 0; i<=4-ingredient_set.length; i++){
                                        ingredient_set.addAll({'null_'+i.toString(): 0} as Map<String , int>);
                                      }
                                    }

                                    if (ingredient_set.length == 4){
                                      var ingredient_list = { 'name': name,
                                        'user': FirebaseAuth.instance.currentUser?.uid.toString(),
                                        'pump_1': ingredient_set.values.elementAt(0),
                                        'pump_2': ingredient_set.values.elementAt(1),
                                        'pump_3': ingredient_set.values.elementAt(2),
                                        'pump_4': ingredient_set.values.elementAt(3)};
                                      FirebaseDatabase.instance.refFromURL(DB_URL).child("Queue").set(ingredient_list);
                                    };

                                    print(ingredient_set);

                                    // FirebaseDatabase.instance.refFromURL(DB_URL).child("log").child(FirebaseAuth.instance.currentUser!.uid.toString()).push().set({name:""});

                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MakingPage(name: name)));
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
