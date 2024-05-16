import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/firestore_actions/info_firestore.dart';
import 'package:transform66/pages/login_register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;
  final InfoFirestoreService ifs = InfoFirestoreService();

  Future<DateTime> fetchStartDate() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(yourEmail)
        .get();
    if (snapshot.exists) {
      return (snapshot.data() as Map<String, dynamic>)['first_day'].toDate();
    } else {
      return DateTime.now();
    }
  }

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
                  userName, 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: fetchStartDate(),
                  builder:
                      (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); 
                    } else if (snapshot.hasData) {
                      String formattedDate =
                          '${snapshot.data!.month}-${snapshot.data!.day}-${snapshot.data!.year}';
                      return Text(
                        'Start Date: $formattedDate',
                        style: TextStyle(fontSize: 16),
                      ); 
                    } else {
                      return Text(
                        'No start date available',
                        style: TextStyle(fontSize: 16),
                      ); 
                    }
                  },
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
                    title: const Text("Confirm log out?",
                        style: TextStyle(fontSize: 16)),
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
                    title: const Text("Confirm delete?",
                        style: TextStyle(fontSize: 16)),
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
