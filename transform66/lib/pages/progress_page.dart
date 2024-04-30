// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/pages/add_friends_page.dart';
import 'package:transform66/pages/calendar_page.dart';
import 'package:transform66/pages/instructions_page.dart';
import 'package:transform66/pages/login_register_page.dart';
import 'package:transform66/pages/testimonials_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transform66/services/firestore.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'Transform66',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
                icon: const Icon(Icons.calendar_month_sharp),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Calendar()));
                }),
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
              const Text('Your progress for today:',
                  style: TextStyle(fontSize: 16)),
              SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                    stream: firestoreService.getTasksStream(),
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
                            return TaskWidget(
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
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 10))),
                    child: const Text(
                      'Add Friends',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InstructionsPage()));
                    },
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 10))),
                    child: const Text(
                      'Instructions',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Testimonials()));
                    },
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 10))),
                    child: const Text(
                      'Testimonials',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class TaskWidget extends StatefulWidget {
  final String taskName;
  var isCompleted = false;

  TaskWidget({
    required this.taskName,
    required this.isCompleted,
    super.key,
  });

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
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
                      firestoreService.updateTask(widget.taskName, true);
                    } else {
                      firestoreService.updateTask(widget.taskName, false);
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
        ),
        //const Divider(), // Horizontal line
      ],
    );
  }
}
