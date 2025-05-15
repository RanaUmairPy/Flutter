import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'student_screen.dart';
import 'homescreen.dart'; // Make sure you have this file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Umair App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 80, 48, 135)),
        scaffoldBackgroundColor: const Color(0xFFF3F3F3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 80, 48, 135),
          elevation: 6,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFFEEE6F3),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 80, 48, 135),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Practical 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _allTexts = [];

  @override
  void initState() {
    super.initState();
    _loadTexts();
  }

  Future<void> _saveText() async {
    if (_controller.text.isNotEmpty) {
      await DBHelper.insertText(_controller.text);
      _controller.clear();
      _loadTexts();
    }
  }

  Future<void> _loadTexts() async {
    final texts = await DBHelper.getAllTexts();
    setState(() {
      _allTexts = texts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Umair App',
                applicationVersion: '1.0.0',
                children: [
                  const Text('This is a demo app for Practical 1.'),
                ],
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 80, 48, 135),
              ),
              accountName: const Text('Umair Student'),
              accountEmail: const Text('umair@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'U',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color.fromARGB(255, 80, 48, 135),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.school, color: Color.fromARGB(255, 80, 48, 135)),
              title: const Text('Students-Api'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StudentScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book, color: Color.fromARGB(255, 80, 48, 135)),
              title: const Text('Books'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BookScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter text',
                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: _saveText,
                  icon: const Icon(Icons.save),
                  label: const Text('Save to SQLite'),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: _allTexts.isEmpty
                      ? const Center(child: Text('No text saved yet.'))
                      : ListView.builder(
                          itemCount: _allTexts.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: const Color(0xFFF3F3F3),
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.note, color: Color.fromARGB(255, 80, 48, 135)),
                                title: Text(
                                  _allTexts[index],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}