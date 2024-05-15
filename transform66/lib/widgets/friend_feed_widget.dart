import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/feed_firestore.dart';
//import 'package:transform66/firestore_actions/tasks_firestore.dart';

class FriendFeedWidget extends StatefulWidget {
  final String user;
  final DateTime date;
  final String message;

  FriendFeedWidget({
    required this.user,
    required this.date,
    required this.message,
    super.key,
  });

  @override
  _FriendFeedWidgetState createState() => _FriendFeedWidgetState();
}

class _FriendFeedWidgetState extends State<FriendFeedWidget> {
  final FeedFirestoreService ffs2 = FeedFirestoreService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message,
                  style: const TextStyle(color: Colors.black),
                )
              ]
            )
          )
        ]
      )
    );
  }
}