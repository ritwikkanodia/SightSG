import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class SelectionPage extends StatelessWidget {
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
              Text(
                'Convert To:',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 60,
              ),
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
                      Icons.audiotrack,
                      size: 40,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Audio',
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
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.text_fields,
                      size: 40,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Text',
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
