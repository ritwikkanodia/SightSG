import 'package:flutter/material.dart';
import '../Boundary/ImageSelectionUI.dart';
import '../Entity/UserImage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageController {
  ImageController();
  static getImage(ImageSource source, UserImage _selectedFile) async {
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
          ));

      if (cropped != null) {
        _selectedFile = UserImage(cropped);
      }

    }
}
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
}
