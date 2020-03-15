import 'package:assignment_app/Boundary/HomePageUI.dart';
import 'package:assignment_app/Boundary/NavigationUI.dart';
import 'package:flutter/material.dart';
import 'Boundary/LoginUI.dart';
import 'Boundary/NavigationUI.dart';

void main() => runApp(MyApp());

//void main() => runApp(
//      MaterialApp(
//        debugShowCheckedModeBanner: false,
//        home: Scaffold(
//          body: HomePage(),
//        ),
//      ),
//    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterr Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
