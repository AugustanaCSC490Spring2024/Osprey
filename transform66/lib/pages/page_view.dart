import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/firestore_actions/friends_firestore.dart';
import 'package:transform66/pages/calendar_page.dart';
import 'package:transform66/pages/feed_page.dart';
import 'package:transform66/pages/friends.dart';
import 'package:transform66/pages/info.dart';
import 'package:transform66/pages/progress_page.dart';

class PageViewHelper extends StatefulWidget {
  const PageViewHelper({super.key});

  @override
  State<PageViewHelper> createState() => _PageViewHelperState();
}

class _PageViewHelperState extends State<PageViewHelper>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _selectedIndex = 2;

  final FriendsFirestoreService ffs = FriendsFirestoreService();
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;
  final db = FirebaseFirestore.instance;
  final Map<int,String> infoMap = {
    0:"This is the friends page. Add, accept, and remove friends here. Tap on their name to also be able to send them a message.",
    1:"This is the feed page. Keep up with your history and with that of your friends.",
    2:"This is the progress page. Here you can mark your tasks finished. You will have the option to share with others or not.",
    3:"This is the calendar page. Plan your weeks ahead here.",
    4:"This is the profile page. Log out or delete your account as needed."
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
                      content: Text(infoMap[_selectedIndex]!,textAlign: TextAlign.center)
                    );
                  }
                );
              },
              icon: const Icon(Icons.info_outlined)
            )
          //   PopupMenuButton<String>(
          //     onSelected: (String result) {
          //       if (result == 'Sign Out') {
          //         Auth().signOut();
          //         Navigator.pushReplacement(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const LoginPage()));
          //       }
          //     },
          //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          //       const PopupMenuItem<String>(
          //         value: 'Sign Out',
          //         child: Text('Sign Out'),
          //       ),
          //     ],
          //   ),
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