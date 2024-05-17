import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedFirestoreService {

  final CollectionReference personalFeed = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("personalFeed");
  final CollectionReference friendsFeed = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("friendsFeed");
  final CollectionReference friends = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("friends");
  
  Future<List<String>> getFriendsList() async {
    List<String> friendList = [];
    QuerySnapshot querySnapshot = await friends.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      friendList.add(querySnapshot.docs[i].id);
    }
    return friendList;
  }

  Future<void> sendMotivation(String currentUser, String friend, int imageNum) async {
    var userName = currentUser.split('@')[0];
    FirebaseFirestore.instance.collection("users").doc(friend).collection("friendsFeed").doc().set({
      "date": Timestamp.now(),
      "userName": userName,
      "message": "You've got this!",
      "isLiked": false,
      "imageType": "m$imageNum"
    });
  }

  Future<void> celebrationPost(String currentUser, String friend, String taskName, int imageNum) async {
    var userName = currentUser.split('@')[0];
    FirebaseFirestore.instance.collection("users").doc(friend).collection("friendsFeed").doc().set({
      "date": Timestamp.now(),
      "userName": userName,
      "message": "Congratulations on completing the task: \n$taskName",
      "isLiked": false,
      "imageType": "c$imageNum"
    });
  }

  Future<void> addPostPrivate(String currentUser, String taskName, int imageNum) async {
    var userName = currentUser.split('@')[0];
    FirebaseFirestore.instance.collection("users").doc(currentUser).collection("personalFeed").doc().set({
      "date": Timestamp.now(),
      "userName": userName,
      "message": "You completed the task: \n$taskName",
      "imageType": "c$imageNum"
    });
  }

  Future<void> addPostPublic(String currentUser, taskName, int imageNum) async {
    var friendsList = await getFriendsList();
    var userName = currentUser.split('@')[0];
    for (String friend in friendsList) {
      FirebaseFirestore.instance.collection("users").doc(friend).collection("friendsFeed").doc().set({
        "date": Timestamp.now(),
        "userName": userName,
        "message": "I completed my task: \n$taskName",
        "isLiked": false,
        "imageType": "c$imageNum"
      });
    }
  }
}
