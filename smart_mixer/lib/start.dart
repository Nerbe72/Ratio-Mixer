import 'package:flutter/material.dart';

import 'styles.dart';
import 'nav.dart';
import 'singup.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _isLogin = 0;

  @override
  Widget build(BuildContext context) {
    switch (_isLogin) {
      case 1:
      //자동 로그인
        return NavBar();
      case 0:
      default:
      //로그인 화면 출력
        return Scaffold(
          backgroundColor: Color(0xFF272727),
          body: Padding(
            padding: EdgeInsets.fromLTRB(50, 50, 50, 10),
            child: Column(
              children: <Widget>[
                Logo(),
                Container(height: 100,),

                //기존회원
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(0.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    side: BorderSide(width: 2.0, color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text('기존회원', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                          Container(height: 20,),
                          Text('MEMBER', style: TextStyle(color: Colors.grey, fontSize: 40, fontFamily: 'mmd'),),
                        ],
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),

                Container(height: 20,),

                //회원가입
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(0.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    side: BorderSide(width: 2.0, color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text('회원가입', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                          Container(height: 20,),
                          Text('SIGN UP', style: TextStyle(color: Colors.grey, fontSize: 40, fontFamily: 'mmd'),),
                        ],
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SignUpPage(),),
                    );
                  },
                ),

                //디버깅용
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => NavBar()),
                    );
                  },
                  child: Text('디버깅용..', style: TextStyle(fontSize: 15, color: Colors.white),),),

              ],
            ),
          ),
        );
    }

  }
}