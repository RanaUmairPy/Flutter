import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:hive_flutter/hive_flutter.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _marksController = TextEditingController();
  String? _selectedCreditHour; // Dropdown value for credit hour

  late Box _hiveBox;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    try {
      _hiveBox = await Hive.openBox("DYNAMIC_LIST_BOX");
    } catch (e) {
      debugPrint("Error initializing Hive: $e");
    }
  }

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      final newData = {
        "name": _nameController.text,
        "coursename": _courseNameController.text,
        "credithour": _selectedCreditHour,
        "marks": _marksController.text,
      };

      // Save to API
      const url = 'https://bgnuerp.online/api/gradeapi';
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newData),
        );

        if (response.statusCode == 201) {
          // Save to Hive
          final existingData = _hiveBox.get("DYNAMIC_LIST") ?? [];
          final updatedData = List<Map<String, dynamic>>.from(existingData)..add(newData);
          await _hiveBox.put("DYNAMIC_LIST", updatedData); // Ensure data is stored in Hive

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data submitted and stored successfully!")),
          );

          // Clear the form
          _formKey.currentState!.reset();
          _nameController.clear();
          _courseNameController.clear();
          _marksController.clear();
          setState(() {
            _selectedCreditHour = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to submit data. Status code: ${response.statusCode}")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error submitting data: $e")),
        );
      }
    }
  }

  void _loadFromHive() {
    final storedData = _hiveBox.get("DYNAMIC_LIST");
    if (storedData != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data loaded from Hive successfully!")),
      );
      debugPrint("Loaded Data: $storedData");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No data available in Hive.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Data"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _loadFromHive,
            tooltip: "Load from Hive",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => value == null || value.isEmpty ? "This field is required" : null,
              ),
              TextFormField(
                controller: _courseNameController,
                decoration: const InputDecoration(labelText: "Course Name"),
                validator: (value) => value == null || value.isEmpty ? "This field is required" : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCreditHour,
                decoration: const InputDecoration(labelText: "Credit Hour"),
                items: ["1", "2", "3", "4"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCreditHour = value;
                  });
                },
                validator: (value) => value == null || value.isEmpty ? "This field is required" : null,
              ),
              TextFormField(
                controller: _marksController,
                decoration: const InputDecoration(labelText: "Marks"),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? "This field is required" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
