import 'dart:io';

/// UserImage entity class
/// @author  Team Superman
/// @version 1.0
/// @since   2020-04-08

class UserImage {
  File _image;

  ///UserImage object constructor
  ///@param image

  UserImage(image) {
    this._image = image;
  }

  File getImage() {
    return this._image;
  }

  void setImage(File image) {
    this._image = image;
  }
}
