import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

import 'home.dart';
import 'recipe.dart';
import 'user.dart';

class NavBar extends StatefulWidget {

  @override
  State createState() {
    return _NavBar();
  }
}

class _NavBar extends State with SingleTickerProviderStateMixin{
  int tabIndex = 1;
  late TabController tabController = TabController(length: 3, vsync: this, initialIndex: tabIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272727),
      bottomNavigationBar: CircleNavBar(
        inactiveIcons: const [
          Icon(Icons.favorite, color: Colors.white, size: 30,),
          Icon(Icons.home, color: Colors.white, size: 30,),
          Icon(Icons.account_circle, color: Colors.white, size: 30,),
        ],

        activeIcons: const [
          ImageIcon(AssetImage('asset/cocktail.png'), color: Colors.purple, size: 30,),
          Icon(Icons.home, color: Colors.blueAccent, size: 30,),
          Icon(Icons.account_circle, color: Colors.orangeAccent, size: 30,),
        ],

        color: Color(0xFFAAAAAA),
        height: 60,
        circleWidth: 50,
        initIndex: 1,
        onChanged: (v) {
          tabIndex = v;
          tabController.animateTo(v);
          setState(() { });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          RecipePage(),
          HomePage(),
          UserPage(),
        ],
      ),
    );
  }
}
