import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/firestore_actions/friends_firestore.dart';
import 'package:transform66/pages/calendar_page.dart';
import 'package:transform66/pages/feed_page.dart';
import 'package:transform66/pages/friends.dart';
import 'package:transform66/pages/login_register_page.dart';
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

  Map<int, String> instructionsMap = {
    0: "This is the friends page. Use the button to add a friend. They will have to accept your request. Click on their name to remove them, or to send them a message.",
    1: "This is the feed page. When you mark a task done, it will show up here. Messages from your friends will show up here. You can also choose whether to receive updates from your friends as well.",
    2: "This is the progress page. Swipe left to view the feed page and swipe right to view the calendar page.",
    3: "This is the calendar page. Plan your challenge here!"
  };

  final FriendsFirestoreService ffs = FriendsFirestoreService();
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: _selectedIndex);
    _tabController = TabController(length: 4, vsync: this);
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
                icon: const Icon(Icons.info_outlined),
                onPressed: () => _showInstructions(context)),
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Sign Out') {
                  Auth().signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Sign Out',
                  child: Text('Sign Out'),
                ),
              ],
            ),
          ],
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
          ],
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }

  void _showInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(instructionsMap[_selectedIndex]!,
                textAlign: TextAlign.center)
              ),
              Visibility(
                visible: _selectedIndex == 1,
                child: StreamBuilder<DocumentSnapshot<Map<String,dynamic>>> (stream: db.collection("users").doc(yourEmail).snapshots(),builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Column(children: [
                    const SizedBox(height:20),
                    const Text("Receive updates from friends?"),
                    TextButton(
                      onPressed:() {
                        ffs.setReceiveUpdatesStatus(yourEmail,!data["receiveUpdates"]);
                      },
                      child: Text(data["receiveUpdates"]?"Turn off":"Turn on")
                      )
                    ]
                  );
                }
              )
            )
          ])
        );
      }
    );
  }
}