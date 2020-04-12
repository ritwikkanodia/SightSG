import '../View/AudioResultUI.dart';
import '../View/TextResultUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dart:io';
import 'package:assignment_app/size_config.dart';
import '../Controller/ImageToTextController.dart';
import 'MainButton.dart';

/// User Interface for Selection Page. Allows user to select whether to convert image to text or audio
/// This UI includes: Convert to text button, Convert to audio button.
/// @author  Team Superman
/// @version 1.0
/// @since   2020-04-08
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

    Future imageToAudio() async {
      print('Running text to speech...');
      ImageToTextController textToSpeech = new ImageToTextController();
      String convertedText = await textToSpeech.imageToTextConverterForTts(pic);
      print(convertedText);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AudioResult(convertedText: convertedText, pic: this.pic),
        ),
      );
    }

    Future imageToText() async {
      print('Running image to text...');
      ImageToTextController imageToText = new ImageToTextController();
      List<String> convertedText = await imageToText.ImageToTextConverter(pic);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TextResult(convertedText: convertedText, pic: this.pic),
        ),
      );
    }

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
                padding: EdgeInsets.only(top: h * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    mainButton(w, h, Icons.music_note, "Audio", imageToAudio,
                        EdgeInsets.symmetric(horizontal: w * 15)),
                    SizedBox(
                      height: w * 5,
                    ),
                    mainButton(w, h, Icons.format_color_text, "Text",
                        imageToText, EdgeInsets.symmetric(horizontal: w * 15)),
                    SizedBox(
                      height: w * 5,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
