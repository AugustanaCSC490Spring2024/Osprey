import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/pages/add_friends_page.dart';
import 'package:transform66/pages/calendar_page.dart';
import 'package:transform66/pages/instructions_page.dart';
import 'package:transform66/pages/login_register_page.dart';
import 'package:transform66/pages/testimonials_page.dart';

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
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 75),
                  Image.asset(
                    'assets/images/Transform66.png',
                    height: 110,
                  ),
                  const SizedBox(height: 75),
                  const Text(
                    '0/66 days completed',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    'Your progress for today:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const TaskWidget(taskName: 'Drink 1 gallon of Water'),
                  const TaskWidget(
                      taskName: 'Read 10 pages of a non-fiction book'),
                  const TaskWidget(
                    taskName: '45 min outdoor exercise',
                  ),
                  const TaskWidget(
                    taskName: '3 pages of creative writing',
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
                            decoration: TextDecoration
                                .underline), // Change color to black
                      ),
                    ), // Add Friends button
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
                            decoration: TextDecoration
                                .underline), // Change color to black
                      ),
                    ), // Instructions button
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
                            decoration: TextDecoration
                                .underline), // Change color to black
                      ),
                    ), // Testimonials button
                  ])
                ],
              ),
            ),
          ),
        ));
  }
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
          width: double.infinity,
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
