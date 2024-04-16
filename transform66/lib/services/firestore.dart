import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final CollectionReference friends = FirebaseFirestore.instance.collection("friends");

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
}