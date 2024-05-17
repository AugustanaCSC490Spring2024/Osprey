import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/friends_firestore.dart';
import 'package:transform66/pages/calendar.dart';
import 'package:transform66/pages/feed.dart';
import 'package:transform66/pages/friends.dart';
import 'package:transform66/pages/info.dart';
import 'package:transform66/pages/progress.dart';

class PageViewHelper extends StatefulWidget {
  const PageViewHelper({super.key});

  @override
  State<PageViewHelper> createState() => _PageViewHelperState();
}

class _PageViewHelperState extends State<PageViewHelper> with TickerProviderStateMixin {
  
  late PageController _pageViewController;
  late TabController _tabController;
  int _selectedIndex = 2;

  final FriendsFirestoreService ffs = FriendsFirestoreService();
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;
  final db = FirebaseFirestore.instance;
  final Map<int,String> infoMap = {
    0:"This is the friends page. Add, accept, and remove friends here. Tap on their email for options. You can also send your friends a motivation tile.",
    1:"This is the feed page. When you complete a task, a tile shows up here. Good job. When your friends complete a task, a tile shows up here too, under friends updates. Motivation you send back and forth show up here as well.",
    2:"This is the progress page. Mark your tasks complete before 11:59 pm! You decide if your friends can see your updates.",
    3:"This is the calendar page. Plan your weeks ahead here.",
    4:"This is the profile page. Log out, update notification settings, or delete your account as needed."
  };
  
  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: _selectedIndex);
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageViewController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageViewController,
          children: [
            Friends(),
            FeedPage(),
            ProgressPage(),
            CalendarScreen(),
            Info()
          ],
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              onPressed:() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                        infoMap[_selectedIndex]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16))
                    );
                  }
                );
              },
              icon: const Icon(Icons.info_outlined)
            )
          ]
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.teal,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions_outlined),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Me',
            ),
          ],
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}