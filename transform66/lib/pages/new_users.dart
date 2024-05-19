import 'package:flutter/material.dart';
import 'package:transform66/pages/edit_new_users.dart';

class NewUsersPage extends StatelessWidget {
  const NewUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                height: 450,
                width: 375,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text("Instructions",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  const SizedBox(height: 20),
                  const Text(
                      "Click the Start Transform66 button to choose your tasks that you want to commit for 66 days. You can also custom tasks and add it to your list.\n\nRemember that if you miss a day you will be taken back to day 1, so don't forget to do your tasks and mark them done by 11:59 pm.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 35),
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
                          )),
                      child: const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text('Start Transform66',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16)))),
                  const SizedBox(height: 25),
                  TextButton(
                      onPressed: () => _showAboutDialog(context),
                      child: const Text("About Us",
                          style: TextStyle(color: Colors.black)))
                ]))))));
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("About Us"),
          content: SizedBox(
            // Set a fixed height to make the content scrollable if it exceeds this height
            height: MediaQuery.of(context).size.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Transform 66 is a revolutionary application designed to catalyze personal growth and habit formation with its origins rooted in the understanding that it takes approximately 66 days to solidify a new habit.\n\n"
                    "At its core, Transform 66 is more than just a productivity tool—it's a companion on the journey towards self-improvement. By providing a structured platform and a nurturing community, Transform 66 empowers individuals to set meaningful goals and stay committed to them over the course of 66 days.\n\n"
                    "Whether you're striving to enhance your health, develop new skills, or cultivate positive habits, Transform 66 is here to support you every step of the way. Join the Transform 66 community and unlock your full potential today.\n\n"
                    "Developers\n\n",
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDeveloperInfo(
                          'assets/images/Riva.jpg',
                          'Riva Kansakar',
                          'Riva Kansakar is a computer science and business administration major.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildDeveloperInfo(
                          'assets/images/Stuti.jpg',
                          'Stuti Shrestha',
                          'Stuti Shrestha is a computer science, data science and data analytics major.',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDeveloperInfo(
                          'assets/images/Jack.jpg',
                          'Jack Brandt',
                          'Jack Brandt is a computer science and German major.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildDeveloperInfo(
                          'assets/images/Leandra.jpg',
                          'Leandra Gottschalk',
                          'Leandra Gottschalk is a computer science and data analytics major.',
                        ),
                      ),
                    ],
                  ),
                  const Text("\n\nImage credits",
                      style: TextStyle(fontSize: 12)),
                  const Text(
                    "The images used in this application are from the following sources:\n"
                    "Photo by Nik on Unsplash, Photo by Cristofer Maximilian on Unsplash, Photo by Fab Lentz on Unsplash, "
                    "Photo by Mika Baumeister on Unsplash, Photo by Randy Tarampi on Unsplash, Photo by Drew Beamer on Unsplash, "
                    "Photo by Olena Bohovyk on Unsplash, Photo by Prateek Katyal on Unsplash, Photo by Nathan Dumlao on Unsplash, "
                    "Photo by Manasvita S on Unsplash, Photo by Aman Upadhyay on Unsplash, Photo by Brigitte Tohm on Unsplash, "
                    "Photo by Jason Dent on Unsplash, Photo by Ray Hennessy on Unsplash, Photo by Patti Black on Unsplash, "
                    "Photo by Kier in Sight Archives on Unsplash, Photo by Georgia de Lotz on Unsplash, Photo by Ethan Hoover on Unsplash, "
                    "Photo by Luca Upper on Unsplash, Photo by Austin Park on Unsplash, Photo by Let's go Together on Unsplash, "
                    "Photo by Jason Leung on Unsplash",
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeveloperInfo(
      String imagePath, String name, String description) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
