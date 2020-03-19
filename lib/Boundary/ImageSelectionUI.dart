import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Control/CameraController.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Entity/UserImage.dart';

class ImageApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserImage _selectedFile;
  bool _inProcess = false;
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://text-detector-9404a.appspot.com');

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    File croppedImage = await ImageController.getCroppedImage(source);
    if (croppedImage != null) {
      uploadFile(croppedImage,"test1");
      this.setState(() {
        _selectedFile = UserImage(croppedImage);
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  uploadFile(File file, String fileName) async {
    final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://text-detector-9404a.appspot.com');
    final StorageReference storageReference = _storage.ref().child("image/$fileName.jpg");
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    //storageReference.
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImageController.getImageWidget(_selectedFile),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                        color: Colors.green,
                        child: Text(
                          "Camera",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          getImage(ImageSource.camera);
                        }),
                    MaterialButton(
                        color: Colors.deepOrange,
                        child: Text(
                          "Device",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        })
                  ],
                )
              ],
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
        ));
  }
}