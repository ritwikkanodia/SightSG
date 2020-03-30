import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../size_config.dart';
import '../Control/ArchiveController.dart';
import 'package:assignment_app/Boundary/HomePageUI.dart';

void main() => runApp(MaterialApp(
      home:
          TextResult(), //Determines what is gonna show on the home screen of our app
    ));

//Lets create a stateless widget which will return a widget tree which will show on our home page

class TextResult extends StatefulWidget {
  String convertedText;
  File pic;

  TextResult({this.convertedText, this.pic});

  @override
  _TextResultState createState() => _TextResultState(convertedText, pic);
}

class _TextResultState extends State<TextResult> {
  double fontSize = 10.0;
  final File pic;
  final String convertedText;
  List<String> test = [
    "'Please end this meeting'",
    "'Before my Brain melts'"
  ]; //The list of string being displayed

  _TextResultState(this.convertedText, this.pic);

  String imageName = "'assets/Meme 1 - Please end this meeting.jpg'";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double h = SizeConfig.blockSizeVertical;
    final double w = SizeConfig.blockSizeHorizontal;
    test.add(convertedText);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GradientAppBar(
        centerTitle: true,
        //backgroundColorStart: Colors.blue,
        //backgroundColorEnd: Colors.green,
        title: Text(
          'Text Results',
          style: (TextStyle(fontSize: (h * 4))),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: h * 50,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: AssetImage("images/3.jpeg"),
                      fit: BoxFit.fill,
                    ),
                  )),
//                  Image.asset(
//                  Image.asset(
//                    'assets/Meme 1 - Please end this meeting.jpg',
//                    height: 200,
//                    width: 200,
//                  ),

              Divider(
                height: 10.0, //Height of space above and below divider
                color: Colors.blue,
              ),
              Container(
                padding: EdgeInsets.only(top: w * 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    for (var i in test)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('$i',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0, //2 pixels between letters
                              )),
                          SizedBox(height: h * 5),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 5 * h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () {
                      setState(() {
                        fontSize -= 10;
                      });
                    },
                    child: Icon(Icons.remove),
                    backgroundColor: Colors.blue,
                  ),
                  SizedBox(width: 10.0),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        fontSize += 10;
                      });
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
              SizedBox(height: w * 10),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: w * 3, vertical: 3 * h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(h * 10),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.cloud,
                    size: h * 5,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Upload to Archive',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: h * 3,
                    ),
                  ),
                  onTap: () {
                    ArchiveController.uploadPicture(pic);
                  },
                ),
              ),
              SizedBox(height: w * 10),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 3 * w, vertical: 3 * h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(h * 10),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    size: h * 5,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: h * 3,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
