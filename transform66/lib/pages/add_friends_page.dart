import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  
  // Open a dialog
  void askForName() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                firestoreService.addFriend(textController.text);
                AddFriends.hovering2[textController.text] = false;
                textController.clear();
                Navigator.pop(context);
              },
              child: const Text("Send request")
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
        title: Text(
          "Friends",
          style: GoogleFonts.architectsDaughter(
            textStyle: const TextStyle(color: Colors.black)
          )
        ),
        backgroundColor: Colors.teal
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: askForName,
        child: const Icon(Icons.add_reaction_outlined)
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getFriendsStream(),
        builder: (context, snapshot) {
          // If we have data, retrieve it
          if (snapshot.hasData) {
            List friendList = snapshot.data!.docs;

            // Display as list view
            return ListView.builder(
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                // Get each individual entry
                DocumentSnapshot document = friendList[index];
                String docID = document.id;

                // Get the info
                //Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                //String name = data['email'];

                // Display
                return MouseRegion(
                  onEnter: (PointerEvent details) => setState(() => AddFriends.hovering2[docID] = true),
                  onExit: (PointerEvent details) => setState(() => AddFriends.hovering2[docID] = false),
                  child: ListTile(
                    title: Text(docID),
                    trailing: Visibility(
                      visible: AddFriends.hovering2[docID] ?? false,
                      child: IconButton (
                        onPressed: () {
                          firestoreService.removeFriend(docID);
                          AddFriends.hovering2.remove(docID);},
                        icon: const Icon(Icons.close)
                      )
                    )
                  )
                );
              }
            );
          }
          else {
            // Why doesn't this work?
            // from leandra: this message will pop up when you first click on add friends page
            // even if you do have friends but only for a second, can explain more just a mental
            // note for myself to remember
            return const Text("No friends yet");
          }
        }
      )
    );
  }
}