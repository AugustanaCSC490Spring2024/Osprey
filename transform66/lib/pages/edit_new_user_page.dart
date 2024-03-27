import 'package:flutter/material.dart';

class EditNewUserPage extends StatelessWidget {
  const EditNewUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit New User'),
      ),
      body: const Center(
        child: Text('This is the Edit New User Page'),
      ),
    );
  }
}
