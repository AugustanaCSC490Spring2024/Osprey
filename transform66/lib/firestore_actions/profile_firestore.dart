import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileFirestoreService {
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;
  final db = FirebaseFirestore.instance;

  Future<void> deleteUser() async {
    // Do this first
    // If they haven't signed in recently, it will ask for them to sign in again
    await FirebaseAuth.instance.currentUser!.delete();

    List<String> friends = [];
    final QuerySnapshot results =
        await db.collection("users").doc(yourEmail).collection("friends").get();
    final List<DocumentSnapshot> documents = results.docs;
    for (DocumentSnapshot snapshot in documents) {
      friends.add(snapshot.id);
    }
    for (String friendName in friends) {
      await db
          .collection("users")
          .doc(friendName)
          .collection("friends")
          .doc(yourEmail)
          .delete();
    }

    await deleteSubcollections();

    await db.collection("users").doc(yourEmail).delete();
    friends.clear();
  }

  Future<void> deleteSubcollections() async {
    // According to stack overflow, you have to do this one by one
    // Or use a cloud function

    db
        .collection("users")
        .doc(yourEmail)
        .collection("friends")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    db
        .collection("users")
        .doc(yourEmail)
        .collection("friendsFeed")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    db
        .collection("users")
        .doc(yourEmail)
        .collection("personalFeed")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    db
        .collection("users")
        .doc(yourEmail)
        .collection("tasks")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future<void> startAgain() async {
    db.collection("users").doc(yourEmail).collection("tasks").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    db.collection("users").doc(yourEmail).collection("personalFeed").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
