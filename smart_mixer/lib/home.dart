import 'package:flutter/material.dart';

import 'styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272727),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
        child: Column(
          children: <Widget>[
            Logo(),
            Container(height: 50,),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                              Text('칵테일 믹서', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                              Text('Cocktail mixer', style: TextStyle(color: Colors.orange, fontSize: 25),),
                              Text('COCKTAIL', style: TextStyle(color: Colors.grey, fontSize: 40, fontFamily: 'mmd'),),
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
