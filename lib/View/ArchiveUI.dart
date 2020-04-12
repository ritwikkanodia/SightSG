import 'dart:io';
import 'dart:typed_data';
import 'package:assignment_app/View/SelectionUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../Controller/ArchiveController.dart';

/// User Interface for Archive Page. Displays all the images uploaded to archive by the user.
/// This UI includes: Uploaded images.
/// @author  Team Superman
/// @version 1.0
/// @since   2020-04-08
// ignore: camel_case_types
class ArchiveUI extends StatefulWidget {
  @override
  _ArchiveUIState createState() => _ArchiveUIState();
}

// ignore: camel_case_types
class _ArchiveUIState extends State<ArchiveUI> {
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
      body: _imgLength == null
          ? new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )),
              SizedBox(
                height: 10.0,
                width: 10.0,
              ),
              Text(
                "Downloading images..",
                style: (TextStyle(fontWeight: FontWeight.bold)),
              ),
            ])
          : _imgLength == 0
              ? Center(
                  child: Text(
                    "The archive is empty",
                    style: (TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )
              : new GridView.extent(
                  maxCrossAxisExtent: 250.0,
                  children: _buildGridTiles(_images.length, context,
                      _images), // new function to be defined
                ),
    );
  }
}

/// This method saves bytes to a temporary directory.
/// @param Uint8List  This is the bytes to be saved.
/// @return File this is the temporory directory.
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

/// This method builds a list of containers containing tbe uploaded images
/// @param numofTIles This is the number of images to be displayed
/// @param images This is the list of images to be displayed.
/// @param Uint8List  This is the bytes to be saved.
/// @return List<container> returns list of container containing images
///
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
              MaterialPageRoute(
                  builder: (context) => SelectionPage(
                      pic: saveBytesToTempDirectory(
                          images[index]))) //MemoryImage(images[index],))),
              );
        },
      ),
    );
  });
  return containers;
}
