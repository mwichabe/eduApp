import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Virtual Laboratories'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/lab_icon.jpg',
              width: 150.0,
              height: 150.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Welcome to Virtual Laboratories!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the virtual labs section
                Navigator.pushNamed(context, '/virtual_labs');
              },
              child: const Text('Explore Virtual Labs'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const Text('My Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
