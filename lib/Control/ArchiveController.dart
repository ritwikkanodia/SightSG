import 'dart:typed_data';

import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import '../Control/LoginValidator.dart';
import 'DatabaseController.dart';

/**
 * Controller class to manage uploading and downloading of images from cloud
 * @author Alexander Lim Hong Xun
 */
class ArchiveController {
  static const MAX_SIZE = 7 * 1024 * 1024;

  /**
   * Uploads image to cloud
   * @author Alexander Lim Hong Xun
   */
  static Future uploadPicture(File image) async { // Function needs image parameter, or move function to where the image is being clicked and stored
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("${userProfile.getUserMail()}/${path.basename(image.path)}");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image); // Once user clicks a picture, that picture, needs to be sent through the function as a parameter
    // You can convert a Uint8List to a Flutter Image widget using the Image.memory constructor. (Use the Uint8List.fromList constructor to convert a List to Uint8List if necessary.) You can use BASE64.encode to go the other way.
    //StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    String fileName = await firebaseStorageRef.getName();
    DatabaseController dc = new DatabaseController(email: userProfile.getUserMail());
    dc.updateImageLink(url, fileName);
    print("Image has been uploaded");
  }

  /**
   * Downloads image from cloud
   * @author Alexander Lim Hong Xun
   */
  static Future<List> downloadPicture() async {
    DatabaseController dc = new DatabaseController(email: userProfile.getUserMail());
    List downloadURLs = await dc.getDownloadUrls();
    List images = new List();
    StorageReference storageReference;
    for (String url in downloadURLs) {
      storageReference = await FirebaseStorage.instance.getReferenceFromUrl(url);
      Uint8List bytes = await storageReference.getData(MAX_SIZE);
      images.add(bytes);
    }
    return images;
  }

//  static Future deletePicture(String url) async {
//    DatabaseController dc = new DatabaseController(email: userProfile.getUserMail());
//    StorageReference storageReference = await FirebaseStorage.instance.getReferenceFromUrl(url);
//    String fileName = await storageReference.getName();
//    storageReference.delete();
//    dc.deleteDownloadUrl(url, fileName);
//  }

}
