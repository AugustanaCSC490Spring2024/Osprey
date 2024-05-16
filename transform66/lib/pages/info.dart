import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/firestore_actions/info_firestore.dart';
import 'package:transform66/pages/login_register_page.dart';
class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;
  final InfoFirestoreService ifs = InfoFirestoreService();

  @override
  Widget build(BuildContext context) {
    // Extract name from email
    String userName = yourEmail.split('@').first;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: AssetImage("assets/images/Transform66.png"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userName, // Display user's name extracted from email
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Edit Profile"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          ProfileMenuWidget(
            title: "Log out",
            icon: Icons.logout,
            onPress: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm log out?", style: TextStyle(fontSize: 16)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () {
                          Auth().signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ProfileMenuWidget(
            title: "Delete my account",
            icon: Icons.delete,
            onPress: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm delete?", style: TextStyle(fontSize: 16)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await ifs.deleteUser();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;

  const ProfileMenuWidget({
    required this.title,
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onPress,
    );
  }
}

