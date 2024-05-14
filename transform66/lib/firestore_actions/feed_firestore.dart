import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedFirestoreService {

  // tasks collection reference
  final CollectionReference feed = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("feed");

  Future<void> sendMotivation(String currentUser, String requestedFriend) async {
    FirebaseFirestore.instance.collection("users").doc(requestedFriend).collection("feed").doc().set({
        "date":Timestamp.now(),
        "message":"$currentUser wants to remind you that you've got this!"
      });
  }

  Future<void> addPost(String currentUser, String requestedFriend) async {
    FirebaseFirestore.instance.collection("users").doc(requestedFriend).collection("feed").doc().set({
        "date":Timestamp.now(),
        "message":"You've got this!"
      });
  }


}