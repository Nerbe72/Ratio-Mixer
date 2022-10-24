import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:group_button/group_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:word_break_text/word_break_text.dart';
import 'package:get/get.dart';

import 'styles.dart';
import 'connect.dart';

Map recipeMap = {
  0: 'Vodka',
  1: 'Tequila',
  2: 'Gin',
  3: 'Whisky',
  4: 'Rum',
  5: '기타'
};

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  DatabaseReference snapshot =
      FirebaseDatabase.instance.refFromURL(DB_URL);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardHeight = 875.43;
    final designHeight = deviceHeight / standardHeight;

    final deviceWidth = MediaQuery.of(context).size.width;
    final standardWidth = 411.43;
    final designWidth = deviceWidth / standardWidth;

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: defaultBlack,
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
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Image.asset("asset/slide.png")
                ),
                Container(height: 30,),
                GroupButton(
                  isRadio: true,
                  controller: gController,
                  buttons: const ['VODKA', 'TEQUILA', 'GIN', 'WHISKY', 'RUM', '+'],
                  onSelected: (String name, index, selected) {
                    setState((){});
                  },
                  options: GroupButtonOptions(
                    borderRadius: BorderRadius.circular(20.0),
                    buttonWidth: 100,
                    buttonHeight: 25,
                    unselectedColor: defaultBlack,
                    unselectedBorderColor: Colors.white,
                    selectedColor: Color(0xFF536FFC),
                    selectedBorderColor: Color(0xFF536FFC),
                    unselectedTextStyle: TextStyle(color: Colors.white),
                  ),
                ),
                Container(height: 5,),
                //뷰 아래 표시
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 400 * designHeight,
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
                            "LOADING..",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        );
                      }

                      return GridView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: selectedLength(gController, streamSnapshot.data!.child("cocktail recipe")),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.18),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          Iterable<DataSnapshot> data = streamSnapshot
                              .data!.child("cocktail recipe").children
                              .where((element) => element.hasChild(""));
                          switch (gController.selectedIndex) {
                            case 0:
                            case 1:
                            case 2:
                            case 3:
                            case 4:
                              data = streamSnapshot.data!.child("cocktail recipe").children.where(
                                  (element) => element.hasChild(
                                      recipeMap[gController.selectedIndex]));
                              break;
                            case 5:
                              data = streamSnapshot.data!.child("cocktail recipe").children.where(
                                  (element) =>
                                      !element.hasChild("Rum") &&
                                      !element.hasChild("Tequila") &&
                                      !element.hasChild("Gin") &&
                                      !element.hasChild("Whisky") &&
                                      !element.hasChild("Vodka"));
                              break;
                          }


                          print(streamSnapshot.data!.child("cocktail exp").child(nullableString(data, index) ?? " ").children);

                          String exp = " ";
                          String taste = " ";
                          try {
                            exp = streamSnapshot.data!.child("cocktail exp").child(nullableString(data, index) ?? " ").children.elementAt(1).value.toString();
                            taste = streamSnapshot.data!.child("cocktail exp").child(nullableString(data, index) ?? " ").children.elementAt(0).value.toString();
                          } catch(Exception) { }


                          //개별 카드
                          return iterateCard(data, index, context, exp, taste);
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
  Widget iterateCard(Iterable<DataSnapshot>? data, int index,BuildContext context, String exp, String taste){

    return InkWell(
      onTap: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.noHeader,
          animType: AnimType.scale,
          title: "'" + (nullableString(data, index) ?? "") + "'",
          desc: '해당 칵테일을 믹싱합니다',
          titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          descTextStyle: TextStyle(color: Colors.white, fontSize: 18),
          buttonsBorderRadius: BorderRadius.all(Radius.circular(10)),
          btnCancelText: "YES",
          btnOkText: "NO",
          dismissOnBackKeyPress: true,
          dismissOnTouchOutside: true,
          btnCancelColor: Color(0xFF536FFC),
          btnOkColor: Color(0xFFF5368A),
          btnOkOnPress: (){ },
          btnCancelOnPress: (){
            Get.to(() => ConnectionPage(name: data!.elementAt(index).key.toString()));
          },
          dialogBackgroundColor: Color(0xDA929292),
        ).show();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.0),
            color: Color(0xFF7A7A7A),),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.0),
              color: Color(0xFF383838),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.asset('asset/cocktail/'+data!.elementAt(index).key.toString()+'.png'),
                    constraints: BoxConstraints(
                      minHeight: 70,
                      minWidth: 70,
                      maxHeight: 90,
                      maxWidth: 90,
                    ),
                  ),
                ),
                //이름
                Container(
                  child: WordBreakText(
                    nullableString(data, index) ?? "",
                    spacingByWrap: false,
                    wrapAlignment: WrapAlignment.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold, fontSize: 13,
                    ),
                  ),
                ),
                Container(height: 5,),
                //재료
                Container(
                  child: WordBreakText(
                    exp,
                    spacingByWrap: false,
                    wrapAlignment: WrapAlignment.center,
                    style: TextStyle(
                      color: Colors.white, fontSize: 9,
                    ),
                  ),
                ),
                Container(height: 2,),
                //맛
                Expanded(
                  child: WordBreakText(
                    taste,
                    spacingByWrap: false,
                    wrapAlignment: WrapAlignment.center,
                    style: TextStyle(
                      color: Colors.white, fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int selectedLength(GroupButtonController groupButtonController,
      DataSnapshot dataSnapshot) {
    if (groupButtonController == null) {
      return 0;
    } else {
      return (groupButtonController.selectedIndex == 5)
          ? dataSnapshot.children
          .where((element) =>
      !element.hasChild("Rum") &&
          !element.hasChild("Tequila") &&
          !element.hasChild("Gin") &&
          !element.hasChild("Whisky") &&
          !element.hasChild("Vodka"))
          .length
          : dataSnapshot.children
          .where((element) => element
          .hasChild(recipeMap[groupButtonController.selectedIndex]))
          .length;
    }
  }

}


