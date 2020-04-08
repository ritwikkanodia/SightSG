import 'package:assignment_app/Boundary/MainButton.dart';
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

/// User Interface for Home Page. Displays the main functions of the application.
/// This UI includes: Take photo, Browse Gallery, Browse Archive.
/// @author  Team Superman
/// @version 1.0
/// @since   2020-04-08
class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  bool _inProcess = false;
  File selectedImage;

  /// This method uploads a file to the firebase storage
  /// @param file This is the file to be uploaded
  ///  @return Nothing
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

  /// This method gets an image from a url
  /// @param source This is the source url
  ///  @return Nothing
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

  /// This method gets an image from a url
  /// @param source This is the source url
  ///  @return Nothing
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double h = SizeConfig.blockSizeVertical;
    final double w = SizeConfig.blockSizeHorizontal;

    getImageFromCamera() {
      getImage(ImageSource.camera);
    }

    getImageFromGallery() {
      getImage(ImageSource.gallery);
    }

    goToArchive() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArchiveUI(),
        ),
      );
    }

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
                      mainButton(
                          w,
                          h,
                          Icons.camera_alt,
                          "Take Photo",
                          getImageFromCamera,
                          EdgeInsets.symmetric(horizontal: 55)),
                      mainButton(w, h, Icons.photo_library, "Browse Gallery",
                          getImageFromGallery, EdgeInsets.all(55.0)),
                      mainButton(w, h, Icons.cloud, "Browse Archive",
                          goToArchive, EdgeInsets.symmetric(horizontal: 55)),
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
