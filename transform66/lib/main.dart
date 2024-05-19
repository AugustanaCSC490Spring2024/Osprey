import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/pages/login_register.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromRGBO(144, 195, 200, 1)),
        home: Scaffold(
          body: StreamBuilder(
            stream: Auth().authStateChanges(),
            builder: (context, snapshot) {
              return const LoginPage();
            },
          ),
        ));
  }
}
