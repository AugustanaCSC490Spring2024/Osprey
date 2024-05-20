// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/feed_firestore.dart';
import 'package:transform66/firestore_actions/profile_firestore.dart';
import 'package:transform66/firestore_actions/tasks_firestore.dart';
import 'package:transform66/pages/edit_new_users.dart';

final tfs = TasksFirestoreService();
final ffs = FeedFirestoreService();
final ifs = ProfileFirestoreService();

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

var finished = false;

class _ProgressPageState extends State<ProgressPage> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(95, 143, 239, 229),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const SizedBox(height: 25),
                      Image.asset('assets/images/Transform66.png', height: 110),
                      const SizedBox(height: 50),
                      StreamBuilder<DocumentSnapshot>(
                          stream:
                              db.collection("users").doc(FirebaseAuth.instance.currentUser!.email!).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting)
                              return const Text("Loading...");
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            String userStatus = data["status"];
                            if (userStatus == "success") {
                              if (!finished) {
                                // Since the user might not be logged in at midnight when it changes
                                // Automatically post to both feeds, might as well
                                var randomInt = Random().nextInt(10) + 1;
                                ffs.completedChallengedPost(
                                    FirebaseAuth.instance.currentUser!.email!, randomInt);
                                finished = true;
                              }
                              return Flexible(
                                  child: SizedBox(
                                      height: 300,
                                      width: 400,
                                      child: Column(children: [
                                        const SizedBox(height: 50),
                                        const Text(
                                            "Congratulations!\nYou have completed the challenge.",
                                            textAlign: TextAlign.center),
                                        TextButton(
                                            onPressed: () {
                                              _pickTasksAgain();
                                            },
                                            child: const Text("Start again"))
                                      ])));
                            } else if (userStatus == "fail") {
                              return Flexible(
                                  child: SizedBox(
                                      height: 300,
                                      width: 400,
                                      child: Column(children: [
                                        const SizedBox(height: 50),
                                        const Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Text(
                                                "Looks like you missed a day!\nYour challenge has come to an end.",
                                                textAlign: TextAlign.center)),
                                        TextButton(
                                            onPressed: () {
                                              _pickTasksAgain();
                                            },
                                            child: const Text("Start again"))
                                      ])));
                            } else {
                              return Flexible(
                                  child: SizedBox(
                                      height: 300,
                                      width: 400,
                                      child: Column(children: [
                                        StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                            stream: db
                                                .collection("users")
                                                .doc(FirebaseAuth.instance.currentUser!.email!)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                        DocumentSnapshot<
                                                            Map<String,
                                                                dynamic>>>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return const Text(
                                                    'Something went wrong');
                                              }
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Text("Loading");
                                              }
                                              Map<String, dynamic> data =
                                                  snapshot.data!.data()
                                                      as Map<String, dynamic>;
                                              int dayDifference = data["day"]!;
                                              return Text(
                                                "Day $dayDifference",
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: "Arial",
                                                  color: Colors.teal,
                                                  letterSpacing: 1.2,
                                                ),
                                              );
                                            }),
                                        const SizedBox(height: 50),
                                        StreamBuilder<QuerySnapshot>(
                                            stream: db
                                                .collection("users")
                                                .doc(FirebaseAuth.instance.currentUser!.email!)
                                                .collection("tasks")
                                                .orderBy("taskName")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData)
                                                return const Text('Loading...');
                                              List<QueryDocumentSnapshot>
                                                  taskDocs =
                                                  snapshot.data!.docs;
                                              return Flexible(
                                                  child: ListView.builder(
                                                      itemCount:
                                                          taskDocs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return TaskCompletionWidget(
                                                            taskName: taskDocs[
                                                                    index]
                                                                .get(
                                                                    "taskName"),
                                                            isCompleted: taskDocs[
                                                                    index]
                                                                .get(
                                                                    "isCompleted"));
                                                      }));
                                            })
                                      ])));
                            }
                          })
                    ])))));
  }

  void _pickTasksAgain() async {
    await ifs.startAgain();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const EditNewUserPage(),
        ),
        (route) => false);
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 350,
        height: 50,
        child: Row(children: [
          Checkbox(
            value: widget.isCompleted,
            onChanged: (value) {
              setState(() {
                widget.isCompleted = value!;
                if (value) {
                  tfs.updateTask(widget.taskName, true);
                  _taskCompletionPopUp();
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
                Text(widget.taskName,
                    style: const TextStyle(color: Colors.black))
              ]))
        ]));
  }

  void _taskCompletionPopUp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Congratulations!"),
              content: const Text(
                  "You completed a task. Would you like to share this achievement with your friends?"),
              actions: [
                TextButton(
                    onPressed: () {
                      var randomInt = Random().nextInt(10) + 1;
                      ffs.addPostPrivate(FirebaseAuth.instance.currentUser!.email!, widget.taskName, randomInt);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Keep Private")),
                TextButton(
                    onPressed: () {
                      var randomInt = Random().nextInt(10) + 1;
                      ffs.addPostPrivate(FirebaseAuth.instance.currentUser!.email!, widget.taskName, randomInt);
                      ffs.addPostPublic(FirebaseAuth.instance.currentUser!.email!, widget.taskName, randomInt);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Share")),
                TextButton(
                    onPressed: () {
                      tfs.updateTask(widget.taskName, false);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"))
              ]);
        });
  }
}
