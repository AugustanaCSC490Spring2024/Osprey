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

  final Map<String, String> statusMap = {"requested":"REQUEST SENT","pending":"NEW","accepted":""};

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
                // whether or not there is a user
                bool test1 = await firestoreService.hasUser(textController.text);
                // whether or not the request already exists
                bool test2 = await firestoreService.hasFriend(FirebaseAuth.instance.currentUser!.email!,textController.text);
                if (test1&&!test2) {
                  firestoreService.requestFriend(FirebaseAuth.instance.currentUser!.email!,textController.text);
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
                
                return ListTile(
                  title: Text(
                    docID
                  ),
                  trailing: Text(statusMap[document.get("status")]!),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Actions"),
                          actions: <Widget>[
                            Visibility(visible: document.get("status")=="pending",child: Center(child: TextButton(
                              child: const Text("Accept"),
                              onPressed: () {
                                firestoreService.acceptFriend(FirebaseAuth.instance.currentUser!.email!,docID);
                                Navigator.of(context).pop();
                              }
                            ))),
                            Center(child: TextButton(
                              child: const Text("Remove"),
                              onPressed: () {
                                firestoreService.removeFriend(FirebaseAuth.instance.currentUser!.email!,docID);
                                Navigator.of(context).pop();
                              }
                            ))
                          ]
                        );
                      }
                    );
                  }
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