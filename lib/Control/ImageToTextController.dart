import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
//import 'package:http/http.dart';
//import 'dart:convert';

/**
 * Class in charge of API call
 * @author Koh Zhuang Chean
 */
class ImageToTextController {
  /**
   * Represents an API call method of Image To Text
   * @author Koh Zhuang Chean
   */
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