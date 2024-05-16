import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/firestore_actions/info_firestore.dart';
import 'package:transform66/pages/login_register_page.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final String yourEmail = FirebaseAuth.instance.currentUser!.email!;
  final ifs = InfoFirestoreService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:Text(
              "Logged in as $yourEmail",
              style: const TextStyle(fontSize: 16)
            )
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
                        title: const Text("Confirm log out?", style: TextStyle(fontSize: 16)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No")
                          ),
                          TextButton(
                            onPressed: () {
                              Auth().signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage()
                                ),
                                (route) => false
                              );
                            },
                            child: const Text("Yes")
                          )
                        ]
                      );
                    }
                  );
                },
                child: const Text("Log out", style: TextStyle(fontSize: 16))
              ),
              const Text("|", style: TextStyle(fontSize: 16)),
              TextButton(
                onPressed: () {
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
                            child: const Text("No")
                          ),
                          TextButton(
                            onPressed: () async {
                              await ifs.deleteUser();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage()
                                ),
                                (route) => false
                              );
                            },
                            child: const Text("Yes")
                          )
                        ]
                      );
                    }
                  );
                },
                child: const Text("Delete my account", style: TextStyle(fontSize: 16))
              )
            ]
          )
        ],
      )
    );
  }
}