
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/feed_firestore.dart';
//import 'package:transform66/firestore_actions/tasks_firestore.dart';

class FeedPageWidget extends StatefulWidget {
  final String taskName;
  var isCompleted = false;

  FeedPageWidget({
    required this.taskName,
    required this.isCompleted,
    super.key,
  });

  @override
  _FeedPageWidgetState createState() => _FeedPageWidgetState();
}

class _FeedPageWidgetState extends State<FeedPageWidget> {
  final FeedFirestoreService tfs = FeedFirestoreService();

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
                  widget.taskName,
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