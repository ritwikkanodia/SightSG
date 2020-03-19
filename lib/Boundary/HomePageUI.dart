import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          centerTitle: true,
          backgroundColorStart: Colors.blue,
          backgroundColorEnd: Colors.green,
          title: Text(
            'Sight',
            style: (TextStyle(fontSize: 25)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(

                    leading: Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Take Photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    onTap: () {
                      print('abc');
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(55.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      size: 40,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Browse Gallery',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    onTap: () {
                      print('abc');
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.cloud,
                      size: 40,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Archived Photos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    onTap: () {
                      print('abc');
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
