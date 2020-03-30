import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * Controller class to manage database
 */
class DatabaseController {
  String email;

  static const String COLLECTION_NAME = 'ImageLinkCollection';

  static const String DOWNLOAD_LINK_FIELD = 'download_url';

  static const String DOWNLOAD_LINKS_FIELD = 'download_urls';

  DatabaseController({this.email});

  final CollectionReference imageLinkCollection = Firestore.instance.collection(COLLECTION_NAME);

  /**
   * Uploads link of uploaded image to the database
   * @author Alexander Lim Hong Xun
   */
  Future updateImageLink(String downloadUrl, String fileName) async {
    return await Firestore.instance.runTransaction((transaction) async {
      await transaction.set(Firestore.instance.collection(COLLECTION_NAME)
          .document(this.email)
          .collection(DOWNLOAD_LINKS_FIELD)
          .document(fileName), {
        DOWNLOAD_LINK_FIELD: downloadUrl
      });
    });
  }

  /**
   * Retrieves a list of download urls for all uploaded images by the user
   * @author Alexander Lim Hong Xun
   */
  Future<List> getDownloadUrls() async {
    List downloadUrls = new List();
    QuerySnapshot qs = await imageLinkCollection.document(this.email)
        .collection(DOWNLOAD_LINKS_FIELD)
        .getDocuments();
    for (DocumentSnapshot ds in qs.documents) {
      downloadUrls.add(ds.data[DOWNLOAD_LINK_FIELD]);
    }
    return downloadUrls;
  }


//  Future deleteDownloadUrl(String url, String fileName) async {
//    await Firestore.instance.collection(COLLECTION_NAME)
//        .document(this.email)
//        .collection(DOWNLOAD_LINKS_FIELD)
//        .document(fileName)
//        .delete();
    //Query query = await imageLinkCollection.document(this.uid)
    //    .collection(DOWNLOAD_LINKS_FIELD)
    //    .where(DOWNLOAD_LINK_FIELD == "https://firebasestorage.googleapis.com/v0/b/se-assignment-b4462.appspot.com/o/Lh73TAVqLrMYmzb6rWSpIX2ek8h1%2Fimage_cropper_1584950999677.jpg?alt=media&token=f0dde6fd-3755-42ec-a3e8-38917be8197d");
    //QuerySnapshot qs = await query.getDocuments();
    //for (DocumentSnapshot ds in qs.documents) {
    //  ds.reference.delete();
    //}
//}
}