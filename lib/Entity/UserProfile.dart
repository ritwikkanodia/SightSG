import 'UserImage.dart';

class UserProfile {
  int _userID;
  String _userName;
  List<UserImage> pictureList = [];

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

  addPicture(UserImage PicToAdd) {
    pictureList.add(PicToAdd);
  }
}
