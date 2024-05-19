import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TasksFirestoreService {
  final CollectionReference tasks = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection("tasks");
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;

  void addTasks(List<String> selectedTasks) {
    for (String taskName in selectedTasks) {
      tasks.doc(taskName).set({"taskName": taskName, "isCompleted": false});
    }
    selectedTasks.clear();
  }

  Future<void> updateTask(String docID, bool isCompleted) async {
    tasks.doc(docID).update({"isCompleted": isCompleted});
    users.doc(yourEmail).update({
      "completedToday":
          isCompleted ? FieldValue.increment(1) : FieldValue.increment(-1)
    });
  }
}
