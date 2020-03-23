import 'package:assignment_app/Boundary/ArchiveUI_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assignment_app/size_config.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../Entity/UserImage.dart';
import 'package:image_picker/image_picker.dart';
import '../Control/CameraController.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  bool _inProcess = false;
  File selectedImage;

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    File croppedImage = await ImageController.getCroppedImage(source);
    if (croppedImage != null) {
      this.setState(() {
        _inProcess = false;
        selectedImage = croppedImage;
      });
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
          body: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: h * 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 15),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: w * 3, vertical: h * 3),
                        decoration: BoxDecoration(
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
                                MaterialPageRoute(builder: (context) => ArchiveUI_2(),),
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
                height: MediaQuery.of(context).size.height * 0.95,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : Center()
            ],
          )),
    );
  }
}
