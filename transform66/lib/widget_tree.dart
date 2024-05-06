
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/pages/login_register_page.dart';


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
          
            return const LoginPage();
          
        },
      ),
    );
  }
}