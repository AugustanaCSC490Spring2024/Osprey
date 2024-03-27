import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transform66/pages/edit_new_user_page.dart';

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
              width: 200, 
              height: 100, 
              child: ElevatedButton(
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditNewUserPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              child: const Text(
                'Start Transform66',
                style: TextStyle(color: Colors.black, fontSize: 16), // Change color to black
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
                    style: TextStyle(color: Colors.black, decoration: TextDecoration.underline), // Change color to black
                  ),
                ),
                const Text(' | '),
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
                    style: TextStyle(color: Colors.black, decoration: TextDecoration.underline), // Change color to black
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

