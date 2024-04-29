import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/pages/home_page.dart';
import 'package:transform66/pages/new_users_page.dart';
import 'package:transform66/pages/login_register_page.dart';
import 'package:transform66/pages/progress_page.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool _isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    checkEmailVerified();
    _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!_isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      print('An error occured while trying to send email verification');
      print(e);
    }
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState((){
      _isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    }
    );
    if (_isEmailVerified) timer?.cancel();
  }

    void startEmailVerificationCheck() {
    timer = Timer.periodic(
      Duration(seconds: 3), // You can adjust the interval as needed
      (_) => checkEmailVerified(),
    );
  }


  @override
  Widget build(BuildContext context) {
  return _isEmailVerified
      ? StartedPage()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(144, 195, 200, 1),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ),
          body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "A verification email has been sent to ${FirebaseAuth.instance.currentUser!.email}",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    icon: Icon(Icons.email, size: 32),
                    label: Text('Resend Email'),
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                  ),
                ],
              )));
}
}
