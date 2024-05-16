import 'package:flutter/material.dart';
import 'package:transform66/pages/edit_new_user_page.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Transform66')),
        backgroundColor: Colors.teal,
      ),
      body: Center(child:SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "When you click the start Transform66 button, you are directed to customizing your tasks.\n\n"
                "Choose a couple of tasks that you want to commit to for 66 days.\n\n"
                "Remember that if you miss a day you will be taken back to day 1, so don't forget to do your tasks and mark them down by 11:59 pm.\n"
                //"4. Swipe right and you will see Feed to keep yourself updated on what tasks your friends are commiting.\n\n"
                //"5. Swipe right and you will see Calendar to view your progress. You can see what day you are on and how many days are remaining.\n\n"
                //"6. Click three dots in the top right corner to sign out, it'll take you back to the login page.\n\n"
                //"7. If you click Friends icon, you will be directed to a page where you can request your friend. \n\n"
                //"8. After requesting, your friend will have a notification if they want to accept or reject the invitation.\n\n"
                //"9. If they accept the friend request, you will be able to message your friend and see them in your feed.\n\n",
                ,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
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
                )
              )
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _showAboutDialog(context),
              child: const Text("About Us")
            ),
            const SizedBox(height: 20)
          ]
        )
      )
    ));
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
                const Text(
                  "\n\nImage credits\n"
                  "The images used in this application are from the following sources:\n"
                  "Photo by Nik on Unsplash, Photo by Cristofer Maximilian on Unsplash, Photo by Fab Lentz on Unsplash, " 
                  "Photo by Mika Baumeister on Unsplash, Photo by Randy Tarampi on Unsplash, Photo by Drew Beamer on Unsplash, "
                  "Photo by Olena Bohovyk on Unsplash, Photo by Prateek Katyal on Unsplash, Photo by Nathan Dumlao on Unsplash, "
                  "Photo by Manasvita S on Unsplash, Photo by Aman Upadhyay on Unsplash, Photo by Brigitte Tohm on Unsplash, "
                  "Photo by Jason Dent on Unsplash, Photo by Ray Hennessy on Unsplash, Photo by Patti Black on Unsplash, "
                  "Photo by Kier in Sight Archives on Unsplash, Photo by Georgia de Lotz on Unsplash, Photo by Ethan Hoover on Unsplash, "
                  "Photo by Luca Upper on Unsplash, Photo by Austin Park on Unsplash, Photo by Let's go Together on Unsplash, "
                  "Photo by Jason Leung on Unsplash",
                ),
                const SizedBox(height: 10),
              ],
            ),
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

Widget _buildDeveloperInfo(String imagePath, String name, String description) {
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