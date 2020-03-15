import 'package:assignment_app/Boundary/FirstScreenUI.dart';
import 'package:assignment_app/Boundary/HomePageUI.dart';
import 'package:assignment_app/Boundary/ProfileUI.dart';
import 'package:assignment_app/Boundary/TextResultUI.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

//class Nav extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Navigation(),
//    );
//  }
//}

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(), TextResultUI(),
    FirstScreen() // create the pages you want to navigate between
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(milliseconds: 200),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 40,
          ),
          Icon(
            Icons.info,
            size: 40,
          ),
          Icon(
            Icons.account_box,
            size: 40,
          )
        ],
        onTap: (index) {
          print('$index');
          setState(() {
            this._currentIndex = index;
          });
        },
      ),
    );
  }
}
