import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
//import 'dart:async';
//import 'dart:typed_data';
//import 'dart:ui';
//
//import 'package:camera/camera.dart';
//import 'package:firebase_ml_vision/firebase_ml_vision.dart';
//import 'package:flutter/foundation.dart';

//class ScannerUtils {
//  ScannerUtils._();
//
//  static Future<CameraDescription> getCamera(CameraLensDirection dir) async {
//    return await availableCameras().then(
//          (List<CameraDescription> cameras) => cameras.firstWhere(
//            (CameraDescription camera) => camera.lensDirection == dir,
//      ),
//    );
//  }
//
//  static Future<dynamic> detect({
//    @required CameraImage image,
//    @required Future<dynamic> Function(FirebaseVisionImage image) detectInImage,
//    @required int imageRotation,
//  }) async {
//    return detectInImage(
//      FirebaseVisionImage.fromBytes(
//        _concatenatePlanes(image.planes),
//        _buildMetaData(image, _rotationIntToImageRotation(imageRotation)),
//      ),
//    );
//  }
//
//  static Uint8List _concatenatePlanes(List<Plane> planes) {
//    final WriteBuffer allBytes = WriteBuffer();
//    for (Plane plane in planes) {
//      allBytes.putUint8List(plane.bytes);
//    }
//    return allBytes.done().buffer.asUint8List();
//  }
//
//  static FirebaseVisionImageMetadata _buildMetaData(
//      CameraImage image,
//      ImageRotation rotation,
//      ) {
//    return FirebaseVisionImageMetadata(
//      rawFormat: image.format.raw,
//      size: Size(image.width.toDouble(), image.height.toDouble()),
//      rotation: rotation,
//      planeData: image.planes.map(
//            (Plane plane) {
//          return FirebaseVisionImagePlaneMetadata(
//            bytesPerRow: plane.bytesPerRow,
//            height: plane.height,
//            width: plane.width,
//          );
//        },
//      ).toList(),
//    );
//  }
//
//  static ImageRotation _rotationIntToImageRotation(int rotation) {
//    switch (rotation) {
//      case 0:
//        return ImageRotation.rotation0;
//      case 90:
//        return ImageRotation.rotation90;
//      case 180:
//        return ImageRotation.rotation180;
//      default:
//        assert(rotation == 270);
//        return ImageRotation.rotation270;
//    }
//  }
//}
//class CameraController extends Camera{
//  CameraController _camera;
//
//  @override
//  void initState() {
//    super.initState();
//    _initializeCamera();
//  }
//
//  void _initializeCamera() async {
//    final CameraDescription description =
//    await ScannerUtils.getCamera(_direction);
//
//    _camera = CameraController(
//      description,
//      ResolutionPreset.high,
//    );
//
//    await _camera.initialize();
//
//    _camera.startImageStream((CameraImage image) {
//
//      // Here we will scan the text from the image
//      // which we are getting from the camera.
//
//    });
//  }
//}


class TextToAudioConverter{
  TextToAudioConverter();

  File convertImgToAudio(File image){
    //Calling API to convert
  }
}

class ImageToColorConverter{
  ImageToColorConverter();

  File convertImgToColor(File image){
    //Calling API to convert
    return image;
  }
}

class ImageToTextConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File pickedImage;

  bool isImageLoaded = false;

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  Future<List> readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    List listOfBlock = [];
    for (TextBlock block in readText.blocks) { //Print all the text at console
      var stringBuffer = StringBuffer();
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          stringBuffer.writeln(word.text);
        }
      }
      listOfBlock.add(stringBuffer.toString());
    }
    return listOfBlock;
  }

  Future decode() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    List barCodes = await barcodeDetector.detectInImage(ourImage);

    for (Barcode readableCode in barCodes) {
      print(readableCode.displayValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 100.0),
            isImageLoaded
                ? Center(
              child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(pickedImage), fit: BoxFit.cover))),
            )
                : Container(),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Pick an image'),
              onPressed: pickImage,
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Read Text'),
              onPressed: readText,
            ),
            RaisedButton(
              child: Text('Read Bar Code'),
              onPressed: decode,
            )
          ],
        ));
  }
}