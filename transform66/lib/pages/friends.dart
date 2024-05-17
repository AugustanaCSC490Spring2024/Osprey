import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/feed_firestore.dart';
import 'package:transform66/firestore_actions/friends_firestore.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  
  final FriendsFirestoreService ffs = FriendsFirestoreService();
  final FeedFirestoreService ffs2 = FeedFirestoreService();
  final TextEditingController textController = TextEditingController();
  final Map<String, String> statusMap = {"requested":"REQUEST SENT","pending":"NEW","accepted":""};
  final Map<String, Color> colorMap = {"requested":Colors.yellow,"pending":Colors.green,"accepted":Colors.white};
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;

  void askForName() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          decoration: const InputDecoration(
            labelText: "Email"
          ),
          controller: textController
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () async {
                if (textController.text!=yourEmail) {
                  ffs.requestFriend(yourEmail,textController.text);
                }
                textController.clear();
                Navigator.pop(context);
              },
              child: const Text("Request")
            )
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(padding:const EdgeInsets.only(bottom:20),child:FloatingActionButton(onPressed: () => askForName(), child: const Icon(Icons.add_reaction_outlined))),
      body: Column(children:[Expanded(child:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(yourEmail).collection("friends").orderBy("date").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List friendList = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = friendList[index];
                String friendEmail = document.id;
                
                return Container(color:const Color.fromARGB(95, 143, 239, 229),child:ListTile(
                  title: Text(
                    friendEmail,
                    style: const TextStyle(fontSize: 16)
                  ),
                  trailing: Text(
                    statusMap[document.get("status")]!,
                    style: TextStyle(color: colorMap[document.get("status")])
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            const Text("What would you like to do?",style: TextStyle(fontSize: 16)),
                            const SizedBox(height:15),
                            Visibility(
                              visible: document.get("status")=="pending",
                              child: TextButton(
                                  child: const Text("Accept"),
                                  onPressed: () {
                                    ffs.acceptFriend(yourEmail,friendEmail);
                                    Navigator.of(context).pop();
                                  }
                                )
                            ),
                            Visibility(
                              visible: document.get("status")=="accepted",
                              child:
                                TextButton(
                                  child: const Text("Send motivation"),
                                  onPressed: () {
                                    var randomInt = Random().nextInt(12) + 1;
                                    ffs2.sendMotivation(yourEmail,friendEmail, randomInt);
                                    Navigator.of(context).pop();
                                  }
                                )
                            ),
                            TextButton(child:const Text("Remove"),onPressed: () {ffs.removeFriend(yourEmail,friendEmail);Navigator.of(context).pop();})])
                        );
                  }
                );
              }
                ));});}
          else {
            return const Text("");
          }
        }
      ))
      ])
    );
  }
}