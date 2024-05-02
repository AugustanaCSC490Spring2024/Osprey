import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';

class InstructionsPage extends StatelessWidget {
  InstructionsPage({super.key});

  final User? user = Auth().currentUser;


  @override
  Widget build(BuildContext context){
    return Scaffold(
            appBar: AppBar(
        title: const Text(
          'Instructions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ), 
      body: const AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "1. When you click the start transform 66 button, then you are directed to customizing your task.\n\n"
                  "2. Choose a couple of tasks that you want to commit to for 66 days.\n\n"
                  "3. Remember that if you miss a day you will be taken back to day 1 so do not forget to do your task and mark it down.\n\n"
                  "4. When you right swipe for feed and friend.\n\n"
                  "5. When you swipe left, you can view your progress in the calendar.\n\n"
                  "6. Click three dots in the top right corner to view instructions and about us. There is also a signout button that will take you back to the login page.\n\n",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              
              ],
            )),
        )
    );
      }
  }