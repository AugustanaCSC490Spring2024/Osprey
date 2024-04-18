import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transform66/pages/progress_page.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Choose tasks you will commit for 66 days:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 950,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      TaskWidget(
                        taskName: '10 mins outdoor walk',
                        onPressed: () {},
                      ),
                      TaskWidget(
                        taskName: '15 mins walk your pet',
                        onPressed: () {},
                      ),
                      TaskWidget(
                        taskName: '20 mins self reflection',
                        onPressed: () {},
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProgressPage(),
            ),
          );
        },
        backgroundColor: Colors.red,
        child: const Text("Start"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class TaskWidget extends StatefulWidget {
  final String taskName;
  final VoidCallback onPressed;

  const TaskWidget({
    required this.taskName,
    required this.onPressed,
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
