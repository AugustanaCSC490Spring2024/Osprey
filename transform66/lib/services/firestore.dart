import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  // friends collection reference
  final CollectionReference friends = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("friends");
  // tasks collection reference
  final CollectionReference tasks = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("tasks");

  // actions for friends collection
  Future<void> addFriend(String email) {
    return friends.doc(email).set({
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

  // actions for tasks collection
  Future<void> addTasks(List<String> selectedTasks) {
    // for (int i = 0; i < 66; i++){
    //  for (String taskName in selectedTasks) {
    //    tasks.doc("Day $i").set({
    //      "taskName":taskName,
    //      "isCompleted":false
    //   }});
    // }
    for (String taskName in selectedTasks) {
      tasks.doc(taskName).set({
        "taskName":taskName,
        "isCompleted":false
      });
    }
    return Future.value();
  }

  Stream<QuerySnapshot> getTasksStream() {
    final tasksStream = tasks.orderBy("taskName").snapshots();
    return tasksStream;
  }

  Future<void> updateTask(String docID, bool isCompleted) {
    return tasks.doc(docID).update({
      "isCompleted":isCompleted
    });
  }

  Future<bool> hasUser(String name) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection("users").doc(name).get();
    
    if (doc.exists) {
      return true;
    }
    else {
      return false;
    }
  }
}