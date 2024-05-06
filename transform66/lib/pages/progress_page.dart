import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/firestore_actions/tasks_firestore.dart';
import 'package:transform66/pages/add_friends_page.dart';
import 'package:transform66/pages/instructions_page.dart';
import 'package:transform66/pages/login_register_page.dart';
import 'package:transform66/pages/testimonials_page.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {

  final TasksFirestoreService tfs = TasksFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'Progress',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24
            ),
          ),
          backgroundColor: Colors.teal,
          actions: [
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Sign Out') {
                  Auth().signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LoginPage()) // Navigate back to LoginPage
                      );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Sign Out',
                  child: Text('Sign Out'),
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 75),
              Image.asset('assets/images/Transform66.png', height: 110),
              const SizedBox(height: 75),
              const Text('0/66 days completed', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 25),
              SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email!).collection("dates").orderBy("taskName").snapshots(),
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
                                taskName: taskDocs[index].get("taskName"), isCompleted: taskDocs[index].get("isCompleted"));
                          },
                        );
                      } else {
                        return const Text("Loading...");
                      }
                    }),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddFriends()));
                    },
                    child: const Text(
                      'Friends'
                    ),
                  ),
                  const Text("|"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InstructionsPage()));
                    },
                    child: const Text(
                      'Instructions'
                    ),
                  ),
                  const Text("|"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Testimonials()));
                    },
                    child: const Text(
                      'Testimonials'
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
