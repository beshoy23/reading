import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg
import '../models/word_model.dart';
import '../data/word_list.dart';

class FlashcardScreen extends StatefulWidget {
  final WordCategory category;
  final String categoryDisplayName;

  const FlashcardScreen({
    super.key,
    required this.category,
    required this.categoryDisplayName,
  });

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  late List<Word> _words;
  int _currentIndex = 0;
  bool _showEnglish = false;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Create an AudioPlayer instance

  @override
  void initState() {
    super.initState();
    _words = getWordsByCategory(widget.category);
    // No TTS initialization needed
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
      await _audioPlayer.play(AssetSource(assetPath));
      print('Playing: $assetPath');
    } catch (e) {
      print("Error playing audio: $e");
      // Optionally show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not play audio: $assetPath')),
      );
    }
  }

  void _goToNextWord() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _words.length;
      _showEnglish = false; // Hide English for the new word
    });
  }

  void _goToPreviousWord() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _words.length) % _words.length;
      _showEnglish = false; // Hide English for the new word
    });
  }

  void _toggleShowEnglish() {
    setState(() {
      _showEnglish = !_showEnglish;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_words.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.categoryDisplayName)),
        body: const Center(child: Text('No words found for this category.')),
      );
    }

    final currentWord = _words[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryDisplayName} Flashcards'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _toggleShowEnglish,
              child: Card(
                elevation: 4.0,
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Display the image
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: currentWord.imagePath.toLowerCase().endsWith('.svg')
                            ? SvgPicture.asset( // Use SvgPicture for .svg files
                                currentWord.imagePath,
                                placeholderBuilder: (context) => Container( // Simple placeholder during SVG load
                                  color: Colors.grey[300],
                                  child: const Center(child: CircularProgressIndicator()),
                                ),
                                fit: BoxFit.contain,
                              )
                            : Image.asset( // Use Image.asset for other types (like .png)
                                currentWord.imagePath,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  print("Error loading image ${currentWord.imagePath}: $error");
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
                      Text(
                        currentWord.germanWord,
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      // English word - shown/hidden
                      AnimatedOpacity(
                        opacity: _showEnglish ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _showEnglish ? currentWord.englishWord : '',
                          style: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Speak button
                      IconButton(
                        icon: const Icon(Icons.volume_up),
                        iconSize: 40,
                        tooltip: 'Speak German word',
                        // Pass the relative path to _playAudio
                        onPressed: () => _playAudio(currentWord.audioPath.replaceFirst('assets/', '')),
                      ),
                      if (!_showEnglish) // Hint to tap
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text('(Tap card to reveal English)', style: TextStyle(color: Colors.grey)),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Navigation controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                  onPressed: _goToPreviousWord,
                ),
                Text('${_currentIndex + 1} / ${_words.length}'),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                  onPressed: _goToNextWord,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
