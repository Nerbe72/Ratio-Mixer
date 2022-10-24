import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:word_break_text/word_break_text.dart';
import 'package:group_button/group_button.dart';

import 'start.dart';
import 'styles.dart';
import 'connect.dart';

final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

DatabaseReference user_log = FirebaseDatabase.instance.refFromURL(DB_URL).child("log").child(uid);

double sour = 1.0;
double sweet = 1.0;
double alcohol = 1.0;

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardHeight = 875.43;
    final designHeight = deviceHeight / standardHeight;

    final deviceWidth = MediaQuery.of(context).size.width;
    final standardWidth = 411.43;
    final designWidth = deviceWidth / standardWidth;

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
                  } on FirebaseAuthException catch (e) {

                  }
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StartPage()));
                },
                child: Text(FirebaseAuth.instance.currentUser!.email.toString(), style: TextStyle(color: Colors.white),),
              ),
            ),
            GroupButton(
              isRadio: true,
              controller: uController,
              buttons: const ['COCKTAIL', 'COFFEE', 'DYE'],
              onSelected: (String name, index, selected) {
                // setState((){});
              },
              options: GroupButtonOptions(
                borderRadius: BorderRadius.circular(20.0),
                buttonWidth: 100,
                unselectedColor: defaultBlack,
                unselectedBorderColor: Colors.white,
                selectedColor: Color(0xFF536FFC),
                selectedBorderColor: Color(0xFF536FFC),
                unselectedTextStyle: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: 570*designHeight,
                minHeight: 200,
              ),
              child: StreamBuilder<DataSnapshot>(
                stream: user_log.get().asStream(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 20),
                    );
                  }

                  return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: streamSnapshot.data?.children.length??0,
                    itemBuilder: (context, index) {
                      Iterable<DataSnapshot> data = streamSnapshot.data!.children;
                      return logCard(data, index, context, designWidth); //개별 카드
                    },
                  );
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InkWell logCard(Iterable<DataSnapshot>? data, int index,BuildContext context, double designWidth){
  DatabaseReference log_snapshot =
  FirebaseDatabase.instance.refFromURL(DB_URL).child("log").child(FirebaseAuth.instance.currentUser!.uid.toString());

  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      log_snapshot.child(data!.elementAt(index).key.toString()).onValue.listen((DatabaseEvent event){
        Navigator.push(context, MaterialPageRoute(builder: (context)
        => ConnectionPage(name: data.elementAt(index).key.toString(), log_length: event.snapshot.children.length, log_list: event.snapshot.children)));
      });
    },
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 40,
          maxHeight: 100,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withAlpha(950),
              Color(0xFF7742FA),
            ],),),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color(0xFF626262),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160*designWidth,
                          alignment: Alignment.centerLeft,
                          child: WordBreakText(
                            nullableString(data, index) ?? "",
                            spacingByWrap: true,
                            wrapAlignment: WrapAlignment.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 160*designWidth,
                          alignment: Alignment.centerLeft,
                          child: (Text((data?.elementAt(index).child("time").value).toString(), style: TextStyle(fontSize: 15, color: Colors.orange),)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
