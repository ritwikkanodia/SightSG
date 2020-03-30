import 'package:flutter/material.dart';
import 'Boundary/LoginUI.dart';

//void main() => runApp(ImageToTextConverterApp());
void main() => runApp(MyApp());

//void main() => runApp(
//      MaterialApp(
//        debugShowCheckedModeBanner: false,
//        home: Scaffold(
//          body: SelectionPage(),
//        ),
//      ),
//    );

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
