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
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Image.asset('assets/bgnulogo.png'),
          ),
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
              icon: const Icon(Icons.menu),
              onPressed: () {}
            )
          
          
        ],
          
        ),

        body: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/uni.jpg',
                height: 200,
                width: 200,
                ),
                const Text("Baba Guru Nanak University",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                ),
                
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text("Baba Guru Nanak University (BGNU) is a Public sector university located in District Nankana Sahib, in the Punjab region of Pakistan. It plans to facilitate between 10,000 to 15,000 students from all over the world at the university. The foundation stone of the university was laid on October 28, 2019 ahead of 550th of Guru Nanak Gurpurab by the Prime Minister of Pakistan. On July, 02, 2020 Government of Punjab has formally passed Baba Guru Nanak University Nankana Sahib Act 2020 (X of 2020).",
              style: TextStyle(
                fontSize: 16,
              ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFE5E5E5),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 85, 150, 207),
          child: Container(
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              "© 2023 Baba Guru Nanak University",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
