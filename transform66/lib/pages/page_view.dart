import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/pages/add_friends_page.dart';
import 'package:transform66/pages/calendar_page.dart';
import 'package:transform66/pages/feed_page.dart';
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
          IconButton(icon:const Icon(Icons.info_outlined),onPressed: () => _showInstructions(context)
                                  ),
            IconButton(icon:const Icon(Icons.emoji_emotions_outlined),onPressed: () {
                                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddFriends())
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
      )
    );
  }
  void _showInstructions(BuildContext context) {
    showDialog(
      context:context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "1. When you click the start transform 66 button, then you are directed to customizing your task.\n\n"
                  "2. Choose a couple of tasks that you want to commit to for 66 days.\n\n"
                  "3. Remember that if you miss a day you will be taken back to day 1 so don't forget to do your task and mark it down.\n\n"
                  "4. Swipe right and you will see Feed to keep yourself updated on what tasks your friends are commiting.\n\n"
                  "5. Swipe right and you will see Calendar to view your progress. You can see what day you are on and how many days are remaining.\n\n"
                  "6. Click three dots in the top right corner to signout, it'll take you back to the login page.\n\n"
                  "7. If you click Friends icon, you will be directed to a page where you can request your friend. \n\n"
                  "8. After requesting, your friend will have a notification if they want to accept or reject the invitation.\n\n"
                  "9. If they accept the friend request, you will be able to message your friend and see them in your feed.\n\n",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              
              ],
            )),
        );
      }
    );
  }
}