import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Boundary/LoginUI.dart';
import '../Control/LoginValidator.dart';
import 'package:assignment_app/size_config.dart';

class InfoUI extends StatelessWidget {
  List<Color> _colors = [Colors.blue, Colors.purpleAccent];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double h = SizeConfig.blockSizeVertical;
    final double w = SizeConfig.blockSizeHorizontal;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue],
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      Icons.camera,
                      size: 80,
                      color: Colors.white,
                    ),
                    Text(
                      'Sight',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: _colors),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Version 1',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: h * 3,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(w * 3),
                      child: RaisedButton(
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(w * 2),
                          child: Text(
                            'User\'s Guide',
                            style:
                                TextStyle(color: Colors.blue, fontSize: h * 4),
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          _ackAlert(context, 'Instruction',
                              'Step 1: Select an image to be processed via Camera/Gallery/Archieve. \n\nStep 2: Select image to be converted to Audio/Text \n\nStep 3: Result will be displayed within 2 seconds \n\n');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(w * 3),
                      child: RaisedButton(
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(w * 2),
                          child: Text(
                            'Contact Us',
                            style:
                                TextStyle(color: Colors.blue, fontSize: h * 4),
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          _ackAlert(context, 'Contact Us',
                              'Email: arjunmann73@gmail.com \n\n Hp No: 97159366');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _ackAlert(BuildContext context, String title, String contents) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(contents),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
