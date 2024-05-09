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
        backgroundColor: Color.fromRGBO(93, 166, 172, 1),
      ), 
      body: const AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "1. When you click the start transform 66 button, then you are directed to customizing your task.\n\n"
                  "2. Choose a couple of tasks that you want to commit to for 66 days.\n\n"
                  "3. Remember that if you miss a day you will be taken back to day 1 so don't forget to do your task and mark it down.\n\n"
                  "4. Swipe right and you will see Feed to keep yourself updated on what tasks your friends are commiting.\n\n"
                  "5. Swipe right and you will see Calendar to view your progress. You can see what day you are on and how many days are remaining.\n\n"
                  "6. Click three dots in the top right corner to signout, it'll take you back to the login page.\n\n"
                  "7. If you click Friends icon, you will be directed to a page where you can request your friend. \n\n"
                  "8. After requesting, your friend will have a notification if they want to accept or reject the invitation.\n\n"
                  "9. If they accept the friend request, you will be able to message your friend and see them in your feed.\n\n",
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