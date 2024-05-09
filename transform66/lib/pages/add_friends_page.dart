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
        backgroundColor: const Color.fromRGBO(93, 166, 172, 1)
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
                String friendEmail = document.id;
                
                return ListTile(
                  title: Text(
                    friendEmail
                  ),
                  trailing: Text(statusMap[document.get("status")]!),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                            Visibility(
                              visible: document.get("status")=="pending",
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[const Icon(Icons.check),TextButton(
                                  child: const Text("Accept"),
                                  onPressed: () {
                                    ffs.acceptFriend(yourEmail,friendEmail);
                                    Navigator.of(context).pop();
                                  }
                                )
                          ])
                            ),
                            Visibility(
                              visible: document.get("status")=="accepted",
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,children:<Widget>[const Icon(Icons.insert_emoticon),
                                TextButton(
                                  child: const Text("Send message"),
                                  onPressed: () {
                                    ffs.sendMessage(yourEmail,friendEmail);
                                    Navigator.of(context).pop();
                                  }
                                )
                          ])
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,children:<Widget>[const Icon(Icons.close),TextButton(child:const Text("Remove"),onPressed: () {ffs.removeFriend(yourEmail,friendEmail);Navigator.of(context).pop();})])
                        ]));
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