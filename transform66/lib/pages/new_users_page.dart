import 'package:flutter/material.dart';
import 'package:transform66/pages/edit_new_user_page.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
                child: Text(
              'Transform66',
              style: TextStyle(color: Colors.black, fontSize: 24),
            )),
            backgroundColor: Colors.teal),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    "When you click the start transform 66 button, then you are directed to customizing your task.\n\n"
                    "Choose a couple of tasks that you want to commit to for 66 days.\n\n"
                    "Remember that if you miss a day you will be taken back to day 1 so don't forget to do your task and mark it down.",
                    style: TextStyle(fontSize: 16),
                    selectionColor: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditNewUserPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Start Transform66',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'About Us',
                    )),
                onPressed: () => _showAboutDialog(context),
              )
            ]));
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
            title: Text("About Us"),
            content: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    "Transform66 is a revolutionary application designed to catalyze personal growth and habit formation with its origins rooted in the understanding that it takes approximately 66 days to solidify a new habit.\n\n"
                    "At its core, Transform66 is more than just a productivity tool—it's a companion on the journey towards self-improvement. By providing a structured platform and a nurturing community, Transform66 empowers individuals to set meaningful goals and stay committed to them over the course of 66 days.\n\n"
                    "Whether you're striving to enhance your health, develop new skills, or cultivate positive habits, Transform66 is here to support you every step of the way. Join the Transform66 community and unlock your full potential today.\n\n"
                    "Developers\n\n"
                    "Behind the scenes of Transform 66 are a team of visionary software developers: Riva Kansakar, Stuti Shrestha, Leandra Gottschalk, and Jack Brandt. With their diverse backgrounds and shared passion for personal growth, this talented group came together to bring Transform66 to life.",
                  )
                ])));
      },
    );
  }
}
