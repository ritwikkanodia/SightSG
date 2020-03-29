import 'dart:convert';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:http/http.dart';
//import 'package:assignment_app/Boundary/AudioResultUI.dart';
//import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/audio_cache.dart';

/**
 * Class in charge of API call
 * @author Koh Zhuang Chean
 */
class ConverterController { //The one to interact with UI
  /**
   * Represents an API call method of Image To Text
   * @author Koh Zhuang Chean
   */
  Future<List<String>> ImageToTextConverter(File pickedImage) async{
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    List<String> listOfBlock = [];
    for (TextBlock block in readText.blocks) { //Print all the text at console
      String concatenatedString = "";
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          concatenatedString += word.toString();
        }
      }
      listOfBlock.add(concatenatedString);
    }
    return listOfBlock;
  }
  /**
   * Represents an API call method of Text To Speech
   * @author Koh Zhuang Chean
   */
  Future TextToSpeechConverter(File pickedImage) async{
    List<String> convertedText = await ImageToTextConverter(pickedImage);
    String finalConcatenatedString = "";
    for (String i in convertedText){
      finalConcatenatedString += i;
    }
    if (finalConcatenatedString.length>=700){
      print("Sorry, the texts in the image exceeds 700 characters, please use another image.");
    }
    else{
      var auth = 'caz koh:Cazkoh99!';
      var bytes = utf8.encode(auth);
      var convertedAuth = base64.encode(bytes);
      final finalAuth = 'Basic ' + convertedAuth;
      final uri = 'https://www.de-vis-software.ro/tts.aspx';
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': finalAuth
      };
      Map<String, dynamic> body = {
        "inputtext": finalConcatenatedString,
        "ssml": "Text",
        "voicename": "en-US-PREMIUM-C_FEMALE",
        "voicetype": "HeadPhones",
        "encoding": "Mp3",
        "speed": 1,
        "pitch": 0,
        "volume": 0,
        "saveFileLocally": "Yes"
      };
      String jsonBody = json.encode(body);

      Response response = await post(
          uri,
          headers: headers,
          body: jsonBody
      );

      if (response.statusCode == 200) {
          print("API call success");
      }
      else {
        print(response.statusCode);
      }
    }
  }
}
//
//class ImageToTextConverterApp extends StatelessWidget {//For testing purposes
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: MyHomePage(),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {//For testing purposes
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> { //For testing purposes
//  File pickedImage;
//
//  bool isImageLoaded = false;
//  AudioCache audioCache = AudioCache();
//  AudioPlayer advancedPlayer = AudioPlayer();
//  String audioUrl;
//  Future pickImage() async {
//    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//    setState(() {
//      pickedImage = tempStore;
//      isImageLoaded = true;
//    });
//  }
//
//  Future<List> readText() async {
//    //FirebaseVisionImage.f
//    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
//    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
//    VisionText readText = await recognizeText.processImage(ourImage);
//    List listOfBlock = [];
//    for (TextBlock block in readText.blocks) { //Print all the text at console
//      String concatenatedString = "";
//      for (TextLine line in block.lines) {
//        for (TextElement word in line.elements) {
//          concatenatedString += word.toString();
//          if (concatenatedString.length > 700) {
//            listOfBlock.add(concatenatedString);
//            concatenatedString = "";
//          }
//        }
//      }
//      if (concatenatedString.length >= 500)
//        listOfBlock.add(concatenatedString);
//    }
//    print(listOfBlock);
//    return listOfBlock;
//  }
//
//  Future decode() async {
//    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
//    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
//    List barCodes = await barcodeDetector.detectInImage(ourImage);
//
//    for (Barcode readableCode in barCodes) {
//      print(readableCode.displayValue);
//    }
//  }
//
//  String testingString = "This is to test whether the API works.";
//
//  Future<String> get _localPath async {
//    final directory = await getApplicationDocumentsDirectory();
//
//    return directory.path;
//  }
//
//  Future makePostRequest() async {
//    var auth = 'chean koh:Ck991011.';
//    var bytes = utf8.encode(auth);
//    var convertedAuth = base64.encode(bytes);
//    final finalAuth = 'Basic ' + convertedAuth;
//    final uri = 'https://www.de-vis-software.ro/tts.aspx';
//    final headers = {
//      'Content-Type': 'application/json',
//      'Accept': 'application/json',
//      'Authorization': finalAuth
//    };
//    Map<String, dynamic> body = {
//      "inputtext": testingString,
//      "ssml": "Text",
//      "voicename": "en-US-PREMIUM-C_FEMALE",
//      "voicetype": "HeadPhones",
//      "encoding": "Mp3",
//      "speed": 1,
//      "pitch": 0,
//      "volume": 0,
//      "saveFileLocally": "Yes"
//    };
//    String jsonBody = json.encode(body);
//
//    Response response = await post(
//        uri,
//        headers: headers,
//        body: jsonBody
//    );
//
//    if (response.statusCode == 200) {
//      var jsonResponse = await json.decode(response.body);
//      audioUrl = jsonResponse['audioFileURL'];
//      print(audioUrl);
//      return audioUrl;
//    }
//    else {
//      print(response.statusCode);
//    }
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: Column(
//          children: <Widget>[
//            SizedBox(height: 100.0),
//            isImageLoaded
//                ? Center(
//              child: Container(
//                  height: 200.0,
//                  width: 200.0,
//                  decoration: BoxDecoration(
//                      image: DecorationImage(
//                          image: FileImage(pickedImage), fit: BoxFit.cover))),
//            )
//                : Container(),
//            SizedBox(height: 10.0),
//            RaisedButton(
//              child: Text('Pick an image'),
//              onPressed: pickImage,
//            ),
//            SizedBox(height: 10.0),
//            RaisedButton(
//              child: Text('Read Text'),
//              onPressed: readText,
//            ),
//            RaisedButton(
//                child: Text('Get Mp3'),
//                onPressed: () {
//                  String ur  = makePostRequest().toString();
//                  print('Here is the new url');
//                  //String ur = 'https://ffpoazure.blob.core.windows.net/chean-koh/chean-koh.mp3';
//                  print(ur);
//                  //So i think navigator.push happening before makePostRequest
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) =>AudioResult(demoUrl: ur),),
//                  );
//                }
//
//            ),
//            _Btn(
//                txt: 'Play', onPressed: () => advancedPlayer.setUrl(audioUrl)
//            ),
//          ],
//        ));
//  }
//}
//
//class _Btn extends StatelessWidget {
//  final String txt;
//  final VoidCallback onPressed;
//
//  const _Btn({Key key, this.txt, this.onPressed}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return ButtonTheme(
//        minWidth: 48.0,
//        child: RaisedButton(child: Text(txt), onPressed: onPressed));
//  }
//}