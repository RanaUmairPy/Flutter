import 'package:flutter/material.dart';
import 'calculator_screen.dart'; // Import the CalculatorScreen
import 'grade_screen.dart'; // Import the GradeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return MaterialApp(
      title: "Baba Guru Nanak University",
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            leading: Container(
              margin: const EdgeInsets.only(left: 10),
              //child: Image.asset('assets/bgnulogo.png'),
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
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                }
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: const Text("Calculator"),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CalculatorScreen()),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Grades"),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GradeScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/uni.jpg',
                    height: 200,
                    width: 200,
                  ),
                  const Expanded(
                    child: Text("Baba Guru Nanak University",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
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
      ),
    );
  }
}