import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // to update data on the cloud firestore database
  Future<void> updateFirestoreData(
      String collectionPath, String path, Map<String, dynamic> updateData) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

// to recieve snapshot of data from the cloud firestore database
  Stream<QuerySnapshot<Map<String, dynamic>>> getFirestoreData(
      String collectionPath, int limit, String? textSearch) {
    if (textSearch!.isNotEmpty == true) {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .where('name', isEqualTo: textSearch)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .snapshots();
    }
  }
}
