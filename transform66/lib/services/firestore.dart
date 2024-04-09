import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final CollectionReference friends = FirebaseFirestore.instance.collection("friends");

  // adding friends by email for now
  Future<void> addFriend(String email) {
    return friends.add({
      "email":email
    });
  }
}