import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:group_button/group_button.dart';
import 'package:firebase_database/firebase_database.dart';

import 'styles.dart';
import 'connect.dart';

Map recipeMap = {
  0: 'Rum',
  1: 'Tequila',
  2: 'Gin',
  3: 'Whisky',
  4: 'Vodka',
  5: '기타'
};

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  DatabaseReference snapshot =
      FirebaseDatabase.instance.refFromURL(DB_URL).child("cocktail recipe");

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF272727),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
            child: Column(
              children: <Widget>[
                Logo2(),
                Container(
                  height: 20,
                ),
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
                    setState(() {});
                  },
                ),

                //뷰 아래 표시
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 350,
                    minHeight: 200,
                  ),

                  child: StreamBuilder<DataSnapshot>(
                    stream: snapshot.get().asStream(),
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

                      return GridView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: selectedLength(gController, streamSnapshot),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: .67,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          Iterable<DataSnapshot> data = streamSnapshot
                              .data!.children
                              .where((element) => element.hasChild(""));
                          switch (gController.selectedIndex) {
                            case 0:
                            case 1:
                            case 2:
                            case 3:
                            case 4:
                              data = streamSnapshot.data!.children.where(
                                  (element) => element.hasChild(
                                      recipeMap[gController.selectedIndex]));
                              break;
                            case 5:
                              data = streamSnapshot.data!.children.where(
                                  (element) =>
                                      !element.hasChild("Rum") &&
                                      !element.hasChild("Tequila") &&
                                      !element.hasChild("Gin") &&
                                      !element.hasChild("Whisky") &&
                                      !element.hasChild("Vodka"));
                              break;
                          }

                          //개별 카드
                          return iterateCard(data, index, context);
                        },
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

Widget CocktailItem(int id, String title, String? image) {
  return Container();
}

int selectedLength(GroupButtonController groupButtonController,
    AsyncSnapshot<DataSnapshot> streamSnapshot) {
  if (groupButtonController == null) {
    return 0;
  } else {
    return (groupButtonController.selectedIndex == 5)
        ? streamSnapshot.data!.children
            .where((element) =>
                !element.hasChild("Rum") &&
                !element.hasChild("Tequila") &&
                !element.hasChild("Gin") &&
                !element.hasChild("Whisky") &&
                !element.hasChild("Vodka"))
            .length
        : streamSnapshot.data!.children
            .where((element) => element
                .hasChild(recipeMap[groupButtonController.selectedIndex]))
            .length;
  }
}
