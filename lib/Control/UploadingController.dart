import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Control/LoginValidator.dart';

Future uploadPicture(context) async{ // Function needs image parameter, or move function to where the image is being clicked and stored
  File _image; // Just for removing errors
  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(uid);
  StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image); // Once user clicks a picture, that picture, needs to be sent through the function as a parameter
  // You can convert a Uint8List to a Flutter Image widget using the Image.memory constructor. (Use the Uint8List.fromList constructor to convert a List to Uint8List if necessary.) You can use BASE64.encode to go the other way.
  StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  print("Image has been uploaded");
}