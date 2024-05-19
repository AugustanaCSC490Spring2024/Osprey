// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/feed_firestore.dart';

class FriendFeedWidget extends StatefulWidget {
  final String userName;
  final Timestamp date;
  final String message;
  var isLiked = false;
  final String imageType;
  final String imagePath = "images/feedImages/";

  FriendFeedWidget({
    required this.userName,
    required this.date,
    required this.message,
    required this.isLiked,
    required this.imageType,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FriendFeedWidgetState createState() => _FriendFeedWidgetState();
}

class _FriendFeedWidgetState extends State<FriendFeedWidget> {
  final FeedFirestoreService ffs2 = FeedFirestoreService();

  @override
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(10),child: 
      Column(children: [
        Row(children: [
          const CircleAvatar(radius: 20, backgroundImage: AssetImage("assets/images/Transform66.png"), backgroundColor: Colors.transparent),
          const SizedBox(width: 10),
          Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.userName, style: const TextStyle(fontSize: 14, color: Colors.black)),
                Text(widget.message, style: const TextStyle(fontSize: 16, color: Colors.black)),
              ])
        ],),
        const SizedBox(height: 5),
        Image.asset(
        "assets/${widget.imagePath}${widget.imageType}.jpg",
        width: 300,
        height: 300,
        fit: BoxFit.cover,
      ),
        const SizedBox(height: 5),
        Text(widget.date.toDate().toString().substring(0, 16))
      ]),
    ));
  }
}
