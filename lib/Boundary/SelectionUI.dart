import '../Boundary/AudioResultUI.dart';
import '../Boundary/TextResultUI.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dart:io';
import 'package:assignment_app/size_config.dart';
import '../Control/ArchiveController.dart';
import '../Control/ConverterController.dart';

class SelectionPage extends StatelessWidget {
  final File pic;
  SelectionPage({
    @required this.pic,
  }); //: super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double h = SizeConfig.blockSizeVertical;
    final double w = SizeConfig.blockSizeHorizontal;

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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[100], Colors.blue],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                      width: h * 40,
                      height: h * 40,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: FileImage(pic),
                          fit: BoxFit.contain,
                        ),
                      )),
                ),
                SizedBox(
                  height: h * 3,
                ),
                Text(
                  'Convert To:',
                  style: TextStyle(
                    fontSize: h * 5,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: h * 3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: h * 8),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: h * 6, vertical: w * 3),
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
                          fontSize: h * 4,
                        ),
                      ),
                      onTap: () async {
                        print('Running text to speech...');
                        ConverterController textToSpeech =
                            new ConverterController();
                        String convertedText =
                            await textToSpeech.ImageToTextConverterForTts(pic);
                        //String url= 'https://ffpoazure.blob.core.windows.net/chean-koh/chean-koh.mp3';
                        print(convertedText);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioResult(
                                convertedText: convertedText, pic: this.pic),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: h * 8, vertical: (h * 5)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: h * 6, vertical: w * 3),
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
                          fontSize: h * 4,
                        ),
                      ),
                      onTap: () async {
                        print('Running image to text...');
                        ConverterController imageToText =
                            new ConverterController();
                        String convertedText =
                            await imageToText.ImageToTextConverterForTts(pic);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TextResult(
                                convertedText: convertedText, pic: this.pic),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: h * 8, vertical: (h * 5)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: h * 6, vertical: w * 3),
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
                        'Upload',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: h * 4,
                        ),
                      ),
                      onTap: () {
//                      ArchiveController.uploadPicture(pic);
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => TextResultUI(
//                          ),
//                        ),
//                      );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
