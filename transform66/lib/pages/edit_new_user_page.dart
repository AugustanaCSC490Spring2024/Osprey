import 'package:flutter/material.dart';

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
      body: Center(
        child: Icon(
          Icon.airport_shuttle
        ),
        ,) 
  );
  }
}

