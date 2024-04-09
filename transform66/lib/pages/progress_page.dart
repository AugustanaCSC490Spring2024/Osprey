//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/pages/add_friends_page.dart';
import 'package:transform66/pages/calendar_page.dart';
import 'package:transform66/pages/instructions_page.dart';
import 'package:transform66/pages/testimonials_page.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Transform66.png',
                  width: 300,
                  height: 300,
                ),
                //const SizedBox(height: 20),
                const Text(
                  'Your progress for the day:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                TaskWidget(
                  taskName: 'Drink 1 gallon of Water',
                  onPressed: () {},
                ),
                TaskWidget(
                  taskName: 'Read 10 pages of a non-fiction book',
                  onPressed: () {},
                ),
                TaskWidget(
                  taskName: '45 min outdoor exercise',
                  onPressed: () {},
                ),
                TaskWidget(
                  taskName: '3 pages of creative writing',
                  onPressed: () {},
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFriends(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Add Friends',
                      style: TextStyle(
                          color: Colors.black,
                          decoration:
                              TextDecoration.underline), // Change color to black
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InstructionsPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Instructions',
                      style: TextStyle(
                          color: Colors.black,
                          decoration:
                              TextDecoration.underline), // Change color to black
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Testimonials(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Testimonials',
                      style: TextStyle(
                          color: Colors.black,
                          decoration:
                              TextDecoration.underline), // Change color to black
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      )
    );
  }
}

class TaskWidget extends StatefulWidget {
  final String taskName;
  final VoidCallback onPressed;

  const TaskWidget({
    required this.taskName,
    required this.onPressed,
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
          width: double.infinity,
          height: 50,
          child: Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
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
                    SizedBox(height: 10),
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
