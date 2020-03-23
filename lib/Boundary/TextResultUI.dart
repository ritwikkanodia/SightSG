import 'dart:io';
import 'dart:typed_data';

import 'package:assignment_app/Control/ArchiveController.dart';
import 'package:flutter/material.dart';

class TextResultUI extends StatefulWidget {

  @override
  _TextResultUIState createState() => _TextResultUIState();
}

class _TextResultUIState extends State<TextResultUI> {
  List<Uint8List> _image;
  Future<File> getImage() async{
    List<Uint8List> image = await ArchiveController.downloadPicture();
    this.setState(() {
      this._image = image;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            //child: _image == null ? Image.asset('assets/placeholder.jpg') : Image.memory(_image),
          ),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 5, vertical: (5)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.text_fields,
                  size: 40,
                  color: Colors.white,
                ),
                title: Text(
                  'Upload',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  getImage();
                },
              ),
            ),
          ),
        ],
      )
    );
  }
}