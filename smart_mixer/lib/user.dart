import 'package:flutter/material.dart';

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
      body: Column(
        children: <Widget>[
          Container(height: 50,),
          Text('사용자', style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}
