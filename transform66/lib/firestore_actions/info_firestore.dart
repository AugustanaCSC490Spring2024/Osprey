import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoFirestoreService {
  
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;
  final db = FirebaseFirestore.instance;

  Future<void> deleteUser() async {
    
    // for each friend of yours, remove yourself from their list
    List<String> friends = [];
    final QuerySnapshot results = await db.collection("users").doc(yourEmail).collection("friends").get();
    final List<DocumentSnapshot> documents = results.docs;
    for (DocumentSnapshot snapshot in documents) {
      friends.add(snapshot.id);
    }
    for (String friendName in friends) {
      await db.collection("users").doc(friendName).collection("friends").doc(yourEmail).delete();
    }

    // delete your subcollections
    db.collection("users").doc(yourEmail).collection("friends").get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
      }
    });
    db.collection("users").doc(yourEmail).collection("friendsFeed").get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
      }
    });
    db.collection("users").doc(yourEmail).collection("personalFeed").get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
      }
    });
    db.collection("users").doc(yourEmail).collection("tasks").get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
      }
    });

    // finally delete your document
    await db.collection("users").doc(yourEmail).delete();
    // delete the user from authentication
    await FirebaseAuth.instance.currentUser!.delete();
    // to be safe, clear this list, in case they delete another account
    friends.clear();
  }
}