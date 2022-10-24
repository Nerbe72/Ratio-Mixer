import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_mixer/signin.dart';
import 'package:smart_mixer/styles.dart';

class SearchIdPw extends StatefulWidget {

  @override
  State<SearchIdPw> createState() => _SearchIdPwState();
}

class _SearchIdPwState extends State<SearchIdPw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: defaultBlack,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          children: [
            IconButton(
              alignment: Alignment.topLeft,
              onPressed: () {
                Get.offAll(SignInPage());
              },
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 43,),
            ),

            Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID/PW 찾기', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
                  ),

                  Container(height: 45,),

                  Text('ID 찾기', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),),

                  Container(
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      obscureText: true,
                      validator: (v) {},
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                        hoverColor: Colors.white,
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 12,top: 8,bottom: 8),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        hintText: "이름을 입력해주세요",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  Container(height: 10,),
                  Container(
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      obscureText: true,
                      validator: (v) {},
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                        hoverColor: Colors.white,
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 12,top: 8,bottom: 8),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        hintText: "전화번호를 입력해주세요",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  Container(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: new TextButton(
                          child: Text('ID 찾기', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF536FFC),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(13.0)),
                              )),
                          onPressed: (){},
                        ),
                      ),
                    ],
                  ),


                  Container(height: 45,),

                  Text('PW 찾기', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),),


                  Container(
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      obscureText: true,
                      validator: (v) {},
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                        hoverColor: Colors.white,
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 12,top: 8,bottom: 8),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        hintText: "이메일을 입력해주세요",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  Container(height: 10,),
                  Container(
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      obscureText: true,
                      validator: (v) {},
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                        hoverColor: Colors.white,
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 12,top: 8,bottom: 8),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        hintText: "전화번호를 입력해주세요",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),

                  Container(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: new TextButton(
                          child: Text('PW 찾기', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF536FFC),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(13.0)),
                              )),
                          onPressed: (){},
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

                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
