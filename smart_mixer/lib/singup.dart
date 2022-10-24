import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'styles.dart';
import 'sign_temp.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _email;
  String? _password;
  String? _passwordCheck;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();

  var emailError = '';
  var passwordError = '';
  var passwordCheckError = '';

  final GlobalKey<FormState> _formKeySignup = GlobalKey<FormState>();

  void SaveForm() {
    final form = _formKeySignup.currentState;
    if (form!.validate()) {
      form.save();
      print('Form is valid Email: $_email, password: $_password');
    } else {
      print('Form is invalid Email: $_email, password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272727),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50,),
        child: Form(
          key: _formKeySignup,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Get.offAll(SignTempPage());
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 43,
                  ),
                ),
                Container(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '회원가입',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),

                      //ID입력
                      Container(
                        height: 30,
                      ),


                      Text(
                        '이름 입력',
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        // decoration: textFieldBoxStyle,
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: textFieldStyle,
                        ),
                      ),

                      Container(height: 15,),
                      
                      Text(
                        '이메일 입력',
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        // decoration: textFieldBoxStyle,
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return '이메일을 입력해주세요.';
                            } else {
                              // emailError = '';
                              return null;
                            }
                          },
                          onSaved: (v) => _email = v,
                          cursorColor: Colors.white,
                          decoration: textFieldStyle,
                        ),
                      ),

                      //PW 입력
                      Container(
                        height: 15,
                      ),
                      Text(
                        'PW 입력',
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        // decoration: textFieldBoxStyle,
                        child: TextFormField(
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return '비밀번호를 입력해주세요';
                            } else {
                              if (v.length < 8) {
                                return '비밀번호는 8자리 이상이어야 합니다';
                              } else {
                                // passwordError = '';
                                return null;
                              }
                            }
                          },
                          onSaved: (v) => _password = v,
                          cursorColor: Colors.white,
                          decoration: textFieldStyle,
                        ),
                      ),
                      // Text(
                      //   passwordError,
                      //   style: TextStyle(color: Colors.orange, fontSize: 12),
                      // ),

                      //PW 확인
                      Container(
                        height: 15,
                      ),
                      Text(
                        'PW 확인',
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        // decoration: textFieldBoxStyle,
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordCheckController,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return '비밀번호를 다시 한번 입력해주세요';
                            } else {
                              if (passwordCheckController.text !=
                                  passwordController.text) {
                                return '비밀번호를 확인해주세요';
                              } else {
                                // passwordCheckError = '';
                                return null;
                              }
                            }
                          },
                          onSaved: (v) => _passwordCheck = v,
                          cursorColor: Colors.white,
                          decoration: textFieldStyle,
                        ),
                      ),

                      Container(height: 40,),
                      Column(
                        children: <Widget>[
                          Image.asset('asset/logo4.png', scale: 2.5,),
                          Container( height: 10,),
                        ],
                      ),
                      Container(height: 40,),

                      Row(
                        children: [
                          Expanded(
                            child: new TextButton(
                              child: Text(
                                '확인',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF536FFC),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  )),
                              onPressed: () {
                                _signup();
                              },
                            ),
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
      ),
    );
  }

  Future<void> _signup() async {
    String message = '';
    if (!_formKeySignup.currentState!.validate()) {
      return;
    } else if (passwordController.text != passwordCheckController.text) {
      return;
    } else {
      try {
        // _formKeySignup.currentState!.save();

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        showDialog(
          context: context,
          builder: (BuildContext bc) {

            return AlertDialog(
              content: Text('회원가입이 완료되었습니다!'),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.offAll(SignTempPage());
                    },
                    child: Text('확인'),
                  ),
                ),
              ],
            );
          },
        );

      } on FirebaseAuthException catch (e) {
        String message = '';
        if(e.code == 'email-already-in-use') {
          message = '이미 등록된 이메일입니다.';
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
