import '../Boundary/ImageSelectionUI.dart';
import 'dart:io';

class Picture {
  int _picID;
  File _image;

  Picture() {
    ;
  }

  File getImage() => _image;

  setImage(File value) {
    _image = value;
  }

  getpicID() {
    return _picID;
  }

  setpicID(int picID) {
    this._picID = picID;
  }
}
