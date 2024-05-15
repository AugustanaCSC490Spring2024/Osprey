// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:transform66/auth.dart';
// import 'package:transform66/firestore_actions/feed_firestore.dart';
// import 'package:transform66/firestore_actions/friends_firestore.dart';
// import 'package:transform66/widgets/feed_widget.dart';

// class Feed extends StatefulWidget {
//   Feed({Key? key}) : super(key: key);

//   @override
//   State<Feed> createState() => _FeedState();
// }

// class _FeedState extends State<Feed> {
//   final User? user = Auth().currentUser;
//   final String yourEmail = FirebaseAuth.instance.currentUser!.email!;

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection("users").doc(yourEmail).collection("feed").orderBy("date").snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List friendList = snapshot.data!.docs;
//             return ListView.builder(
//               itemCount: friendList.length,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot document = friendList[index];
//                 return ListTile(
//                   title: Text(
//                     document.get("message")
//                   ),
//                 );
//               }
//             );
//           }
//           else {
//             return const Text("");
//           }
//         }
//       )
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final User? user = Auth().currentUser;
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(144, 195, 200, 1),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Personal Updates"),
              Tab(text: "Friends Updates"),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            MyFeedTab(),
            FriendFeedTab(),
          ],
        ),
      ),
    );
  }
}

class MyFeedTab extends StatefulWidget {
  MyFeedTab({Key? key}) : super(key: key);

  @override
  State<MyFeedTab> createState() => _MyFeedTabState();
}

class _MyFeedTabState extends State<MyFeedTab> {
  final User? user = Auth().currentUser;
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(yourEmail).collection("personalFeed").orderBy("date").snapshots(),
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

class FriendFeedTab extends StatefulWidget {
  FriendFeedTab({Key? key}) : super(key: key);

  @override
  State<FriendFeedTab> createState() => _FriendFeedTabState();
}

class _FriendFeedTabState extends State<FriendFeedTab> {
  final User? user = Auth().currentUser;
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(yourEmail).collection("friendsFeed").orderBy("date").snapshots(),
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