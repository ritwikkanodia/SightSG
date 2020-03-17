import 'Picture.dart';

class UserProfile {
  int _userID;
  String _userName;
  List<Picture> pictureList = [];

  UserProfile(int ID, String Name) {
    this._userID = ID;
    this._userName = Name;
  }

  String getUserName() => _userName;

  setUserName(String value) {
    _userName = value;
  }

  int getUserID() => _userID;

  setUserID(int value) {
    _userID = value;
  }

  addPicture(Picture PicToAdd) {
    pictureList.add(PicToAdd);
  }
}
