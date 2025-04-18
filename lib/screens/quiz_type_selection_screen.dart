import 'package:flutter/material.dart';
import '../models/word_model.dart';
import 'audio_to_word_quiz_screen.dart'; // Import the audio quiz screen
import 'image_to_word_quiz_screen.dart'; // Import the image quiz screen

class QuizTypeSelectionScreen extends StatelessWidget {
  final WordCategory category;
  final String categoryDisplayName;

  const QuizTypeSelectionScreen({
    super.key,
    required this.category,
    required this.categoryDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: $categoryDisplayName'), // Show the selected category
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Choose Quiz Type:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.hearing), // Listen icon
              label: const Text('Listen & Choose Word'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AudioToWordQuizScreen(
                      category: category,
                      categoryDisplayName: categoryDisplayName,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30), // Spacing
            ElevatedButton.icon(
              icon: const Icon(Icons.image_search), // Image icon
              label: const Text('See Image & Choose Word'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageToWordQuizScreen(
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
