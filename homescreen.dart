import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: Image.asset('Assests/OIP.jpg', fit: BoxFit.contain),
            ),
            const SizedBox(height: 20),
            const Text(
              'Book Name: Flutter Mobile Development',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Teacher: Sir Nabeel',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Credit Hours: 3',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}