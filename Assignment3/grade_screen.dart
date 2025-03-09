import 'package:flutter/material.dart';

class GradeScreen extends StatelessWidget {
  const GradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> students = [
      {'name': 'Ali', 'subjects': {'Math': 85, 'Science': 90, 'English': 88}},
      {'name': 'Umair', 'subjects': {'Math': 78, 'Science': 82, 'English': 80}},
      {'name': 'Hamza', 'subjects': {'Math': 92, 'Science': 88, 'English': 91}},
      {'name': 'Razwan', 'subjects': {'Math': 75, 'Science': 80, 'English': 77}},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grades"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Math')),
              DataColumn(label: Text('Science')),
              DataColumn(label: Text('English')),
            ],
            rows: students.map((student) {
              return DataRow(cells: [
                DataCell(Text(student['name'])),
                DataCell(Text(student['subjects']['Math'].toString())),
                DataCell(Text(student['subjects']['Science'].toString())),
                DataCell(Text(student['subjects']['English'].toString())),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
