import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TasksFirestoreService {

  final CollectionReference dates = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("dates");

  void addTasks(List<String> selectedTasks) {
    for (String taskName in selectedTasks) {
      dates.doc(taskName).set({
        "taskName":taskName,
        "isCompleted":false
      });
    }
    selectedTasks.clear();
  }

  Future<void> updateTask(String docID, bool isCompleted) {
    return dates.doc(docID).update({
      "isCompleted":isCompleted
    });
  }
}