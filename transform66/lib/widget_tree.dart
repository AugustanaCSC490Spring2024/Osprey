
import 'package:transform66/auth.dart';
//import 'package:transform66/pages/home_page.dart';
import 'package:transform66/pages/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:transform66/pages/progress_page.dart';


class WidgetTree extends StatefulWidget{
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}


class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Auth().authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProgressPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}