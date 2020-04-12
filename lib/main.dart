import 'package:flutter/material.dart';
import 'View/LoginUI.dart';

void main() => runApp(MyApp());

/// Main entry point to the application
/// @author  Team Superman
/// @version 1.0
/// @since   2020-04-08
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutterr Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}