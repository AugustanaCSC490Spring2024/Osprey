import 'package:flutter/material.dart';

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
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose tasks you will commit for 66 days:',
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
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Colors.black, decoration: TextDecoration.underline), // Change color to black
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: const Text("Start"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class TaskWidget extends StatelessWidget {
  final String taskName;
  final VoidCallback onPressed;

  const TaskWidget({
    required this.taskName,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 85,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                taskName,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        const Divider(), // Horizontal line
      ],
    );
  }
}


