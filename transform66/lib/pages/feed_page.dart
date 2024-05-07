import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';

class Feed extends StatelessWidget {
  Feed({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: const Text(
          'Feed',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24
          ),
        ),
        backgroundColor: Colors.teal
      ),
  );
  }

}