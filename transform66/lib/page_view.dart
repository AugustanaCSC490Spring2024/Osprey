import 'package:flutter/material.dart';
import 'package:transform66/pages/calendar_page.dart';
import 'package:transform66/pages/feed_page.dart';
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
        duration: Duration(milliseconds: 300),
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
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Colors.teal,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
