import 'dart:io';

import 'package:assignment_app/Boundary/HomePageUI.dart';
import 'package:assignment_app/size_config.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import '../Control/ArchiveController.dart';

// ignore: must_be_immutable
class AudioResult extends StatefulWidget {
  String convertedText;
  File pic;

  AudioResult({this.convertedText, this.pic});

  @override
  _AudioResultState createState() => _AudioResultState(convertedText, pic);
}

class _AudioResultState extends State<AudioResult> {
  final File pic;
  final String convertedText;
  FlutterTts flutterTts = FlutterTts();

  _AudioResultState(this.convertedText, this.pic);

  Future _speak() async {
    if (convertedText != null) {
      if (convertedText.isNotEmpty) {
        var result = await flutterTts.speak(convertedText);
        //if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double h = SizeConfig.blockSizeVertical;
    final double w = SizeConfig.blockSizeHorizontal;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Audio',
          style: (TextStyle(fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: h * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 15),
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: w * 3, vertical: h * 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5),
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(h * 10),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.play_arrow,
                          size: h * 5,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Play Audio',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: h * 3,
                          ),
                        ),
                        onTap: () {
                          _speak();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(55.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 3, vertical: 3 * h),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3 * w, vertical: 3 * h),
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
                  ),
                ],
              ),
            ), //
          ],
        ),
      ),
    );
  }
}

//Center(
//              child: Row(
//                children: <Widget>[
//                  FlatButton(
//                    padding: const EdgeInsets.symmetric(
//                        vertical: 100, horizontal: 50),
//                    child: Image.asset(
//                      'images/download.jpg',
//                      height: 125,
//                      width: 125,
//                    ),
//                    onPressed: () {
//                      print('Code needed here to save to archive');
//                    },
//                  ),
//                  FlatButton(
//                    padding:
//                        const EdgeInsets.symmetric(vertical: 75, horizontal: 0),
//                    child: Image.asset(
//                      'images/home_button.jpg',
//                      height: 125,
//                      width: 125,
//                    ),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => HomePage()),
//                      );
//                    },
//                  )
//                ],
//              ),
//            ),

// HttpClient client = new HttpClient();
//            var _downloadData = List<int>();
//            var fileSave = new File('./audio.mp3');
//            client.getUrl(Uri.parse(demoUrl))
//                .then((HttpClientRequest request) {
//              return request.close();
//            })
//                .then((HttpClientResponse response) {
//              response.listen((d) => _downloadData.addAll(d),
//                  onDone: () {
//                    fileSave.writeAsBytes(_downloadData);
//                  }
//              );
//            });
