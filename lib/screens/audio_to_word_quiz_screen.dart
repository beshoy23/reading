import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // Import audioplayers
import '../models/word_model.dart';
import '../data/word_list.dart'; // To access getWordsByCategory
import 'results_screen.dart'; // Import the results screen

class AudioToWordQuizScreen extends StatefulWidget {
  final WordCategory category;
  final String categoryDisplayName;

  const AudioToWordQuizScreen({
    super.key,
    required this.category,
    required this.categoryDisplayName,
  });

  @override
  State<AudioToWordQuizScreen> createState() => _AudioToWordQuizScreenState();
}

class _AudioToWordQuizScreenState extends State<AudioToWordQuizScreen> {
  late List<Word> _wordsInCategory;
  late Word _currentWord;
  late List<String> _options;
  int _score = 0;
  int _questionNumber = 1; // Start from question 1
  final int _totalQuestions = 5; // Let's start with 5 questions per quiz
  bool _answered = false; // To track if the current question has been answered
  bool? _isCorrect; // To store if the answer was correct

  final AudioPlayer _audioPlayer =
      AudioPlayer(); // Create an AudioPlayer instance
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _wordsInCategory = getWordsByCategory(widget.category);
    // No TTS initialization needed
    _setupQuestion();
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the player
    super.dispose();
  }

  // Method to play audio from asset path
  Future<void> _playAudio(String assetPath) async { // assetPath is relative here
    try {
      // Stop any previous playback before starting new one
      await _audioPlayer.stop();
      // Set player mode to low latency (might help with asset loading)
      await _audioPlayer.setPlayerMode(PlayerMode.lowLatency);
      await _audioPlayer.play(
        AssetSource(assetPath),
      );
      print('Playing: $assetPath');
    } catch (e) {
      print("Error playing audio: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not play audio: $assetPath')),
        );
      }
    }
  }

  void _setupQuestion() {
    // Ensure there are enough words for options
    if (_wordsInCategory.length < 4) {
      // Handle cases with fewer than 4 words (e.g., show error or disable quiz)
      // For now, we'll just use the available words, duplicates might occur in options
      _wordsInCategory.shuffle(); // Shuffle to get random words
    }

    // Select a random word for the question
    _currentWord = _wordsInCategory[_random.nextInt(_wordsInCategory.length)];

    // Generate options (1 correct, 3 incorrect)
    _options = [_currentWord.germanWord];
    List<Word> otherWords =
        _wordsInCategory
            .where((word) => word.germanWord != _currentWord.germanWord)
            .toList();
    otherWords.shuffle();
    int optionsNeeded = 3; // Need 3 more options
    for (int i = 0; i < min(optionsNeeded, otherWords.length); i++) {
      _options.add(otherWords[i].germanWord);
    }
    // If not enough unique words, add duplicates (less ideal)
    while (_options.length < 4 && _wordsInCategory.isNotEmpty) {
      _options.add(
        _wordsInCategory[_random.nextInt(_wordsInCategory.length)].germanWord,
      );
      // Basic de-duplication
      _options = _options.toSet().toList();
    }
    // Ensure exactly 4 options if possible, pad if necessary
    while (_options.length < 4 && _wordsInCategory.isNotEmpty) {
      _options.add(
        _wordsInCategory[_random.nextInt(_wordsInCategory.length)].germanWord,
      );
    }
    _options.shuffle(); // Shuffle the final options

    _answered = false;
    _isCorrect = null;

    // Play the audio for the new word automatically
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Pass the relative path to _playAudio
        _playAudio(_currentWord.audioPath.replaceFirst('assets/', ''));
      });
    }
  }

  void _checkAnswer(String selectedOption) {
    if (_answered) return; // Prevent multiple answers

    setState(() {
      _answered = true;
      _isCorrect = (selectedOption == _currentWord.germanWord);
      if (_isCorrect!) {
        _score++;
      }
    });

    // Wait a moment, then move to the next question or results
    Future.delayed(const Duration(seconds: 2), () {
      if (_questionNumber < _totalQuestions) {
        setState(() {
          _questionNumber++;
          _setupQuestion();
        });
      } else {
        // Navigate to ResultsScreen
        Navigator.pushReplacement(
          // Use pushReplacement to prevent going back to the quiz
          context,
          MaterialPageRoute(
            builder:
                (context) => ResultsScreen(
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
    // Handle case where category might not have enough words
    if (_wordsInCategory.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Quiz: ${widget.categoryDisplayName}')),
        body: const Center(
          child: Text('Not enough words in this category for a quiz.'),
        ),
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
              'Listen and choose the correct word:',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Speak button
            IconButton(
              icon: const Icon(Icons.volume_up),
              iconSize: 60,
              tooltip: 'Listen again',
              // Pass the relative path to _playAudio
              onPressed: () => _playAudio(_currentWord.audioPath.replaceFirst('assets/', '')),
            ),
            const SizedBox(height: 40),
            // Options
            ..._options.map((option) {
              Color? buttonColor;
              if (_answered) {
                if (option == _currentWord.germanWord) {
                  buttonColor = Colors.green.shade300; // Correct answer
                } else if (option == _currentWord.germanWord && !_isCorrect!) {
                  // This case shouldn't happen with current logic, but safety
                  buttonColor = Colors.green.shade300;
                } else if (option != _currentWord.germanWord &&
                    _isCorrect == false &&
                    option == /* user's wrong selection - need to track this */
                        null) {
                  // We need to track which wrong button was pressed to color it red
                  // For now, only highlighting correct one green
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 40.0,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ), // Full width buttons
                    backgroundColor: buttonColor,
                    disabledBackgroundColor: buttonColor?.withOpacity(
                      0.7,
                    ), // Keep color when disabled
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
                _isCorrect!
                    ? 'Correct!'
                    : 'Incorrect! The answer was: ${_currentWord.germanWord}',
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
