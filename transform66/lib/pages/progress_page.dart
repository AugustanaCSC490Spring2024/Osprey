import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/pages/add_friends_page.dart';
import 'package:transform66/pages/calendar_page.dart';
import 'package:transform66/pages/instructions_page.dart';
import 'package:transform66/pages/login_register_page.dart';
import 'package:transform66/pages/testimonials_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:transform66/services/firestore.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Calendar(),
                    ),
                  );
                }),
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Sign Out') {
                  Auth().signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage()), // Navigate back to LoginPage
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
        body: Column(
          children: [
            SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: getTasksStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<QueryDocumentSnapshot> taskDocs = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap:
                            true, // Make the ListView scrollable within SingleChildScrollView
                        physics:
                            const NeverScrollableScrollPhysics(), // Disable scrolling of the ListView
                        itemCount: taskDocs.length,
                        itemBuilder: (context, index) {
                          return TaskWidget(
                            taskName: taskDocs[index].get("taskName"),
                          );
                        },
                      );
                    } else {
                      return const Text("Loading...");
                    }
                  }),
            ),
          ],
        ));
  }
}

Stream<QuerySnapshot> getTasksStream() {
  final FirestoreService firestoreService = FirestoreService();
  return firestoreService.getTasksStream();
}

class TaskWidget extends StatefulWidget {
  final String taskName;
  static List<String> selectedTasks = [];
  static List<String> finishedTasks = [];

  const TaskWidget({
    required this.taskName,
    super.key,
  });

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 350,
          height: 50,
          child: Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                    if (_isChecked) {
                      TaskWidget.finishedTasks.add(widget.taskName);
                      //isCompleted = true;
                    } else {
                      TaskWidget.finishedTasks.remove(widget.taskName);
                      //isCompleted = false;
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
        const Divider(), // Horizontal line
      ],
    );
  }
}
