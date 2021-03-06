import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'styles.dart';
import 'start.dart';
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
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 50,
        ),
        child: Form(
          key: _formKeySignup,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                Container(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '????????????',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),

                      //ID??????
                      Container(
                        height: 30,
                      ),
                      Text(
                        '????????? ??????',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Container(
                        // decoration: textFieldBoxStyle,
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return '???????????? ??????????????????.';
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
                      // Text(
                      //   emailError,
                      //   style: TextStyle(color: Colors.orange, fontSize: 12),
                      // ),

                      //PW ??????
                      Container(
                        height: 20,
                      ),
                      Text(
                        'PW ??????',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Container(
                        // decoration: textFieldBoxStyle,
                        child: TextFormField(
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return '??????????????? ??????????????????';
                            } else {
                              if (v.length < 8) {
                                return '??????????????? 8?????? ??????????????? ?????????';
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

                      //PW ??????
                      Container(
                        height: 20,
                      ),
                      Text(
                        'PW ??????',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Container(
                        // decoration: textFieldBoxStyle,
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordCheckController,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return '??????????????? ?????? ?????? ??????????????????';
                            } else {
                              if (passwordCheckController.text !=
                                  passwordController.text) {
                                return '??????????????? ??????????????????';
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
                      // Text(
                      //   passwordCheckError,
                      //   style: TextStyle(color: Colors.orange, fontSize: 12),
                      // ),

                      Container(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: new TextButton(
                              child: Text(
                                '????????????',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF536FFC),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
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
              content: Text('??????????????? ?????????????????????!'),
              actions: [
                Center(
                  child: FlatButton(
                    onPressed: () {
                      Get.offAll( () => SignTempPage());
                    },
                    child: Text('??????'),
                  ),
                ),
              ],
            );
          },
        );

      } on FirebaseAuthException catch (e) {
        String message = '';
        if(e.code == 'email-already-in-use') {
          message = '?????? ????????? ??????????????????.';
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
