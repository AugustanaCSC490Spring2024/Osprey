import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/tasks_firestore.dart';
import 'package:transform66/pages/page_view.dart';

class EditNewUserPage extends StatefulWidget {
  const EditNewUserPage({super.key});

  @override
  _EditNewUserPageState createState() => _EditNewUserPageState();
}

class _EditNewUserPageState extends State<EditNewUserPage> {
  List<String> selectedTasks = [];
  List<String> tasks = [
    'Drink 1 gallon of Water',
    'Read 10 pages of a book',
    '45 min gym session',
    '3 pages of creative writing',
    '20 mins outdoor walk',
    '15 mins walk your pet',
    '10 mins self reflection',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transform66',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        backgroundColor: Colors.teal,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Choose tasks you will commit to for 66 days:',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                primary: true,
                child: SizedBox(
                  width: 950,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: tasks
                        .map((taskName) => TaskWidget(
                              taskName: taskName,
                              onSelectionChanged: _onSelectionChanged,
                            ))
                        .toList(),
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
                  const TextStyle(fontSize: 10),
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
          if (selectedTasks.isEmpty) {
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
                builder: (context) => const PageViewHelper(),
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
          title: const Text('Add new task'),
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
                if (newTaskName.isNotEmpty) {
                  setState(() {
                    tasks.add(newTaskName);
                  });
                  Navigator.of(context).pop();
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

  void _onSelectionChanged(String taskName, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedTasks.add(taskName);
      } else {
        selectedTasks.remove(taskName);
      }
    });
  }

  Future<void> addUserDetails() async {
    final TasksFirestoreService tfs = TasksFirestoreService();
    tfs.addTasks(selectedTasks);
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).set({'first_day': DateUtils.dateOnly(DateTime.now()),});
  }
}

class TaskWidget extends StatefulWidget {
  final String taskName;
  final Function(String, bool) onSelectionChanged;

  const TaskWidget({
    required this.taskName,
    required this.onSelectionChanged,
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
                widget.onSelectionChanged(widget.taskName, _isSelected);
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
