import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

import 'home.dart';
import 'recipe.dart';
import 'user.dart';
import 'styles.dart';

class NavBar extends StatefulWidget {

  @override
  State createState() {
    return _NavBar();
  }
}

class _NavBar extends State with SingleTickerProviderStateMixin{
  late TabController tabController = TabController(length: 3, vsync: this, initialIndex: tabIndex);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: defaultBlack,
      bottomNavigationBar: CircleNavBar(
        inactiveIcons: const [
          Icon(Icons.favorite, color: Color(0xFFAAAAAA), size: 30,),
          Icon(Icons.home, color: Color(0xFFAAAAAA), size: 30,),
          Icon(Icons.account_circle, color: Color(0xFFAAAAAA), size: 30,),
        ],

        activeIcons: const [
          ImageIcon(AssetImage('asset/cocktail.png'), color: Colors.purple, size: 30,),
          Icon(Icons.home, color: Colors.blueAccent, size: 30,),
          Icon(Icons.account_circle, color: Colors.orangeAccent, size: 30,),
        ],
        color: Colors.white,
        gradient: (tabIndex == 2) ? LinearGradient(
          colors: [Color(0xFF656565), Color(0xFFAAAAAA)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ) : (tabIndex == 0 ? LinearGradient(
          colors: [Color(0xFF656565), Color(0xFFAAAAAA)],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ) : RadialGradient(
          colors: [Color(0xFFAAAAAA), Color(0xFF656565)],
          radius: 0.5,
        )),
        height: 50,
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
          HomePage(tabController: tabController,),
          UserPage(),
        ],
      ),
    );
  }
}
