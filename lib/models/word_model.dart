// Defines the structure for a vocabulary word and its categories.

enum WordCategory {
  family,
  colors,
  bodyParts,
  fruitsAndFood,
  animals,
  clothing,
  schoolSupplies,
  objectsThings,
  daysOfWeek,
  numbers,
}

class Word {
  final String germanWord;
  final String englishWord;
  final WordCategory category;
  final String imagePath; // e.g., 'assets/images/family/mutter.png'
  final String audioPath; // e.g., 'assets/audio/family/mutter.mp3'

  const Word({
    required this.germanWord,
    required this.englishWord,
    required this.category,
    required this.imagePath,
    required this.audioPath,
  });
}
