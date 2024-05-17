import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/firestore_actions/info_firestore.dart';
import 'package:transform66/pages/login_register.dart';

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
      return (snapshot.data() as Map<String, dynamic>)['firstDay'].toDate();
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors
                          .teal, // Set the background color for the circle
                    ),
                    child: Center(
                      child: Text(
                        userName
                            .substring(0, 1)
                            .toUpperCase(), // Get the first initial and capitalize it
                        style: TextStyle(
                          fontSize: 48, // Adjust the font size as needed
                          color: Colors.white, // Set the text color to white
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userName, 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: fetchStartDate(),
                  builder:
                      (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); 
                    } else if (snapshot.hasData) {
                      String formattedDate =
                          '${snapshot.data!.month}-${snapshot.data!.day}-${snapshot.data!.year}';
                      return Text(
                        'Start Date: $formattedDate',
                        style: const TextStyle(fontSize: 16),
                      ); 
                    } else {
                      return const Text(
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
            title: "Notification settings",
            icon: Icons.circle_notifications_outlined,
            onPress: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Receive emails?",
                        style: TextStyle(fontSize: 16)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Yes"),
                      )
                    ]
                  );
                }
              );
            }
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
                          try {
                          await ifs.deleteUser();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                          }
                          on Exception catch (_) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  content: Text(
                                    "Recent sign in required. Please sign out and sign back in to delete your account.",
                                    textAlign:TextAlign.center,
                                    style: TextStyle(fontSize: 16)
                                  )
                                );
                              }
                            );
                          }
                        },
                        child: const Text("Yes")
                      )
                    ]
                  );
                }
              );
            }
          ),
          const SizedBox(height: 20)
        ]
      )
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
