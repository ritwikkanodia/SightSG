import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
//import 'package:http/http.dart';
//import 'dart:convert';

///Class in charge of API call
/// @author  Team Superman
/// @version 1.0
/// @since   2020-04-08
class ImageToTextController {

  ///Represents an API call method of Image To Text
  ///@param pickedImage Image selected by the user to be converted to text
  Future<List<String>> ImageToTextConverter(File pickedImage) async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    List<String> listOfBlock = [];
    for (TextBlock block in readText.blocks) {
      String concatenatedString = "";
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          concatenatedString = concatenatedString + word.text + ' ';
        }
      }
      listOfBlock.add(concatenatedString);
    }
    return listOfBlock;
  }

  ///Represents an API call method of Image To Text format suitable for flutter_tts
  ///@param pickedImage Image selected by the user to be converted to audio
  Future<String> imageToTextConverterForTts(File pickedImage) async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    List<String> listOfBlock = [];
    for (TextBlock block in readText.blocks) {
      String concatenatedString = "";
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          concatenatedString = concatenatedString + word.text + ' ';
        }
      }
      listOfBlock.add(concatenatedString);
    }

    String finalConcatenatedString = "";

    for (String i in listOfBlock) {
      finalConcatenatedString += i;
      print(i);
    }
    return finalConcatenatedString;
  }
}