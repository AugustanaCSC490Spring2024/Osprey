import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/feed_firestore.dart';

class PersonalFeedWidget extends StatefulWidget {
  final String userName;
  final Timestamp date;
  final String message;
  final String imageType;
  final String imagePath = "images/feedImages/";

  PersonalFeedWidget({
    required this.userName,
    required this.date,
    required this.message,
    required this.imageType,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PersonalFeedWidgetState createState() => _PersonalFeedWidgetState();
}

class _PersonalFeedWidgetState extends State<PersonalFeedWidget> {
  final FeedFirestoreService ffs2 = FeedFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(10),child: 
      Column(children: [
        Row(children: [
          const CircleAvatar(radius: 20, backgroundImage: AssetImage("assets/images/Transform66.png"), backgroundColor: Colors.transparent),
          const SizedBox(width: 10),
          Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.userName, style: const TextStyle(fontSize: 16, color: Colors.black)),
                Text(widget.message, style: const TextStyle(fontSize: 18, color: Colors.black)),
              ])
        ],),
        const SizedBox(height: 5),
        SizedBox(
          width:300,
          height:300,
          child: Image(image: AssetImage("${widget.imagePath}${widget.imageType}.jpg"))),
        const SizedBox(height: 5),
      ]),
    ));
  }
}