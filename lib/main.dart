import 'package:flutter/material.dart';
import 'models/word_model.dart'; // Import the model
import 'screens/mode_selection_screen.dart'; // Import the mode selection screen

void main() {
  runApp(const GermanApp());
}

class GermanApp extends StatelessWidget {
  const GermanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'German Learning for Kids',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Basic theme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CategorySelectionScreen(), // Start with category selection
    );
  }
}

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  // Helper to get a display-friendly name from the enum
  String _getCategoryDisplayName(WordCategory category) {
    switch (category) {
      case WordCategory.family:
        return 'Family';
      case WordCategory.colors:
        return 'Colors';
      case WordCategory.bodyParts:
        return 'Body Parts';
      case WordCategory.fruitsAndFood:
        return 'Fruits and Food';
      case WordCategory.animals:
        return 'Animals';
      case WordCategory.clothing:
        return 'Clothing';
      case WordCategory.schoolSupplies:
        return 'School Supplies';
      case WordCategory.objectsThings:
        return 'Objects/Things';
      case WordCategory.daysOfWeek:
        return 'Days of the Week';
      case WordCategory.numbers:
        return 'Numbers';
      default:
        return 'Unknown Category';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get all category enum values
    final categories = WordCategory.values;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Category'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final displayName = _getCategoryDisplayName(category);
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(displayName, style: const TextStyle(fontSize: 18)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModeSelectionScreen(
                      category: category,
                      categoryDisplayName: displayName,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
