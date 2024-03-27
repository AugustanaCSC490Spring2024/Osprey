import 'package:flutter/material.dart';

class EditNewUserPage extends StatelessWidget {
  const EditNewUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform66'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          ),
        backgroundColor: Colors.teal,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 350, 
              height: 500, 
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              child: const Text(
                'Drink 1 gallon of Water',
                style: TextStyle(color: Colors.black), // Change color to black
            ),
            ),
            ),
                TextButton(
                  onPressed: () {
                  },
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.black, decoration: TextDecoration.underline), // Change color to black
                  ),
                ),
              ],
            ),
        ),
      );
  }
}
