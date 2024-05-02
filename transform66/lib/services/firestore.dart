import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  // tasks collection reference
  final CollectionReference dates = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("dates");

  // actions for tasks collection
  void addTasks(List<String> selectedTasks) {
    // for (int i = 0; i < 66; i++){
    //  for (String taskName in selectedTasks) {
    //    dates.doc("Day $i").set({
    //      "taskName":taskName,
    //      "isCompleted":false,
    //       "date":DateTime.now().add(Duration(days: i))
    //     }
    //     );
    //  }
    // }
    for (String taskName in selectedTasks) {
      dates.doc(taskName).set({
        "taskName":taskName,
        "isCompleted":false
      });
    }
    //return Future.value();
  }

  Stream<QuerySnapshot> getTasksStream() {
    final tasksStream = dates.orderBy("taskName").snapshots();
    return tasksStream;
  }

  Future<void> updateTask(String docID, bool isCompleted) {
    return dates.doc(docID).update({
      "isCompleted":isCompleted
    });
  }









  Stream<QuerySnapshot> getFriendsStream() {
    final friendsStream = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("friends").orderBy("date").snapshots();
    return friendsStream;
  }

  Future<void> requestFriend(String person, String friend) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection("users").doc(friend).collection("friends").doc(person).get();
    if (doc.exists) {
      FirebaseFirestore.instance.collection("users").doc(person).collection("friends").doc(friend).set({
      "date":Timestamp.now(),
      "status":"accepted"
    });
    FirebaseFirestore.instance.collection("users").doc(friend).collection("friends").doc(person).update({"status":"accepted"});
    }
    else {
    FirebaseFirestore.instance.collection("users").doc(person).collection("friends").doc(friend).set({
      "date":Timestamp.now(),
      "status":"requested"
    });
    FirebaseFirestore.instance.collection("users").doc(friend).collection("friends").doc(person).set({
      "date":Timestamp.now(),
      "status":"pending"
    });
    }
  }

  Future<void> removeFriend(String person, String friend) async {
    DocumentReference doc1 = FirebaseFirestore.instance.collection("users").doc(person).collection("friends").doc(friend);
    doc1.delete();
  }

  Future<void> acceptFriend(String person, String friend) async {
    FirebaseFirestore.instance.collection("users").doc(person).collection("friends").doc(friend).update({"status":"accepted"});
    FirebaseFirestore.instance.collection("users").doc(friend).collection("friends").doc(person).update({"status":"accepted"});
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

  Future<bool> hasFriend(String person, String friend) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection("users").doc(person).collection("friends").doc(friend).get();
    
    if (doc.exists) {
      return true;
    }
    else {
      return false;
    }
  }
}