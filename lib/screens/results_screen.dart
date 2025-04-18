import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String categoryDisplayName;

  const ResultsScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.categoryDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = totalQuestions > 0 ? (score / totalQuestions) * 100 : 0;
    String message;
    IconData icon;

    if (percentage >= 80) {
      message = 'Excellent!';
      icon = Icons.star;
    } else if (percentage >= 50) {
      message = 'Good Job!';
      icon = Icons.thumb_up;
    } else {
      message = 'Keep Practicing!';
      icon = Icons.sentiment_neutral;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results: $categoryDisplayName'),
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You scored',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              '$score / $totalQuestions',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Icon(icon, size: 80, color: Theme.of(context).primaryColor),
            const SizedBox(height: 10),
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Pop back to the category selection screen
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                 textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Play Again or Choose Category'),
            ),
          ],
        ),
      ),
    );
  }
}
