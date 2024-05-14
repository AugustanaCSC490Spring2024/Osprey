import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedFirestoreService {
  // tasks collection reference
  final CollectionReference feed = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection("feed");
  final CollectionReference friends = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection("friends");

  Future<List<String>> getFriendsList() async {
    List<String> friendList = [];
    QuerySnapshot querySnapshot = await friends.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      friendList.add(querySnapshot.docs[i].id);
    }
    return friendList;
  }

  Future<void> sendMotivation(
      String currentUser, String requestedFriend) async {
    var userName = currentUser.split('@')[0];
    FirebaseFirestore.instance
        .collection("users")
        .doc(requestedFriend)
        .collection("feed")
        .doc()
        .set({
      "date": Timestamp.now(),
      "message": "$userName wants to remind you that you've got this!"
    });
  }

  Future<void> addPostPrivate(String currentUser, taskName) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .collection("feed")
        .doc()
        .set({
      "date": Timestamp.now(),
      "message": "You have completed the task: $taskName"
    });
  }

  Future<void> addPostPublic(String currentUser, taskName) async {
    var friendsList = await getFriendsList();
    for (String friend in friendsList) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(friend)
          .collection("feed")
          .doc()
          .set({
        "date": Timestamp.now(),
        "message": "$currentUser has completed the task: $taskName"
      });
    }
  }
}
