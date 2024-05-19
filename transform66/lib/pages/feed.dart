import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/widgets/friend_feed_widget.dart';
import 'package:transform66/widgets/personal_feed_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final User? user = Auth().currentUser;
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context) {
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
        body: TabBarView(
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(yourEmail)
                .collection("personalFeed")
                .orderBy("date", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List friendList = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: friendList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = friendList[index];
                      return PersonalFeedWidget(
                          date: document.get("date"),
                          userName: document.get("userName"),
                          message: document.get("message"),
                          imageType: document.get("imageType"));
                    });
              } else {
                return const Text("");
              }
            }));
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(yourEmail)
                .collection("friendsFeed")
                .orderBy("date", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List friendList = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: friendList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = friendList[index];
                      return FriendFeedWidget(
                          date: document.get("date"),
                          userName: document.get("userName"),
                          message: document.get("message"),
                          isLiked: document.get("isLiked"),
                          imageType: document.get("imageType"));
                    });
              } else {
                return const Text("");
              }
            }));
  }
}
