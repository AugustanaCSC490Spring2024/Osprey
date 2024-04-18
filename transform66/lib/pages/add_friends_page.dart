import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/services/firestore.dart';

class AddFriends extends StatefulWidget {
  AddFriends({Key? key}) : super(key: key);

  static Map<String, bool> hovering2 = {};

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  final User? user = Auth().currentUser;

  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();
  
  // open a dialog
  void askForName() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              firestoreService.addFriend(textController.text);
              AddFriends.hovering2[textController.text] = false;
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text("Send request")
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Friends',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24
          )
        ),
        backgroundColor: Colors.teal
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: askForName,
        child: const Icon(Icons.add)
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getFriendsStream(),
        builder: (context, snapshot) {
          // if we have data, retrieve it
          if (snapshot.hasData) {
            List friendList = snapshot.data!.docs;

            // display as list view
            return ListView.builder(
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                // get each individual entry
                DocumentSnapshot document = friendList[index];
                String docID = document.id;

                // get the info
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String name = data['email'];

                // display
                return MouseRegion(
                  onEnter: (PointerEvent details) => setState(() => AddFriends.hovering2[data["email"]] = true),
                  onExit: (PointerEvent details) => setState(() => AddFriends.hovering2[data["email"]] = false),
                  child: ListTile(
                    title: Text(name),
                    trailing: Visibility(
                      visible: AddFriends.hovering2[data["email"]] ?? false,
                      child: IconButton (
                        onPressed: () {
                          firestoreService.removeFriend(docID);
                          AddFriends.hovering2.remove("email");},
                        icon: const Icon(Icons.close)
                      )
                    )
                  )
                );
              }
            );
          }
          else {
            return const Text("No friends yet");
          }
        }
      )
    );
  }
}