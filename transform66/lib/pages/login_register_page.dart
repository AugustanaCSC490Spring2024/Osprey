import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transform66/auth.dart';
import 'package:transform66/pages/new_users_page.dart';
import 'package:transform66/pages/verify_email_page.dart';
import 'package:transform66/pages/progress_page.dart';
import 'package:transform66/pages/forgot_password.dart';
bool _isPasswordVisible = false;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool isLogin = true;

  Future<void> signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProgressPage(),
          ),
        );
      } else {
        // User's email is not verified, redirect to VerifyEmailPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyEmailPage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
    );

      String uid = userCredential.user!.uid;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyEmailPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      setState(() {
        errorMessage = e.message;
      });
    }
  }


  Widget _title() {
    return const Text('Transform66');
  }

  Widget _entryField(String title, TextEditingController controller) {
    if (title.toLowerCase() == 'password') {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          suffixIcon: IconButton(
            icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        obscureText: !_isPasswordVisible,
      );
    } else {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
        ),
      );
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Password/Username is incorrect');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register',
          style: TextStyle(color: Colors.blue.shade900)),
    );
  }

  Widget _loginOrRegisterButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(10), // Adjust the border radius as needed
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _entryField('email', _controllerEmail),
          _entryField('password', _controllerPassword),
          _errorMessage(),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _insteadButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _loginOrRegisterButton(),
                _insteadButton(),
                GestureDetector(
                child: Text( 'Forgot Password?',
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),)),
                )

              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/Transform66.png',
                height: 400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}