import 'dart:io';

class ImageDataController {
  int _picID;
  File _image;

  ImageDataController(picID, image) {
    this._image = image;
    this._picID = picID;
  }

  File processImage(_image) {
    //process image
  }
}
