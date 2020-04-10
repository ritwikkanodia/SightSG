import 'dart:io';


class UserImage {
  File _image;

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
