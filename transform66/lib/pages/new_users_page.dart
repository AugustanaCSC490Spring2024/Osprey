import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MaterialApp(
    home: StartedPage(),
  ));
}

class StartedPage extends StatelessWidget {
  const StartedPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(
              width: 200, // Adjust width according to your preference
              height: 100, // Adjust height according to your preference
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              child: const Text(
                'Start Transform66',
                style: TextStyle(color: Colors.black), // Change color to black
            ),
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    'Testimonials',
                    style: TextStyle(color: Colors.black), // Change color to black
                  ),
                ),
                TextButton(
                  onPressed: () {
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
                    style: TextStyle(color: Colors.black), // Change color to black
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
  );
  }
}

