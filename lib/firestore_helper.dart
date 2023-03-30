import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  sendMessage(String content) {
    firestore.collection("messages").add({"content": content});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshotsStream =
        firestore.collection("messages").snapshots();
    return snapshotsStream;
  }
}
