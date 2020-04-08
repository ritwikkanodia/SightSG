import 'package:assignment_app/Boundary/UserProfileUI.dart';
import 'package:assignment_app/Boundary/HomePageUI.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:assignment_app/Boundary/InfoUI.dart';

/// User Interface for Navigation UI. This UI allows user to navigate between Home Page, Info Page, and User Profile page.
/// @author  Team Superman
/// @version 1.0
/// @since   2020-04-08
class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(), InfoUI(),
    UserProfileUI() // create the pages you want to navigate between
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue[400],
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
