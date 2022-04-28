import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'styles.dart';
import 'nav.dart';

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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 50,),
              ),
              Container(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '로그인', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              //Id 입력
              Container(height: 30,),
              Text('이메일 입력', style: TextStyle(color: Colors.white, fontSize: 15),),
              Container(
                decoration: textFieldBoxStyle,
                child: TextFormField(
                  controller: _emailController,
                  style: TextStyle(fontSize: 25, color: Colors.white),
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
              Container(height: 20,),
              Text('PW 입력', style: TextStyle(color: Colors.white, fontSize: 15),),
              Container(
                decoration: textFieldBoxStyle,
                child: TextFormField(
                  controller: _passwordController,
                  style: TextStyle(fontSize: 25, color: Colors.white),
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

              Container(height: 30,),
              Row(
                children: [
                  Expanded(
                    child: new TextButton(
                      child: Text('로그인', style: TextStyle(color: Colors.white, fontSize: 25),),
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF536FFC),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          )),
                      onPressed: () => _login(),
                    ),
                  ),
                ],
              ),

              //todo : 구글 로그인
              //todo : 비밀번호 찾기
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
