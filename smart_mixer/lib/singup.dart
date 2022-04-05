import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'styles.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = new GlobalKey<FormState>();
  String? _id;
  String? _password;

  void SaveForm() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      print('Form is valid Email: $_id, password: $_password');
    } else {
      print('Form is invalid Email: $_id, password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272727),
      body: Padding(
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
                    '회원가입', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                  ),

                  //ID입력
                  Container(height: 30,),
                  Text('ID 입력', style: TextStyle(color: Colors.white, fontSize: 15),),
                  Container(
                    decoration: textFieldBoxStyle,
                    child: TextFormField(
                      style: TextStyle(fontSize: 25),
                      validator: (v) => v!.isEmpty ? '빈칸을 모두 채워주세요': null,
                      onSaved: (v) => _id = v,
                      cursorColor: Colors.white,
                      decoration: textFieldStyle,
                    ),
                  ),

                  //PW 입력
                  Container(height: 20,),
                  Text('PW 입력', style: TextStyle(color: Colors.white, fontSize: 15),),
                  Container(
                    decoration: textFieldBoxStyle,
                    child: TextFormField(
                      style: TextStyle(fontSize: 25),
                      validator: (v) => v!.isEmpty ? '빈칸을 모두 채워주세요': null,
                      onSaved: (v) => _id = v,
                      cursorColor: Colors.white,
                      decoration: textFieldStyle,
                    ),
                  ),

                  //PW 확인
                  Container(height: 20,),
                  Text('PW 확인', style: TextStyle(color: Colors.white, fontSize: 15),),
                  Container(
                    decoration: textFieldBoxStyle,
                    child: TextFormField(
                      style: TextStyle(fontSize: 25),
                      validator: (v) => v!.isEmpty ? '빈칸을 모두 채워주세요': null,
                      onSaved: (v) => _id = v,
                      cursorColor: Colors.white,
                      decoration: textFieldStyle,
                    ),
                  ),

                  //전화번호 입력
                  Container(height: 20,),
                  Text('전화번호 입력', style: TextStyle(color: Colors.white, fontSize: 15),),
                  Container(
                    decoration: textFieldBoxStyle,
                    child: TextFormField(
                      style: TextStyle(fontSize: 25),
                      validator: (v) => v!.isEmpty ? '빈칸을 모두 채워주세요': null,
                      onSaved: (v) => _id = v,
                      cursorColor: Colors.white,
                      decoration: textFieldStyle,
                    ),
                  ),

                  MaterialButton(
                    onPressed: () {},
                    color: Color(0xFF536FFC),
                    child: Text('인증번호 전송', style: TextStyle(color: Colors.white),),
                  ),

                  //비밀번호 확인
                  Container(height: 20,),
                  Text('PW 확인', style: TextStyle(color: Colors.white, fontSize: 15),),
                  Container(
                    decoration: textFieldBoxStyle,
                    child: TextFormField(
                      style: TextStyle(fontSize: 25),
                      validator: (v) => v!.isEmpty ? '빈칸을 모두 채워주세요': null,
                      onSaved: (v) => _id = v,
                      cursorColor: Colors.white,
                      decoration: textFieldStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
