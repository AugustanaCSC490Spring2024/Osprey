import 'package:flutter/material.dart';

void main() {
  runApp(StartedPage(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Transform66'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Start Transform66'),
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Testimonials2'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Instructions2'),
                ),
              ],
            ),
          ],
        ),
      ),
  ),
  ));
}

class StartedPage extends StatelessWidget {
  final Widget home;
  const StartedPage({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home,
    );
  }
}

