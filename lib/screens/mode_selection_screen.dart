import 'package:flutter/material.dart';
import '../models/word_model.dart';
import 'flashcard_screen.dart'; // Import the flashcard screen
import 'quiz_type_selection_screen.dart'; // Import the quiz type selection screen

class ModeSelectionScreen extends StatelessWidget {
  final WordCategory category;
  final String categoryDisplayName;

  const ModeSelectionScreen({
    super.key,
    required this.category,
    required this.categoryDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryDisplayName), // Show the selected category name
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              icon: const Icon(Icons.style), // Flashcard icon
              label: const Text('Learn with Flashcards'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlashcardScreen(
                      category: category,
                      categoryDisplayName: categoryDisplayName,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30), // Spacing
            ElevatedButton.icon(
              icon: const Icon(Icons.quiz), // Quiz icon
              label: const Text('Take a Quiz'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizTypeSelectionScreen(
                      category: category,
                      categoryDisplayName: categoryDisplayName,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
