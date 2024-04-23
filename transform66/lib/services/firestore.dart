import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final CollectionReference friends = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("friends");

  Future<void> addFriend(String email) {
    return friends.add({
      "email":email,
      "date":Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getFriendsStream() {
    final friendsStream = friends.orderBy("date").snapshots();
    return friendsStream;
  }

  Future<void> removeFriend(String docID) {
    return friends.doc(docID).delete();
  }
}