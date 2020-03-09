import 'package:flutter/material.dart';
import 'imageselection_page.dart';
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
}