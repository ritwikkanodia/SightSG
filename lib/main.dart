import 'package:flutter/material.dart';

import 'Boundary/login_page.dart';
import 'Boundary/imageselection_page.dart';

void main() => runApp(ImageApp());

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
