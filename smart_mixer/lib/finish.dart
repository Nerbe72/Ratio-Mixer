import 'package:flutter/material.dart';

import 'styles.dart';
import 'nav.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBlack,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("asset/bottle.png"),
            Text("칵테일이 완성되었습니다", style: TextStyle(color: Colors.white, fontSize: 20),),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "완료",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
