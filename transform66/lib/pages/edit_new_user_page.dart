import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/tasks_firestore.dart';
import 'package:transform66/pages/page_view.dart';

class EditNewUserPage extends StatelessWidget {
  const EditNewUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transform66',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24
          ),
        ),
        backgroundColor: Colors.teal
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Choose tasks you will commit to for 66 days:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 950,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TaskWidget(
                        taskName: 'Drink 1 gallon of Water',
                      ),
                      TaskWidget(
                        taskName: 'Read 10 pages of a non-fiction book',
                      ),
                      TaskWidget(
                        taskName: '45 min outdoor exercise',
                      ),
                      TaskWidget(
                        taskName: '3 pages of creative writing',
                      ),
                      TaskWidget(
                        taskName: '10 mins outdoor walk',
                      ),
                      TaskWidget(
                        taskName: '15 mins walk your pet',
                      ),
                      TaskWidget(
                        taskName: '20 mins self reflection',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => _showAddTaskDialog(context),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              child: const Text(
                'Edit',
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (TaskWidget.selectedTasks.isEmpty) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select at least one task.'),
              ),
            );
          } else {
            await addUserDetails();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PageViewHelper(),
              ),
            );
          }
        },
        backgroundColor: Colors.red,
        child: const Text("Start"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    String newTaskName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextFormField(
            onChanged: (value) {
              newTaskName = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter task name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the new task
                if (newTaskName.isNotEmpty) {
                  Navigator.of(context).pop();
                  TaskWidget.selectedTasks.add(newTaskName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Task added: $newTaskName'),
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> addUserDetails() async {
    List<String> selectedTasks = TaskWidget.selectedTasks;

    final TasksFirestoreService tfs = TasksFirestoreService();

    tfs.addTasks(selectedTasks);
    
    // Add user details to Firestore
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).set({
      'first_day':DateTime.now(),
      'last_day':DateTime.now().add(const Duration(days: 66)),
    });
  }
}

class TaskWidget extends StatefulWidget {
  final String taskName;

  static List<String> selectedTasks = [];

  const TaskWidget({
    required this.taskName,
    Key? key,
  }) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 85,
          child: ListTile(
            onTap: () {
              setState(() {
                _isSelected = !_isSelected;
                if (_isSelected) {
                  TaskWidget.selectedTasks.add(widget.taskName);
                } else {
                  TaskWidget.selectedTasks.remove(widget.taskName);
                }
              });
            },
            tileColor: _isSelected ? Colors.grey[300] : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              widget.taskName,
              style: TextStyle(
                color: _isSelected ? Colors.black : Colors.black,
              ),
            ),
          ),
        ),
        const Divider(), // Horizontal line
      ],
    );
  }
}
