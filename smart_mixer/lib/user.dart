import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_mixer/start.dart';
import 'package:firebase_database/firebase_database.dart';

import 'styles.dart';

final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

DatabaseReference user_log = FirebaseDatabase.instance.refFromURL(DB_URL).child("log").child(uid);
// final users_db = FirebaseDatabase.instance.refFromURL(DB_URL).child("users").child(uid);

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
                child: Text('로그아웃', style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(height: 30,),
            Container(
              constraints: BoxConstraints(
                maxHeight: 500,
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
                      return logCard(data, index, context); //개별 카드
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
