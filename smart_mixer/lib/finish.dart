import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:smart_mixer/nav.dart';

import 'styles.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final standardWidth = 411.43;
    final designWidth = deviceWidth / standardWidth;

    return Scaffold(
      backgroundColor: Color(0xFF262626),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
        child: Column(
          children: [
            StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Logo2(),
                      Container(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Container(
                          height: 330*designWidth,
                          width: 330*designWidth,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 238*designWidth,
                                height: 238*designWidth,
                                child: Lottie.asset("asset/finish.json", repeat: true, filterQuality: FilterQuality.low, frameRate: FrameRate.max,
                                ),
                              ),
                              FloatingActionButton(
                                disabledElevation: 0,
                                mini: true,
                                elevation: 0,
                                backgroundColor: Color(0x00FFFFFF),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "칵테일이 완성되었습니다",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
