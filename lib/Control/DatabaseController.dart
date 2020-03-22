import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseController {
  String uid;

  static const String COLLECTION_NAME = 'ImageLinkCollection';

  static const String DOWNLOAD_LINK_FIELD = 'download_links';

  DatabaseController({this.uid});

  final CollectionReference imageLinkCollection = Firestore.instance.collection(COLLECTION_NAME);

  Future updateImageLink(String downloadLink) async {
    List downloadLinks = await getDownloadLinks();
    downloadLinks.add(downloadLink);
    return await Firestore.instance.runTransaction((transaction) async {
      await transaction.set(Firestore.instance.collection(COLLECTION_NAME).document(this.uid), {
        DOWNLOAD_LINK_FIELD: downloadLinks
      });
    });
  }

  Future<List> getDownloadLinks() async {
    List downloadLinks = new List();
    DocumentSnapshot ds = await imageLinkCollection.document(this.uid).get();
    return ds.data == null ? downloadLinks:ds.data[DOWNLOAD_LINK_FIELD];
  }
}