import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_button/group_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:word_break_text/word_break_text.dart';

import 'styles.dart';

String DB_URL = "https://smart-mixer-tukorea-s4-6-default-rtdb.firebaseio.com/";
Map recipeMap = {0:'럼', 1:'데킬라', 2:'진', 3:'위스키', 4:'보드카', 5:'기타'};

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  DatabaseReference snapshot = FirebaseDatabase.instance.refFromURL(DB_URL).child("cocktail recipe");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF272727),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
        child: ListView(
          children: <Widget>[
            Logo2(),
            Container(height: 30,),
            Container(height: 200, width: 400, color: Colors.black, child: Text('슬라이드 카드 형식으로 추천', style: TextStyle(color: Colors.white),),),
            Container(height: 20,),
            GroupButton(
              isRadio: true,
              controller: gController,
              borderRadius: BorderRadius.circular(20.0),
              buttonWidth: 100,
              unselectedColor: Color(0xFF272727),
              unselectedBorderColor: Colors.white,
              selectedColor: Color(0xFF536FFC),
              selectedBorderColor: Color(0xFF536FFC),
              unselectedTextStyle: TextStyle(color: Colors.white),
              buttons: const ['럼', '데킬라', '진', '위스키', '보드카', '기타'],
              onSelected: (index, isSelected) {
                setState(() {  });
              },
            ),

            SingleChildScrollView(
              child: Container(
                height: 300,
                child: StreamBuilder<DataSnapshot>(
                  stream: snapshot.get().asStream(),
                  builder: (context, streamSnapshot) {
                    if (streamSnapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: 20),
                        child: Text("불러오는중..", style: TextStyle(color: Colors.white,fontSize: 15),),
                      );
                    };
                    return GridView.builder(
                      itemCount: selectedLength(gController, streamSnapshot),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: .67,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,),
                      itemBuilder: (context, index) {
                        Iterable<DataSnapshot> data = streamSnapshot.data!.children.where((element) => element.hasChild(""));
                        switch (gController.selectedIndex) {
                          case 0:
                          case 1:
                          case 2:
                          case 3:
                          case 4:
                            data = streamSnapshot.data!.children.where((element) => element.hasChild(recipeMap[gController.selectedIndex]));
                            break;
                          case 5:
                            data = streamSnapshot.data!.children.where((element) => element.hasChild("깔루아"));
                            break;
                        }
                        return Container(
                          // color: Color(0xFF626262),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withAlpha(950),
                                Color(0xFF7742FA),
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Color(0xFF626262),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      //todo : 이미지 삽입
                                      height: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 90,
                                    alignment: Alignment.center,
                                    child: WordBreakText(
                                      nullableString(data, index),
                                      spacingByWrap: true,
                                      wrapAlignment: WrapAlignment.center,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget CocktailItem(int id, String title, String? image){
  return Container(

  );
}

String nullableString(Iterable<DataSnapshot> data, int index){
  if (data.length == 0) {
    return "";
  }
  return data.elementAt(index).key.toString();
}

int selectedLength(GroupButtonController groupButtonController, AsyncSnapshot<DataSnapshot> streamSnapshot) {
  if (groupButtonController == null) {
    return 0;
  } else {
    return (groupButtonController.selectedIndex == 5) ? streamSnapshot.data!.children.where((element) => !element.hasChild("럼") && !element.hasChild("깔루아")).length
        : streamSnapshot.data!.children.where((element) => element.hasChild(recipeMap[groupButtonController.selectedIndex])).length;
  }
}