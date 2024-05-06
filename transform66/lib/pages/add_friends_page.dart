import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/friends_firestore.dart';

class AddFriends extends StatefulWidget {
  
  AddFriends({Key? key}) : super(key: key);

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  
  final FriendsFirestoreService ffs = FriendsFirestoreService();
  final TextEditingController textController = TextEditingController();
  final Map<String, String> statusMap = {"requested":"REQUEST SENT","pending":"NEW","accepted":""};
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;

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
                ffs.requestFriend(yourEmail,textController.text);
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
        stream: FirebaseFirestore.instance.collection("users").doc(yourEmail).collection("friends").orderBy("date").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List friendList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = friendList[index];
                String friendID = document.id;
                
                return ListTile(
                  title: Text(
                    friendID
                  ),
                  trailing: Text(statusMap[document.get("status")]!),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Actions"),
                          actions: <Widget>[
                            Visibility(
                              visible: document.get("status")=="pending",
                              child: Center(
                                child: TextButton(
                                  child: const Text("Accept"),
                                  onPressed: () {
                                    ffs.acceptFriend(yourEmail,friendID);
                                    Navigator.of(context).pop();
                                  }
                                )
                              )
                            ),
                            Center(
                              child: TextButton(
                                child: const Text("Remove"),
                                onPressed: () {
                                  ffs.removeFriend(yourEmail,friendID);
                                  Navigator.of(context).pop();
                                }
                              )
                            )
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