import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'styles.dart';
import 'start.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void SaveForm() {
    final form = _formKey.currentState;
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
          key: _formKey,
          child: SingleChildScrollView(
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
                        '회원가입', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                      ),

                      //ID입력
                      Container(height: 30,),
                      Text('이메일 입력', style: TextStyle(color: Colors.white, fontSize: 15),),
                      Container(
                        decoration: textFieldBoxStyle,
                        child: TextFormField(
                          controller: emailController,
                          style: TextStyle(fontSize: 25),
                          validator: (v) {
                            setState(() {
                              if (v!.isEmpty) {
                                emailError = '이메일을 입력해주세요.';
                                return;
                              } else {
                                emailError = '';
                              }
                            });
                          },
                          onSaved: (v) => _email = v,
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
                          controller: passwordController,
                          obscureText: true,
                          style: TextStyle(fontSize: 25),
                          validator: (v) {
                            setState(() {
                              if (v!.isEmpty) {
                                passwordError = '비밀번호를 입력해주세요.';
                                return;
                              } else {
                                if (v.length < 8) {
                                  passwordError = '비밀번호는 8자리 이상이어야 입니다';
                                  return;
                                } else {
                                  passwordError = '';
                                }
                              }
                            });
                          },
                          onSaved: (v) => _password = v,
                          cursorColor: Colors.white,
                          decoration: textFieldStyle,
                        ),
                      ),
                      Text(passwordError, style: TextStyle(color: Colors.orange, fontSize: 12),),

                      //PW 확인
                      Container(height: 20,),
                      Text('PW 확인', style: TextStyle(color: Colors.white, fontSize: 15),),
                      Container(
                        decoration: textFieldBoxStyle,
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordCheckController,
                          style: TextStyle(fontSize: 25),
                          validator: (v) {
                            setState(() {
                              if (v!.isEmpty) {
                                passwordCheckError = '비밀번호를 다시 한번 입력해주세요.';
                                return;
                              } else {
                                if(passwordCheckController.text != passwordController.text) {
                                  passwordCheckError = '비밀번호를 확인해주세요.';
                                  return;
                                } else {
                                  passwordCheckError = '';
                                }
                              }
                            });
                          },
                          onSaved: (v) => _passwordCheck = v,
                          cursorColor: Colors.white,
                          decoration: textFieldStyle,
                        ),
                      ),
                      Text(passwordCheckError, style: TextStyle(color: Colors.orange, fontSize: 12),),


                      Container(height: 30,),
                      Row(
                        children: [
                          Expanded(
                            child: new TextButton(
                              child: Text('회원가입', style: TextStyle(color: Colors.white, fontSize: 25),),
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF536FFC),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (passwordController.text != passwordCheckController.text){
      return;
    }
    try {
      _formKey.currentState!.save();

      FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      
      showDialog(context: context, builder: (BuildContext bc) {
        return AlertDialog(
          content: Text('회원가입이 완료되었습니다!'),
          actions: [
            Center(
              child: FlatButton(onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/start'));
              },child: Text('확인'),),
            ),
          ],
        );
      });
    } catch (e) {

    }


  }
}
