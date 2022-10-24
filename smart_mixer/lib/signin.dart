import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_mixer/lost_id_pw.dart';
import 'package:smart_mixer/sign_temp.dart';

import 'styles.dart';
import 'nav.dart';
import 'lost_id_pw.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String emailError = '';
  String passwdError = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF272727),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20,),
          child: ListView(
            children: <Widget>[
              IconButton(
                alignment: Alignment.topLeft,
                onPressed: () {
                  Get.offAll(SignTempPage());
                },
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 43,),
              ),
              Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '로그인', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
                    ),

                    Container(height: 45,),
                    Text('이메일 입력', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),),
                    Container(
                      child: TextFormField(
                        controller: _emailController,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        validator: (v) {
                          setState(() {
                            if (v!.isEmpty) {
                              emailError = '이메일을 입력해주세요.';
                            } else {
                              emailError = '';
                            }
                          });
                        },
                        cursorColor: Colors.white,
                        decoration: textFieldStyle,
                      ),
                    ),
                    Text(emailError, style: TextStyle(color: Colors.orange, fontSize: 12),),

                    //PW 입력
                    Container(height: 5,),
                    Text('PW 입력', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),),
                    Container(
                      child: TextFormField(
                        controller: _passwordController,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        obscureText: true,
                        validator: (v) {
                          if (v!.isEmpty) {
                            passwdError = '비밀번호를 입력해주세요.';
                          } else {
                            passwdError = '';
                          }
                          setState(() {});
                        },
                        cursorColor: Colors.white,
                        decoration: textFieldStyle,
                      ),
                    ),
                    Text(passwdError, style: TextStyle(color: Colors.orange, fontSize: 12),),

                    Container(height: 28,),
                    Row(
                      children: [
                        Expanded(
                          child: new TextButton(
                            child: Text('로그인', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF536FFC),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(13.0)),
                                )),
                            onPressed: () => _login(),
                          ),
                        ),
                      ],
                    ),
                     Container(height: 20,),
                     Row(
                       children: [
                         Expanded(child: Divider(color: Colors.grey, thickness: 1.0,),),
                         Text(" 또는 다음으로 로그인 ", style: TextStyle(color: Colors.grey, fontSize: 12),),
                         Expanded(child: Divider(color: Colors.grey, thickness: 1.0,),),
                       ],
                     ),
                    Container(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        OutlinedButton(
                          onPressed: (){},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15),),
                            ),
                            side: BorderSide(
                              color: Colors.grey,
                              width: 1.2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(1, 12, 1, 12),
                            child: Container(
                              child: Column(
                                children: [
                                  Image.asset("asset/G.png", scale: 2.5,),
                                  Container(height: 2,),
                                  Text("google", style: TextStyle(color: Color(0xFFD2D2D2), fontSize: 12),),
                                ],
                              ),
                            ),
                          ),
                        ),

                        OutlinedButton(
                          onPressed: (){},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15),),
                            ),
                            side: BorderSide(
                              color: Colors.grey,
                              width: 1.2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                            child: Container(
                              child: Column(
                                children: [
                                  Image.asset("asset/N.png", scale: 2.5,),
                                  Container(height: 2,),
                                  Text("naver", style: TextStyle(color: Color(0xFFD2D2D2), fontSize: 12),),
                                ],
                              ),
                            ),
                          ),
                        ),

                        OutlinedButton(
                          onPressed: (){},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15),),
                            ),
                            side: BorderSide(
                              color: Colors.grey,
                              width: 1.2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 12, 3, 12),
                            child: Container(
                              child: Column(
                                children: [
                                  Image.asset("asset/K.png", scale: 2.5,),
                                  Container(height: 2,),
                                  Text("kakao", style: TextStyle(color: Color(0xFFD2D2D2), fontSize: 12),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(height: 40,),

                    Column(
                      children: <Widget>[
                        Image.asset('asset/logo4.png', scale: 2.5,),
                        Container( height: 10,),
                      ],
                    ),

                    Container(height: 30,),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: (){
                                Get.to(SearchIdPw());
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(13),),
                                ),
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Text("ID / PW 찾기", style: TextStyle(color: Colors.white,),)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void initState() { super.initState(); }
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _login() async {
    if(_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // if (FirebaseDatabase.instance.refFromURL(DB_URL).child("log").child(FirebaseAuth.instance.currentUser!.uid.toString()).get().isBlank == true) {
        //   var ingred_set = {};
        //   FirebaseDatabase.instance.refFromURL(DB_URL).child("log").child(FirebaseAuth.instance.currentUser!.uid.toString()).set(ingred_set);
        // }

        Get.offAll(() => NavBar());
      } on FirebaseAuthException catch (e) {
        String message = '';
        if(e.code == 'user-not-found') {
          message = '등록된 회원 정보가 없습니다.';
        } else if (e.code == 'invalid-email') {
          message = '등록되지 않은 이메일입니다.';
        } else if (e.code == 'wrong-password') {
          message = '비밀번호가 틀립니다.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.orangeAccent,
          ),
        );
      }
    }
  }

}
