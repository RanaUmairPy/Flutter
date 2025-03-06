import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Baba Guru Nanak University",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Baba Guru Nanak University",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            
            
          )),
          backgroundColor: const Color.fromARGB(255, 85, 150, 207),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu_book),
              onPressed: () {}
            )
          ],
        ),
        body: Row(
          children: [
            Image.asset('assets/uni.jpg',
            height: 300,
            width: 300,
            ),
            const Text("Baba Guru Nanak University",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            ),
            
          ],
        ),
        
      )
    );
  }
}
