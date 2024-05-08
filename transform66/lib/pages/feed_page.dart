import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';

class Feed extends StatefulWidget {
  Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final User? user = Auth().currentUser;
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(yourEmail).collection("feed").orderBy("date").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List friendList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = friendList[index];
                
                return ListTile(
                  title: Text(
                    document.get("message")
                  ),
                );
              }
            );
          }
          else {
            return const Text("");
          }
        }
      ) 
    );
  }
}