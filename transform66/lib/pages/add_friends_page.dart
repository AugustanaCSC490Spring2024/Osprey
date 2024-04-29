import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/services/firestore.dart';

class AddFriends extends StatefulWidget {
  AddFriends({Key? key}) : super(key: key);

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  final User? user = Auth().currentUser;

  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  void askForName() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          decoration: const InputDecoration(
            labelText: "email"
          ),
          controller: textController
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () async {
                bool test = await firestoreService.hasUser(textController.text);
                if (test) {
                  firestoreService.addFriend(textController.text);
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
      appBar: AppBar(
        title: const Text("Friends"),
        backgroundColor: Colors.teal
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: askForName,
        child: const Icon(Icons.add_reaction_outlined)
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getFriendsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List friendList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = friendList[index];
                String docID = document.id;
                bool mutual = false;
                
                return ListTile(
                  title: Text(
                    docID
                  ),
                  trailing: IconButton (
                    onPressed: () {
                      firestoreService.removeFriend(docID);
                      },
                    icon: const Icon(Icons.close)
                  )
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