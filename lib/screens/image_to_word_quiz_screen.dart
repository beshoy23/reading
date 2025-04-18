import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg
import '../models/word_model.dart';
import '../data/word_list.dart';
import 'results_screen.dart';

class ImageToWordQuizScreen extends StatefulWidget {
  final WordCategory category;
  final String categoryDisplayName;

  const ImageToWordQuizScreen({
    super.key,
    required this.category,
    required this.categoryDisplayName,
  });

  @override
  State<ImageToWordQuizScreen> createState() => _ImageToWordQuizScreenState();
}

class _ImageToWordQuizScreenState extends State<ImageToWordQuizScreen> {
  late List<Word> _wordsInCategory;
  late Word _currentWord;
  late List<String> _options;
  int _score = 0;
  int _questionNumber = 1;
  final int _totalQuestions = 5; // Same number of questions
  bool _answered = false;
  bool? _isCorrect;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _wordsInCategory = getWordsByCategory(widget.category);
    // Filter out words that might be missing image paths if necessary
    _wordsInCategory.removeWhere((word) => word.imagePath.isEmpty);
    _setupQuestion();
  }

  void _setupQuestion() {
    // Ensure there are enough words with images for options
    if (_wordsInCategory.length < 4) {
      // Handle cases with fewer than 4 words with images
      _wordsInCategory.shuffle();
    }
     if (_wordsInCategory.isEmpty) {
       // Handle case where no words with images exist for the category
       print("Error: No words with images found for category ${widget.categoryDisplayName}");
       // Potentially show an error message to the user or disable the quiz
       return;
     }


    // Select a random word for the question
    _currentWord = _wordsInCategory[_random.nextInt(_wordsInCategory.length)];

    // Generate options (1 correct, 3 incorrect)
    _options = [_currentWord.germanWord];
    List<Word> otherWords = _wordsInCategory.where((word) => word.germanWord != _currentWord.germanWord).toList();
    otherWords.shuffle();
    int optionsNeeded = 3;
    for (int i = 0; i < min(optionsNeeded, otherWords.length); i++) {
      _options.add(otherWords[i].germanWord);
    }
    // Pad if necessary
    while (_options.length < 4 && _wordsInCategory.isNotEmpty) {
       _options.add(_wordsInCategory[_random.nextInt(_wordsInCategory.length)].germanWord);
       _options = _options.toSet().toList(); // Basic de-duplication
    }
     while (_options.length < 4 && _wordsInCategory.isNotEmpty) {
       _options.add(_wordsInCategory[_random.nextInt(_wordsInCategory.length)].germanWord);
    }
    _options.shuffle();

    _answered = false;
    _isCorrect = null;

     // Trigger rebuild
     if (mounted) {
       setState(() {});
     }
  }

  void _checkAnswer(String selectedOption) {
    if (_answered) return;

    setState(() {
      _answered = true;
      _isCorrect = (selectedOption == _currentWord.germanWord);
      if (_isCorrect!) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (_questionNumber < _totalQuestions) {
        setState(() {
          _questionNumber++;
          _setupQuestion();
        });
      } else {
        // Navigate to ResultsScreen
        Navigator.pushReplacement( // Use pushReplacement to prevent going back to the quiz
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              score: _score,
              totalQuestions: _totalQuestions,
              categoryDisplayName: widget.categoryDisplayName,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     if (_wordsInCategory.isEmpty) {
       return Scaffold(
         appBar: AppBar(title: Text('Quiz: ${widget.categoryDisplayName}')),
         body: const Center(child: Text('Not enough words with images in this category for a quiz.')),
       );
     }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${widget.categoryDisplayName}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Question $_questionNumber / $_totalQuestions | Score: $_score',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Look at the image and choose the correct word:',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Display the image
            SizedBox(
              height: 150,
              width: 150,
              child: _currentWord.imagePath.toLowerCase().endsWith('.svg')
                  ? SvgPicture.asset( // Use SvgPicture for .svg files
                      _currentWord.imagePath,
                      placeholderBuilder: (context) => Container( // Simple placeholder during SVG load
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      fit: BoxFit.contain,
                    )
                  : Image.asset( // Use Image.asset for other types (like .png)
                      _currentWord.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        print("Error loading image ${_currentWord.imagePath}: $error");
                        // Fallback to SVG placeholder if raster image fails
                        return SvgPicture.asset(
                           'assets/images/placeholder.svg',
                           fit: BoxFit.contain,
                        );
                      },
                      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          return child;
                        }
                        return AnimatedOpacity(
                          opacity: frame == null ? 0 : 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOut,
                          child: child,
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            // Options
            ..._options.map((option) {
               Color? buttonColor;
               if (_answered) {
                 if (option == _currentWord.germanWord) {
                   buttonColor = Colors.green.shade300;
                 }
                 // Add logic here later to color the wrongly selected button red if needed
               }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                     backgroundColor: buttonColor,
                     disabledBackgroundColor: buttonColor?.withOpacity(0.7),
                  ),
                  onPressed: _answered ? null : () => _checkAnswer(option),
                  child: Text(option, style: const TextStyle(fontSize: 18)),
                ),
              );
            }),
             const SizedBox(height: 20),
             // Feedback Area
             if (_answered)
               Text(
                 _isCorrect! ? 'Correct!' : 'Incorrect! The answer was: ${_currentWord.germanWord}',
                 style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                   color: _isCorrect! ? Colors.green : Colors.red,
                 ),
               ),
          ],
        ),
      ),
    );
  }
}
