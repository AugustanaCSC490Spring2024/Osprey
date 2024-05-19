import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsFirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  Future<void> requestFriend(String currentUser, String requestedFriend) async {
    DocumentSnapshot<Map<String, dynamic>> doc1 = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(requestedFriend)
        .get();
    DocumentSnapshot<Map<String, dynamic>> doc2 = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(currentUser)
        .collection("friends")
        .doc(requestedFriend)
        .get();
    if (doc1.exists && !doc2.exists) {
      users
          .doc(currentUser)
          .collection("friends")
          .doc(requestedFriend)
          .set({"date": Timestamp.now(), "status": "requested"});
      users
          .doc(requestedFriend)
          .collection("friends")
          .doc(currentUser)
          .set({"date": Timestamp.now(), "status": "pending"});
    }
  }

  Future<void> acceptFriend(String person, String friend) async {
    users
        .doc(person)
        .collection("friends")
        .doc(friend)
        .update({"status": "accepted"});
    users
        .doc(friend)
        .collection("friends")
        .doc(person)
        .update({"status": "accepted"});
  }

  Future<void> removeFriend(String currentUser, String requestedFriend) async {
    users.doc(currentUser).collection("friends").doc(requestedFriend).delete();
    users.doc(requestedFriend).collection("friends").doc(currentUser).delete();
  }
}
