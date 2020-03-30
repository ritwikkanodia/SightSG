import 'package:assignment_app/Boundary/SelectionUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assignment_app/size_config.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../Control/CameraController.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'ArchiveUI.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  bool _inProcess = false;
  File selectedImage;

  uploadFile(File file) async {
    String fileName = basename(file.path);
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://se-assignment-b4462.appspot.com');
    final StorageReference storageReference =
        _storage.ref().child("$fileName.jpg");
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    //storageReference.
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
  }

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    File croppedImage = await ImageController.getCroppedImage(source);
    if (croppedImage != null) {
      this.setState(
        () {
          _inProcess = false;
          selectedImage = croppedImage;
        },
      );
      Navigator.push(
        this.context,
        MaterialPageRoute(
          builder: (context) => SelectionPage(
            pic: croppedImage,
          ),
        ),
      );
    } else {
      this.setState(
            () {
          _inProcess = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double h = SizeConfig.blockSizeVertical;
    final double w = SizeConfig.blockSizeHorizontal;
    return SafeArea(
      child: Scaffold(
          appBar: GradientAppBar(
            centerTitle: true,
            backgroundColorStart: Colors.blue,
            backgroundColorEnd: Colors.green,
            title: Text(
              'Sight',
              style: (TextStyle(fontSize: (h * 4))),
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
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: h * 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 15),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 3, vertical: h * 3),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(h * 10),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.camera_alt,
                              size: h * 5,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Take Photo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: h * 3,
                              ),
                            ),
                            onTap: () {
                              getImage(ImageSource.camera);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(55.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 3, vertical: 3 * h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(h * 10),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.photo_library,
                              size: h * 5,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Browse Gallery',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: h * 3,
                              ),
                            ),
                            onTap: () {
                              getImage(ImageSource.gallery);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 55),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3 * w, vertical: 3 * h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(h * 10),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.cloud,
                              size: h * 5,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Archived Photos',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: h * 3,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArchiveUI(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                (_inProcess)
                    ? Container(
                        color: Colors.white,
                        height: h * 90,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Center()
              ],
            ),
          )),
    );
  }
}
