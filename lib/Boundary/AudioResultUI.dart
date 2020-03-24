import 'package:assignment_app/Boundary/HomePageUI.dart';
//import 'package:assignment_app/Boundary/SelectionUI.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
//import '../Boundary/LoginUI.dart';
//import '../Control/LoginValidator.dart';
//import 'dart:io';

// ignore: must_be_immutable
class AudioResult extends StatefulWidget {
  String demoUrl;

  AudioResult({this.demoUrl});

  @override
  _AudioResultState createState() => _AudioResultState(demoUrl);
}

class _AudioResultState extends State<AudioResult> {
  String demoUrl;
  _AudioResultState(this.demoUrl);
//  AudioResult({
//    @required this.url,
//  });
  @override
  Widget build(BuildContext context) {
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
            FlatButton(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
              child: Image.asset(
                'images/play_button.jpg',
                height: 175,
                width: 175,
              ),
              onPressed: () {
                print(demoUrl);
                AudioPlayer audioPlayer = new AudioPlayer();
               AudioPlayer.logEnabled = true;
               play(String s) async {
                  int result = await audioPlayer.play(s);
                  if (result == 1) {
                    print('success');
                  }
                }

                play(demoUrl);
              },
            ),

            Center(
              child:
              Row(
                children: <Widget>[
                  FlatButton(
                    padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
                    child: Image.asset(
                      'images/download.jpg',
                      height: 125,
                      width: 125,
                    ),
                    onPressed: () {
                      print('Code needed here to save to archive');
                    },
                  ),
                  FlatButton(
                    padding:
                    const EdgeInsets.symmetric(vertical: 75, horizontal: 0),
                    child: Image.asset(
                      'images/home_button.jpg',
                      height: 125,
                      width: 125,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


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