import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:hive_flutter/hive_flutter.dart';

class DynamicListView extends StatefulWidget {
  const DynamicListView({super.key});

  @override
  State<DynamicListView> createState() => _DynamicListViewState();
}

class _DynamicListViewState extends State<DynamicListView> {
  List<Map<String, dynamic>> dataList = []; // List to store fetched data
  late Box _hiveBox; // Hive box for storing data
  bool isLoading = false; // Loading state
  String errorMessage = ''; // To store error messages

  @override
  void initState() {
    super.initState();
    _initializeHive(); // Initialize Hive
  }

  Future<void> _initializeHive() async {
    try {
      _hiveBox = await Hive.openBox("DYNAMIC_LIST_BOX");
    } catch (e) {
      debugPrint("Error initializing Hive: $e");
    }
  }

  Future<void> fetchData() async {
    const url = 'https://bgnuerp.online/api/gradeapi'; // API endpoint
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body) as List<dynamic>; // Decode JSON response
        setState(() {
          dataList = decodedData.map((item) => Map<String, dynamic>.from(item)).toList();
          isLoading = false;
        });
        // Store data in Hive
        _hiveBox.put("DYNAMIC_LIST", dataList);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data fetched and stored in Hive successfully!")),
        );
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching data: $e';
      });
    }
  }

  void loadFromHive() {
    final storedData = _hiveBox.get("DYNAMIC_LIST");
    if (storedData != null) {
      setState(() {
        dataList = List<Map<String, dynamic>>.from(storedData);
        errorMessage = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data loaded from Hive successfully!")),
      );
    } else {
      setState(() {
        errorMessage = 'No data available in Hive.';
      });
    }
  }

  void storeInHive() {
    try {
      if (dataList.isNotEmpty) {
        _hiveBox.put("DYNAMIC_LIST", dataList); // Store data in Hive
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data stored in Hive successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No data to store in Hive.")),
        );
      }
    } catch (e) {
      debugPrint("Error storing data in Hive: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic ListView'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_download, color: Colors.black), // Set icon color to black
            onPressed: fetchData,
            tooltip: "Fetch from API",
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Colors.black), // Set icon color to black
            onPressed: loadFromHive,
            tooltip: "Load from Hive",
          ),
          IconButton(
            icon: const Icon(Icons.save, color: Colors.black), // Set icon color to black
            onPressed: storeInHive,
            tooltip: "Store in Hive",
          ),
        ],
        backgroundColor: Colors.white, // Set AppBar background color to white for contrast
        iconTheme: const IconThemeData(color: Colors.black), // Ensure all icons in the AppBar are black
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final item = dataList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Name:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(item['studentname'] ?? 'N/A'),
                          ),
                          const SizedBox(height: 10),
                          item['image'] != null && item['image'].isNotEmpty
                              ? Image.network(
                                  item['image'],
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.broken_image,
                                      size: 100,
                                      color: Colors.grey,
                                    );
                                  },
                                )
                              : const Icon(
                                  Icons.image_not_supported,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}