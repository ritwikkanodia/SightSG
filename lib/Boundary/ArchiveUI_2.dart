import 'dart:io';
import 'dart:typed_data';
import 'package:assignment_app/Boundary/SelectionUI.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../Control/ArchiveController.dart';

// ignore: camel_case_types
class ArchiveUI_2 extends StatefulWidget {
  @override
  _ArchiveUI_2State createState() => _ArchiveUI_2State();
}

// ignore: camel_case_types
class _ArchiveUI_2State extends State<ArchiveUI_2> {
  List _images;
  int _imgLength;

  Future getImages() async {
    List images = await ArchiveController.downloadPicture();
    this.setState(() {
      this._images = images;
      this._imgLength = images.length;
    });
  }

  @override
  void initState() {
    getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Your Archive',
            style: (TextStyle(fontWeight: FontWeight.bold)),
          ),
          centerTitle: true,
        ),
        body: _imgLength == null ? new Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
            )
          )
            : new GridView.extent(
          maxCrossAxisExtent: 250.0,
          children: _buildGridTiles(_images.length, context, _images), // new function to be defined
        ),
    );
  }
}

File saveBytesToTempDirectory(Uint8List bytes) {
  String path = Directory.systemTemp.path;
  String uuid = Uuid().v1();
  File file = File('$path/tmp$uuid.jpg');
  File tempDir = File('$path');
  print(file.toString());
  if (tempDir.existsSync()) {
    tempDir.delete();
  }
  file.writeAsBytes(bytes);
  return file;
}

List<Widget> _buildGridTiles(numOfTiles, BuildContext context, List images) {
  List<Container> containers =
    new List<Container>.generate(numOfTiles, (int index) {
    //final imageName = 'images/${index + 1}.jpeg';
    return new Container(
      child: FlatButton(
        child: Image.memory(images[index]),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectionPage(pic: saveBytesToTempDirectory(images[index])))//MemoryImage(images[index],))),
          );
        },
      ),
    );
  });
  return containers;
}