import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/pages/calendar_page.dart';
import 'package:transform66/pages/feed_page.dart';
import 'package:transform66/pages/instructions_page.dart';
import 'package:transform66/pages/login_register_page.dart';
import 'package:transform66/pages/progress_page.dart';

class PageViewHelper extends StatefulWidget {
  const PageViewHelper({Key? key}) : super(key: key);

  @override
  State<PageViewHelper> createState() => _PageViewHelperState();
}

class _PageViewHelperState extends State<PageViewHelper>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _selectedIndex = 1; // Initially selected index

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: _selectedIndex);
    _tabController = TabController(length: 3, vsync: this);
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
        children: <Widget>[
          Feed(),
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
        backgroundColor: Color.fromRGBO(93, 166, 172, 1),
        actions: [
          IconButton(icon:const Icon(Icons.info_outlined),onPressed: () {
                                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InstructionsPage())
                      );
                                  }),
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Sign Out') {
                  Auth().signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LoginPage())
                      );
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
        backgroundColor: Color.fromRGBO(93, 166, 172, 1),
        items: const <BottomNavigationBarItem>[
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
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}