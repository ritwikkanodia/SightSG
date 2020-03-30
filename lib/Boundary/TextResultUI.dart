import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../size_config.dart';
import '../Control/ArchiveController.dart';
import 'package:assignment_app/Boundary/HomePageUI.dart';
import '../Boundary/NavigationUI.dart';

void main() => runApp(MaterialApp(
      home:
          TextResult(), //Determines what is gonna show on the home screen of our app
    ));
//Lets create a stateless widget which will return a widget tree which will show on our home page

class TextResult extends StatefulWidget {
  List<String> convertedText;
  File pic;

  TextResult({this.convertedText, this.pic});

  @override
  _TextResultState createState() => _TextResultState(convertedText, pic);
}

class _TextResultState extends State<TextResult> {
  double fontSize = 10.0;
  final File pic;
  final List<String> convertedText;

  _TextResultState(this.convertedText, this.pic);

  String imageName = "'assets/Meme 1 - Please end this meeting.jpg'";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double h = SizeConfig.blockSizeVertical;
    final double w = SizeConfig.blockSizeHorizontal;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true);

    pr.style(
        message: 'Uploading file...',
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
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
                      image: FileImage(pic),
                      fit: BoxFit.contain,
                    ),
                  )),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (String i in convertedText)
                      Column(
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
                  onTap: () async {
                    await pr.show();
                    await ArchiveController.uploadPicture(pic);
                    pr.hide();
                    showDialogBox(h);
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
                      MaterialPageRoute(builder: (context) => Navigation()),
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

  Future showDialogBox(double h) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
              title: Text("Upload to archive"),
              content: Row(
                children: <Widget>[
                  Icon(
                    Icons.cloud_done,
                    color: Colors.lightBlue,
                  ),
                  SizedBox(
                    height: 10.0,
                    width: 10.0,
                  ),
                  Text(
                    "Upload completed!",
                    style: (TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ));
        });
  }
}
