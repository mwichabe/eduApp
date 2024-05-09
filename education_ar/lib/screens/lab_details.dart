import 'package:flutter/material.dart';

class LabDetailsScreen extends StatelessWidget {
  final String labName;
  final String description;

  const LabDetailsScreen({
    super.key,
    required this.labName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          labName,
          style: const TextStyle(
            fontFamily: 'Roboto', 
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue, 
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'This is a detailed description of the $labName virtual laboratory. $description',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black87, 
              ),
            ),
          
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Back home',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
