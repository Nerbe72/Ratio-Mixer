import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_mixer/start.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:group_button/group_button.dart';
import 'package:word_break_text/word_break_text.dart';

import 'styles.dart';

final user = FirebaseAuth.instance.currentUser;

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  Widget build(BuildContext context) {
    DatabaseReference recommend_n_log =
    FirebaseDatabase.instance.refFromURL(DB_URL);

    return Scaffold(
      backgroundColor: Color(0xFF272727),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
        child: Column(
          children: <Widget>[
            Logo3(),
            Container(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  try {
                    FirebaseAuth.instance.signOut();
                  } on FirebaseAuthException catch (e){

                  }
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage()));
                },
                child: Text('로그아웃',),
              ),
            ),
            Container(height: 30,),
            GroupButton(
              isRadio: true,
              controller: recommendController,
              borderRadius: BorderRadius.circular(20.0),
              buttonWidth: 100,
              unselectedColor: Color(0xFF272727),
              unselectedBorderColor: Colors.white,
              selectedColor: Color(0xFF536FFC),
              selectedBorderColor: Color(0xFF536FFC),
              unselectedTextStyle: TextStyle(color: Colors.white),
              buttons: const ['추천', '로그'],
              onSelected: (index, isSelected) {
                setState(() {});
              },
            ),

            Container(
              constraints: BoxConstraints(
                maxHeight: 500,
                minHeight: 200,
              ),
              child: StreamBuilder<DataSnapshot>(
                stream: selectRnL(recommend_n_log).get().asStream(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "불러오는중..",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    );
                  }

                  switch(recommendController.selectedIndex){
                    //추천/로그 전환
                    case 0:
                      return Container(
                        width: 300,
                        height: 500,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            Iterable<DataSnapshot>? data = streamSnapshot.data?.child("cocktail based").children.where((element) => element.key == "Gin Tonic");
                            return Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(child: Text("이름", style: TextStyle(fontSize: 25, color: Colors.white),),),
                                    Container(child: Text(data?.length.toString() ?? "", style: TextStyle(fontSize: 25, color: Colors.white70),),),
                                  ],
                                ),
                                Container(
                                  width: 300,
                                  height: 200,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data?.length,
                                    itemBuilder: (context, index) {
                                      Iterable<DataSnapshot>? data = streamSnapshot.data?.children.where((element) => element.key == "Gin Tonic");
                                      return iterateCard(data, index, context);
                                    },
                                  ),
                                ),
                              ],
                              );
                          },
                        ),
                      );
                    case 1:
                      return GridView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: streamSnapshot.data!.children.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: .67,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          Iterable<DataSnapshot> data = streamSnapshot.data!.children;

                          //개별 카드
                          return iterateCard(data, index, context);
                        },
                      );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  DatabaseReference selectRnL(DatabaseReference recommend_n_log){
    if (recommendController.selectedIndex == 1){
      return recommend_n_log.child("log").child(user!.uid.toString());
    } else {
      return recommend_n_log.child('cocktail based');
    }
  }

}
