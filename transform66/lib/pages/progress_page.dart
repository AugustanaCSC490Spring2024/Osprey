import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/tasks_firestore.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final TasksFirestoreService tfs = TasksFirestoreService();
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          Image.asset('assets/images/Transform66.png', height: 110),
          const SizedBox(height:50),
          StreamBuilder<DocumentSnapshot<Map<String,dynamic>>> (
            stream: db.collection("users").doc(yourEmail).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              int dayDifference = (DateTime.now().difference(data["first_day"].toDate()).inHours/24).round()+1;
              return Text("Day $dayDifference",style: const TextStyle(fontSize: 16));
            }
          ),
          const SizedBox(height:50),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.email!)
                      .collection("dates")
                      .orderBy("taskName")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<QueryDocumentSnapshot> taskDocs =
                          snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap:
                            true, // Make the ListView scrollable within SingleChildScrollView
                        physics:
                            const NeverScrollableScrollPhysics(), // Disable scrolling of the ListView
                        itemCount: taskDocs.length,
                        itemBuilder: (context, index) {
                          return TaskCompletionWidget(
                              taskName: taskDocs[index].get("taskName"),
                              isCompleted: taskDocs[index].get("isCompleted"));
                        },
                      );
                    } else {
                      return const Text("Loading...");
                    }
                  })
        ]));
  }
}

class TaskCompletionWidget extends StatefulWidget {
  final String taskName;
  var isCompleted = false;

  TaskCompletionWidget({
    required this.taskName,
    required this.isCompleted,
    super.key,
  });

  @override
  _TaskCompletionWidgetState createState() => _TaskCompletionWidgetState();
}

class _TaskCompletionWidgetState extends State<TaskCompletionWidget> {
  final TasksFirestoreService tfs = TasksFirestoreService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: Row(
        children: [
          Checkbox(
            value: widget.isCompleted,
            onChanged: (value) {
              setState(() {
                widget.isCompleted = value!;
                if (value) {
                  tfs.updateTask(widget.taskName, true);
                } else {
                  tfs.updateTask(widget.taskName, false);
                }
              });
            },
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskName,
                  style: const TextStyle(color: Colors.black),
                )
              ]
            )
          )
        ]
      )
    );
  }
}