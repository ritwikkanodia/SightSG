import 'dart:io';
import 'dart:typed_data';

import 'package:assignment_app/Control/ArchiveController.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'gradient_app_bar.dart';
import 'size_config.dart';

void main() => runApp(MaterialApp(
  home:  NinjaCard(),  //Determines what is gonna show on the home screen of our app
));

//Lets create a stateless widget which will return a widget tree which will show on our home page

class NinjaCard extends StatefulWidget {
  @override
  _NinjaCardState createState() => _NinjaCardState();
}

class _NinjaCardState extends State<NinjaCard> {

  double fontSize = 10.0;
  List <String> test = ["'Please end this meeting'", "'Before my Brain melts'"]; //The list of string being displayed

  String imageName = "'assets/Meme 1 - Please end this meeting.jpg'";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double h = SizeConfig.blockSizeVertical;
    final double w = SizeConfig.blockSizeHorizontal;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: GradientAppBar(
          centerTitle: true,
          backgroundColorStart: Colors.blue,
          backgroundColorEnd: Colors.green,
          title: Text(
            'Text Results',
            style: (TextStyle(fontSize: (h * 4))),
          ),
        ),


        body: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
          'assets/Meme 1 - Please end this meeting.jpg',
                        height: 200,
                        width: 200,
        ),

                  Divider(
                    height: 60.0, //Height of space above and below divider
                    color: Colors.blue,
                  ),

                  for ( var i in test)
                   Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                '$i',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0, //2 pixels between letters
                                )

                            ),


                            SizedBox(height: 40.0),
                          ]
                      ),


    Row(
    children: <Widget>[
     SizedBox(width: 293.0),
      SizedBox(height: 150.0),
                  Column(
                         children: <Widget>[

                           FloatingActionButton(
                              onPressed: () {
                              setState(() {
                                fontSize += 10;
                            });
                              },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),

                           SizedBox(height: 10.0),

          FloatingActionButton(
            onPressed: () {
            setState(() {
            fontSize -= 10;
            });
           },
          child: Icon(Icons.remove),
          backgroundColor: Colors.blue,
          ),
                         ]

    ),

                         ]
    )
    ]
    )
                  )

    );

  }
}
