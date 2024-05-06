import 'package:flutter/material.dart';
import 'package:transform66/pages/edit_new_user_page.dart';
import 'package:transform66/pages/testimonials_page.dart';


class StartedPage extends StatelessWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform66'),
        backgroundColor: Colors.teal
      ),
      body: Align(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 100,
              child: ElevatedButton(
                onPressed: () {Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EditNewUserPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              child: const Text(
                'Start Transform66',
                style: TextStyle(color: Colors.black, fontSize: 16), // Change color to black
            ),
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("About Us"),
                          content: const SingleChildScrollView(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Transform 66 is a revolutionary application designed to catalyze personal growth and habit formation. With its origins rooted in the understanding that it takes approximately 66 days to solidify a new habit, Transform 66 is engineered to guide users through this critical period with precision and support.\n\n"
                                "At its core, Transform 66 is more than just a productivity tool—it's a companion on the journey towards self-improvement. By providing a structured platform and a nurturing community, Transform 66 empowers individuals to set meaningful goals and stay committed to them over the course of 66 days, thereby laying the foundation for lasting change.\n\n"
                                "Whether you're striving to enhance your health, develop new skills, or cultivate positive habits, Transform 66 is here to support you every step of the way. Join the Transform 66 community and unlock your full potential today.\n\n"
                                "Developers\n\n"
                                "Behind the scenes of Transform 66 are a team of visionary software developers: Riva Kansakar, Stuti Shrestha, Leandra Gottschalk, and Jack Brandt. With their diverse backgrounds and shared passion for personal growth, this talented group came together to bring Transform 66 to life."
                              ),
                            ],
                          ),),
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
                  },
                  child: const Text(
                    'About Us' // Change color to black
                  ),
                ),
                const Text("|"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Testimonials(),
                      ),
                    );
                  },
                  child: const Text(
                    'Testimonials'
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
  );
  }
}