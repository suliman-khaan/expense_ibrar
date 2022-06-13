import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expense/src/pages/profile.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int pageIndex = 2;
  final Color color1 = const Color.fromRGBO(124, 220, 149, 1);
  final Color color2 = const Color.fromRGBO(33, 207, 184, 1);
  List<Widget> pages = [
    const Home(),
    const Profile(),
    const Home(),
    const Profile(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: pages[pageIndex],
        bottomNavigationBar: AnimatedBottomNavigationBar(
          activeColor: color1,
          splashColor: color2,
          inactiveColor: Colors.black.withOpacity(0.5),
          icons: const [
            Icons.search,
            Icons.favorite,
            Icons.home,
            Icons.settings,
          ],
          activeIndex: pageIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 10,
          iconSize: 25,
          rightCornerRadius: 10,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          //other params
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: color1,
            // ignore: prefer_const_constructors
            child: Icon(
              Icons.add,
              size: 25,
            )),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
