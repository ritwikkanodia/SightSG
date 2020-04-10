import 'dart:io';


import 'package:assignment_app/Boundary/MainButton.dart';
import 'package:assignment_app/Control/AudioController.dart';
import 'package:assignment_app/size_config.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import '../Control/ArchiveController.dart';
import '../Boundary/NavigationUI.dart';

/// User Interface for Audio Result. Outputs the audio of the text contained in the uploaded image.
/// This UI includes: Uploaded image, Play and stop button for the audio, Upload button, Home button
/// @author  Team Superman
/// @version 1.0
/// @since   2020-04-08
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

    goToNavigation() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Navigation()),
      );
    }

    uploadToArchive() async {
      await pr.show();
      await ArchiveController.uploadPicture(pic);
      pr.hide();
      showDialogBox();
    }

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
                          image: FileImage(pic), //FileImage(pic),
                          fit: BoxFit.contain,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: h * 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _btnSection(),
                        mainButton(w, h, Icons.cloud, "Upload to Archive",
                            uploadToArchive, EdgeInsets.all(w * 5)),
                        mainButton(w, h, Icons.home, "Home", goToNavigation,
                            EdgeInsets.symmetric(horizontal: w * 5)),
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

  /// This method returns a dialog box to show the upload progress
  /// @param Nothing.
  ///  @return a dialog box to show the upload progress
  Future showDialogBox() {
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

  /// This method provides a play and stop button for the audio
  /// @author  Team Superman
  /// @version 1.0
  /// @since   2020-04-08
  Widget _btnSection() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white70),
        child: Material(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _buildButtonColumn(Colors.green, Colors.greenAccent,
                Icons.play_arrow, 'PLAY', AudioController.playAudio),
            _buildButtonColumn(Colors.red, Colors.redAccent, Icons.stop, 'STOP',
                AudioController.stopAudio)
          ]),
        ));
  }

  /// This method returns a container containing a button to be pressed
  ///
  /// @author  Team Superman
  /// @version 1.0
  /// @since   2020-04-08
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
