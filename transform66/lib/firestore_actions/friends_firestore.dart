import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsFirestoreService {

  Future<void> requestFriend(String currentUser, String requestedFriend) async {
    DocumentSnapshot<Map<String, dynamic>> doc1 = await FirebaseFirestore.instance.collection("users").doc(requestedFriend).get();
    DocumentSnapshot<Map<String, dynamic>> doc2 = await FirebaseFirestore.instance.collection("users").doc(currentUser).collection("friends").doc(requestedFriend).get();
    if (doc1.exists&&!doc2.exists) {
      FirebaseFirestore.instance.collection("users").doc(currentUser).collection("friends").doc(requestedFriend).set({
        "date":Timestamp.now(),
        "status":"requested"
      });
      FirebaseFirestore.instance.collection("users").doc(requestedFriend).collection("friends").doc(currentUser).set({
        "date":Timestamp.now(),
        "status":"pending"
      });
    }
  }

  Future<void> acceptFriend(String person, String friend) async {
    FirebaseFirestore.instance.collection("users").doc(person).collection("friends").doc(friend).update({"status":"accepted"});
    FirebaseFirestore.instance.collection("users").doc(friend).collection("friends").doc(person).update({"status":"accepted"});
  }
  
  Future<void> removeFriend(String currentUser, String requestedFriend) async {
    FirebaseFirestore.instance.collection("users").doc(currentUser).collection("friends").doc(requestedFriend).delete();
    FirebaseFirestore.instance.collection("users").doc(requestedFriend).collection("friends").doc(currentUser).delete();
  }

  Future<void> sendMessage(String currentUser, String requestedFriend) async {
    FirebaseFirestore.instance.collection("users").doc(requestedFriend).collection("feed").doc().set({
        "date":Timestamp.now(),
        "message":"You've got this!"
      });
  }
}