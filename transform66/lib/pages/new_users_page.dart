import 'package:flutter/material.dart';
import 'package:transform66/pages/edit_new_user_page.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform66'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "1. When you click the start transform 66 button, then you are directed to customizing your task.\n\n"
                    "2. Choose a couple of tasks that you want to commit to for 66 days.\n\n"
                    "3. Remember that if you miss a day you will be taken back to day 1 so don't forget to do your task and mark it down by 11:59 pm.\n\n"
                    "4. Swipe right and you will see Feed to keep yourself updated on what tasks your friends are commiting.\n\n"
                    "5. Swipe right and you will see Calendar to view your progress. You can see what day you are on and how many days are remaining.\n\n"
                    "6. Click three dots in the top right corner to sign out, it'll take you back to the login page.\n\n"
                    "7. If you click Friends icon, you will be directed to a page where you can request your friend. \n\n"
                    "8. After requesting, your friend will have a notification if they want to accept or reject the invitation.\n\n"
                    "9. If they accept the friend request, you will be able to message your friend and see them in your feed.\n\n",
                    style: TextStyle(fontSize: 16),
                    selectionColor: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const EditNewUserPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Start Transform66',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => _showAboutDialog(context),
            child: const Text(
              'About Us',
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("About Us"),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transform 66 is a revolutionary application designed to catalyze personal growth and habit formation with its origins rooted in the understanding that it takes approximately 66 days to solidify a new habit.\n\n"
                  "At its core, Transform 66 is more than just a productivity tool—it's a companion on the journey towards self-improvement. By providing a structured platform and a nurturing community, Transform 66 empowers individuals to set meaningful goals and stay committed to them over the course of 66 days.\n\n"
                  "Whether you're striving to enhance your health, develop new skills, or cultivate positive habits, Transform 66 is here to support you every step of the way. Join the Transform 66 community and unlock your full potential today.\n\n"
                  "Developers\n\n"
                  "Behind the scenes of Transform 66 are a team of visionary software developers: Riva Kansakar, Stuti Shrestha, Leandra Gottschalk, and Jack Brandt. With their diverse backgrounds and shared passion for personal growth, this talented group came together to bring Transform 66 to life.",
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
