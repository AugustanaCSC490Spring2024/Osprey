// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transform66/firestore_actions/feed_firestore.dart';

class FeedWidget extends StatefulWidget {
  final String userName;
  final Timestamp date;
  final String message;
  final String imageType;
  final String imagePath = "images/feedImages/";

  FeedWidget({
    required this.userName,
    required this.date,
    required this.message,
    required this.imageType,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final FeedFirestoreService ffs2 = FeedFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal,
                ),
                child: Center(
                  child: Text(
                    widget.userName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.userName,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black)),
                  Text(widget.message,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                ])
          ],
        ),
        const SizedBox(height: 5),
        Image.asset(
          "assets/${widget.imagePath}${widget.imageType}.jpg",
          width: 300,
          height: 300,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 5),
        Text(widget.date.toDate().toString().substring(0, 16)),
      ]),
    ));
  }
}
