import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TasksFirestoreService {

  final CollectionReference tasks = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("tasks");

  void addTasks(List<String> selectedTasks) {
    for (String taskName in selectedTasks) {
      tasks.doc(taskName).set({
        "taskName":taskName,
        "isCompleted":false,
        "receiveUpdates":false
      });
    }
    selectedTasks.clear();
  }

  Future<void> updateTask(String docID, bool isCompleted) {
    return tasks.doc(docID).update({
      "isCompleted":isCompleted
    });
  }
  
}