import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mixer/start.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Color(0xFF272727),
      body: Column(
        children: <Widget>[
          Container(height: 50,),
          Text('사용자 명', style: TextStyle(color: Colors.white, fontSize: 20),),
          TextButton(
              onPressed: () {
                try {
                  FirebaseAuth.instance.signOut();
                } on FirebaseAuthException catch (e){

                }
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage()));
              },
              child: Text('로그아웃')
          ),
          Text(user!.uid.toString(), style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}
