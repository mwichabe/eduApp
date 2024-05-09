import 'package:education_ar/screens/lab_details.dart';
import 'package:flutter/material.dart';

class VirtualLabsScreen extends StatelessWidget {
  const VirtualLabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Laboratories'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          LabItem(
            labName: 'Physics Lab',
            imageUrl: 'assets/physics_lab.jpg',
            onTap: () {
              // Navigate to the details page for the Physics Lab
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LabDetailsScreen(labName: 'Physics', description: 'Simple Pendulum Experiment, The Simple Pendulum Experiment is designed to help students understand the concepts of periodic motion, oscillation, and the factors affecting the period of a pendulum. This virtual lab provides an interactive simulation of a simple pendulum setup where students can change parameters and observe the effects on its motion.',)));
            },
          ),
          const SizedBox(height: 20.0),
          LabItem(
            labName: 'Chemistry Lab',
            imageUrl: 'assets/chemistry_lab.jpg',
            onTap: () {
              // Navigate to the details page for the Chemistry Lab
             Navigator.push(context, MaterialPageRoute(builder: (context)=>LabDetailsScreen(labName: 'Chemistry', description: 'The Virtual Chemistry Lab provides a simulated environment where students can perform various chemistry experiments safely and conveniently. With interactive simulations and tools, students can explore chemical reactions, analyze data, and deepen their understanding of key concepts in chemistry.',)));
            },
          ),
        ],
      ),
    );
  }
}

class LabItem extends StatelessWidget {
  final String labName;
  final String imageUrl;
  final VoidCallback onTap;

  LabItem({
    required this.labName,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imageUrl,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                labName,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
