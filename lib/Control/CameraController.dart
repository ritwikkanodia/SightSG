import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../Boundary/ImageSelectionUI.dart';
import '../Entity/UserImage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Control/ArchiveController.dart';

class ImageController {
  ImageController();

  static Widget getImageWidget(UserImage selectedFile) {
    if (selectedFile != null) {
      return Image.file(
        selectedFile.getImage(),
        width: 400,
        height: 400,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        "assets/placeholder.jpg",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

  static Future<File> getCroppedImage (ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.deepOrange,
          toolbarTitle: "RPS Cropper",
          statusBarColor: Colors.deepOrange.shade900,
          backgroundColor: Colors.white,
        ),
      );
      return cropped;
    } else {
      return null;
    }
  }
}
