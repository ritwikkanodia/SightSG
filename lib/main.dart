import 'package:flutter/material.dart';

import 'Boundary/LoginUI.dart';
import 'Boundary/ImageSelectionUI.dart';

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
