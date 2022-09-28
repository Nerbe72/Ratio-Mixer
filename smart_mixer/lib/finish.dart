import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272727),
      body: StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "칵테일을 제조중입니다",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Container(height: 30,),
              SizedBox(
                width: 350,
                height: 350,
                child: Lottie.asset("asset/pour.json", repeat: true, filterQuality: FilterQuality.low, frameRate: FrameRate.max,),
              ),
              Container(height: 30,),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("돌아가기", style: TextStyle(color: Colors.white, fontSize: 25),),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF536FFC),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        }
      ),
    );
  }
}
