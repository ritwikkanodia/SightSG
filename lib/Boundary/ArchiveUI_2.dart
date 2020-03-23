import 'dart:io';
import 'package:assignment_app/Boundary/AudioResultUI.dart';
import 'package:assignment_app/Boundary/HomePageUI.dart';
import 'package:assignment_app/Boundary/SelectionUI.dart';
import 'package:flutter/material.dart';
import '../Boundary/LoginUI.dart';
import '../Control/LoginValidator.dart';

class ArchiveUI_2 extends StatefulWidget {
  @override
  _ArchiveUI_2State createState() => _ArchiveUI_2State();
}

class _ArchiveUI_2State extends State<ArchiveUI_2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Your Archive',
            style: (TextStyle(fontWeight: FontWeight.bold)),
          ),
          centerTitle: true,
        ),
        body: new GridView.extent(
          maxCrossAxisExtent: 250.0,
          children: _buildGridTiles(9, context), // new function to be defined
        ));
  }
}

List<Widget> _buildGridTiles(numOfTiles, BuildContext context) {
  List<Container> containers =
    new List<Container>.generate(numOfTiles, (int index) {
    final imageName = 'images/${index + 1}.jpeg';
    return new Container(
      child: FlatButton(
        child: Image.asset(imageName),
        onPressed: () {
          var myFile = new File(imageName);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectionPage(pic: myFile)),
          );
        },
      ),
    );
  });
  return containers;
}

//Container(
//child: FlatButton(
//child: Image.asset('images/1.jpeg'),
//onPressed: () {
//Navigator.push(
//context,
//MaterialPageRoute(builder: (context) => SelectionPage()),
//);
//},
//),
//),
