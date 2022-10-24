import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'styles.dart';
import "nav.dart";

class HomePage extends StatefulWidget {
  final TabController? tabController;
  HomePage({this.tabController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final tabC = widget.tabController;

    final deviceHeight = MediaQuery.of(context).size.height;
    final standardHeight = 875.43;
    final designHeight = deviceHeight / standardHeight;

    return Scaffold(
      backgroundColor: defaultBlack,
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
        child: Column(
          children: <Widget>[
            Logo(),
            Container(height: 30,),
            SingleChildScrollView(
              child: Container(
                height: 527 * designHeight,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          style: buttonStyle,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text('칵테일 믹서', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                                  Text('Cocktail mixer', style: TextStyle(color: Colors.orange, fontSize: 20, fontFamily: 'sanserif'),),
                                  Text('COCKTAIL', style: TextStyle(color: Color(0xFF505050), fontSize: 32, fontFamily: 'mmd'),),
                                  Visibility(
                                    visible: false,
                                    maintainSize: false,
                                    maintainState: true,
                                    maintainAnimation: false,
                                    maintainInteractivity: false,
                                    child: Row(
                                      children: [
                                        Lottie.asset("asset/pour.json"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onPressed: () {
                            tabIndex = 0;
                            tabC!.animateTo(0);
                          },
                        ),
                        Container(height: 20,),
                        OutlinedButton(
                          style: buttonStyle,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text('커피 믹서', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                                  Text('Coffee mixer', style: TextStyle(color: Colors.orange, fontSize: 20, fontFamily: 'sanserif'),),
                                  Text('COFFEE', style: TextStyle(color: Color(0xFF505050), fontSize: 32, fontFamily: 'mmd'),),
                                  Visibility(
                                    visible: false,
                                    maintainSize: false,
                                    maintainState: true,
                                    maintainAnimation: false,
                                    maintainInteractivity: false,
                                    child: Row(
                                      children: [
                                        Lottie.asset("asset/pour.json"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onPressed: () {},
                        ),
                        Container(height: 20,),
                        OutlinedButton(
                          style: buttonStyle,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text('염료 믹서', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                                  Text('Dye mixer', style: TextStyle(color: Colors.orange, fontSize: 20, fontFamily: 'sanserif'),),
                                  Text('DYE', style: TextStyle(color: Color(0xFF505050), fontSize: 32, fontFamily: 'mmd'),),
                                  Visibility(
                                    visible: false,
                                    maintainSize: false,
                                    maintainState: true,
                                    maintainAnimation: false,
                                    maintainInteractivity: false,
                                    child: Row(
                                      children: [
                                        Lottie.asset("asset/pour.json"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onPressed: () {},
                        ),
                        Container(height: 20,),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
