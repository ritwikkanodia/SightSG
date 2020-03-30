import 'dart:io';

import 'package:assignment_app/Boundary/HomePageUI.dart';
import 'package:assignment_app/Control/AudioController.dart';
import 'package:assignment_app/size_config.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import '../Control/ArchiveController.dart';
import '../Boundary/NavigationUI.dart';

void main() => runApp(MaterialApp(
      home:
          AudioResult(), //Determines what is gonna show on the home screen of our app
    ));

// ignore: must_be_immutable
class AudioResult extends StatefulWidget {
  String convertedText;
  File pic;

  AudioResult({this.convertedText, this.pic});

  @override
  _AudioResultState createState() => _AudioResultState(convertedText, pic);
}

enum TtsState { playing, stopped }

class _AudioResultState extends State<AudioResult> {
  final File pic;
  final String convertedText;

  //Archive
  bool _isUploading = false;
  bool _isDoneUploading = false;

  //Flutter Text to speech
  TtsState ttsState = TtsState.stopped;
  FlutterTts flutterTts = FlutterTts();
  double volume = 0.5;

  _AudioResultState(this.convertedText, this.pic);

  @override
  initState() {
    super.initState();
    initTts();
  }

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  initTts() {
    flutterTts = FlutterTts();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Audio',
          style: (TextStyle(fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue],
          ),
        ),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                      height: h * 50,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: FileImage(pic),
                          fit: BoxFit.fitHeight,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: h * 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _btnSection(),
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
                              onTap: () async {
                                await pr.show();
                                await ArchiveController.uploadPicture(pic);
                                pr.hide();
                                showDialogBox(h);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 55),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
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
                                  MaterialPageRoute(
                                      builder: (context) => Navigation()),
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
          ],
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

  Widget _btnSection() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white70),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_arrow,
              'PLAY', AudioController.playAudio),
          _buildButtonColumn(Colors.red, Colors.redAccent, Icons.stop, 'STOP',
              AudioController.stopAudio)
        ]));
  }

  Container _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(icon),
                color: color,
                splashColor: splashColor,
                onPressed: () => func(convertedText)),
            Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: Text(label,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: color)))
          ]),
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

//                  Padding(
//                    padding: EdgeInsets.symmetric(horizontal: w * 15),
//                    child: Container(
//                      padding:
//                      EdgeInsets.symmetric(horizontal: w * 3, vertical: h * 3),
//                      decoration: BoxDecoration(
//                        border: Border.all(color: Colors.white, width: 5),
//                        color: Colors.blue,
//                        borderRadius: BorderRadius.all(
//                          Radius.circular(h * 10),
//                        ),
//                      ),
//                      child: ListTile(
//                        leading: Icon(
//                          Icons.play_arrow,
//                          size: h * 5,
//                          color: Colors.white,
//                        ),
//                        title: Text(
//                          'Play Audio',
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            color: Colors.white,
//                            fontSize: h * 3,
//                          ),
//                        ),
//                        onTap: () {
//                          _speak();
////                          print(demoUrl);
////                          AudioPlayer audioPlayer = new AudioPlayer();
////                          AudioPlayer.logEnabled = true;
////                          play(String s) async {
////                            int result = await audioPlayer.play(s);
////                            if (result == 1) {
////                              print('success');
////                            }
////                          }
////                          play(demoUrl);
//                        },
//                      ),
//                    ),
//                  ),
