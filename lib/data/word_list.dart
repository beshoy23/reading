import '../models/word_model.dart';

// The master list of German words for the app.
// Note: Image paths are placeholders and assume images exist at these locations.
final List<Word> germanWords = [
  // Family
  const Word(germanWord: 'Mutter', englishWord: 'Mother', category: WordCategory.family, imagePath: 'assets/images/family/mutter.png', audioPath: 'assets/audio/family/mutter.mp3'),
  const Word(germanWord: 'Vater', englishWord: 'Father', category: WordCategory.family, imagePath: 'assets/images/family/vater.png', audioPath: 'assets/audio/family/vater.mp3'),
  const Word(germanWord: 'Oma', englishWord: 'Grandma', category: WordCategory.family, imagePath: 'assets/images/family/oma.png', audioPath: 'assets/audio/family/oma.mp3'),
  const Word(germanWord: 'Opa', englishWord: 'Grandpa', category: WordCategory.family, imagePath: 'assets/images/family/opa.png', audioPath: 'assets/audio/family/opa.mp3'),
  const Word(germanWord: 'Bruder', englishWord: 'Brother', category: WordCategory.family, imagePath: 'assets/images/family/bruder.png', audioPath: 'assets/audio/family/bruder.mp3'),
  const Word(germanWord: 'Schwester', englishWord: 'Sister', category: WordCategory.family, imagePath: 'assets/images/family/schwester.png', audioPath: 'assets/audio/family/schwester.mp3'),
  const Word(germanWord: 'Onkel', englishWord: 'Uncle', category: WordCategory.family, imagePath: 'assets/images/family/onkel.png', audioPath: 'assets/audio/family/onkel.mp3'),
  const Word(germanWord: 'Junge', englishWord: 'Boy', category: WordCategory.family, imagePath: 'assets/images/family/junge.png', audioPath: 'assets/audio/family/junge.mp3'),

  // Colors
  const Word(germanWord: 'gelb', englishWord: 'yellow', category: WordCategory.colors, imagePath: 'assets/images/colors/gelb.png', audioPath: 'assets/audio/colors/gelb.mp3'),
  const Word(germanWord: 'blau', englishWord: 'blue', category: WordCategory.colors, imagePath: 'assets/images/colors/blau.png', audioPath: 'assets/audio/colors/blau.mp3'),
  const Word(germanWord: 'rot', englishWord: 'red', category: WordCategory.colors, imagePath: 'assets/images/colors/rot.png', audioPath: 'assets/audio/colors/rot.mp3'),
  const Word(germanWord: 'grün', englishWord: 'green', category: WordCategory.colors, imagePath: 'assets/images/colors/grun.png', audioPath: 'assets/audio/colors/gruen.mp3'), // Using 'grun' for image filename
  const Word(germanWord: 'schwarz', englishWord: 'black', category: WordCategory.colors, imagePath: 'assets/images/colors/schwarz.png', audioPath: 'assets/audio/colors/schwarz.mp3'),
  const Word(germanWord: 'weiß', englishWord: 'white', category: WordCategory.colors, imagePath: 'assets/images/colors/weiss.png', audioPath: 'assets/audio/colors/weiss.mp3'), // Using 'weiss' for image filename
  const Word(germanWord: 'orange', englishWord: 'orange', category: WordCategory.colors, imagePath: 'assets/images/colors/orange.png', audioPath: 'assets/audio/colors/orange.mp3'),
  const Word(germanWord: 'rosa', englishWord: 'pink', category: WordCategory.colors, imagePath: 'assets/images/colors/rosa.png', audioPath: 'assets/audio/colors/rosa.mp3'),

  // Body Parts
  const Word(germanWord: 'Arm', englishWord: 'arm', category: WordCategory.bodyParts, imagePath: 'assets/images/bodyparts/arm.png', audioPath: 'assets/audio/bodyparts/arm.mp3'),
  const Word(germanWord: 'Bein', englishWord: 'leg', category: WordCategory.bodyParts, imagePath: 'assets/images/bodyparts/bein.png', audioPath: 'assets/audio/bodyparts/bein.mp3'),
  const Word(germanWord: 'Fuß', englishWord: 'foot', category: WordCategory.bodyParts, imagePath: 'assets/images/bodyparts/fuss.png', audioPath: 'assets/audio/bodyparts/fuss.mp3'), // Using 'fuss' for image filename
  const Word(germanWord: 'Ohr', englishWord: 'ear', category: WordCategory.bodyParts, imagePath: 'assets/images/bodyparts/ohr.png', audioPath: 'assets/audio/bodyparts/ohr.mp3'),
  const Word(germanWord: 'Auge', englishWord: 'eye', category: WordCategory.bodyParts, imagePath: 'assets/images/bodyparts/auge.png', audioPath: 'assets/audio/bodyparts/auge.mp3'),
  const Word(germanWord: 'Nase', englishWord: 'nose', category: WordCategory.bodyParts, imagePath: 'assets/images/bodyparts/nase.png', audioPath: 'assets/audio/bodyparts/nase.mp3'),
  const Word(germanWord: 'Mund', englishWord: 'mouth', category: WordCategory.bodyParts, imagePath: 'assets/images/bodyparts/mund.png', audioPath: 'assets/audio/bodyparts/mund.mp3'),
  const Word(germanWord: 'Hand', englishWord: 'hand', category: WordCategory.bodyParts, imagePath: 'assets/images/bodyparts/hand.png', audioPath: 'assets/audio/bodyparts/hand.mp3'),

  // Fruits and Food
  const Word(germanWord: 'Apfel', englishWord: 'apple', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/apfel.png', audioPath: 'assets/audio/fruitsandfood/apfel.mp3'),
  const Word(germanWord: 'Birne', englishWord: 'pear', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/birne.png', audioPath: 'assets/audio/fruitsandfood/birne.mp3'),
  const Word(germanWord: 'Pfirsich', englishWord: 'peach', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/pfirsich.png', audioPath: 'assets/audio/fruitsandfood/pfirsich.mp3'),
  const Word(germanWord: 'Orange', englishWord: 'orange', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/orange.png', audioPath: 'assets/audio/fruitsandfood/orange.mp3'),
  const Word(germanWord: 'Banane', englishWord: 'banana', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/banane.png', audioPath: 'assets/audio/fruitsandfood/banane.mp3'),
  const Word(germanWord: 'Kirsche', englishWord: 'cherry', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/kirsche.png', audioPath: 'assets/audio/fruitsandfood/kirsche.mp3'),
  const Word(germanWord: 'Melone', englishWord: 'melon', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/melone.png', audioPath: 'assets/audio/fruitsandfood/melone.mp3'),
  const Word(germanWord: 'Erdbeere', englishWord: 'strawberry', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/erdbeere.png', audioPath: 'assets/audio/fruitsandfood/erdbeere.mp3'),
  const Word(germanWord: 'Gurke', englishWord: 'cucumber', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/gurke.png', audioPath: 'assets/audio/fruitsandfood/gurke.mp3'),
  const Word(germanWord: 'Karotte', englishWord: 'carrot', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/karotte.png', audioPath: 'assets/audio/fruitsandfood/karotte.mp3'),
  const Word(germanWord: 'Milch', englishWord: 'milk', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/milch.png', audioPath: 'assets/audio/fruitsandfood/milch.mp3'),
  const Word(germanWord: 'Joghurt', englishWord: 'yogurt', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/joghurt.png', audioPath: 'assets/audio/fruitsandfood/joghurt.mp3'),
  const Word(germanWord: 'Nudeln', englishWord: 'noodles/pasta', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/nudeln.png', audioPath: 'assets/audio/fruitsandfood/nudeln.mp3'),
  const Word(germanWord: 'Tee', englishWord: 'tea', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/tee.png', audioPath: 'assets/audio/fruitsandfood/tee.mp3'),
  const Word(germanWord: 'Saft', englishWord: 'juice', category: WordCategory.fruitsAndFood, imagePath: 'assets/images/fruitsandfood/saft.png', audioPath: 'assets/audio/fruitsandfood/saft.mp3'),

  // Animals
  const Word(germanWord: 'Delfin', englishWord: 'dolphin', category: WordCategory.animals, imagePath: 'assets/images/animals/delfin.png', audioPath: 'assets/audio/animals/delfin.mp3'),
  const Word(germanWord: 'Ente', englishWord: 'duck', category: WordCategory.animals, imagePath: 'assets/images/animals/ente.png', audioPath: 'assets/audio/animals/ente.mp3'),
  const Word(germanWord: 'Elefant', englishWord: 'elephant', category: WordCategory.animals, imagePath: 'assets/images/animals/elefant.png', audioPath: 'assets/audio/animals/elefant.mp3'),
  const Word(germanWord: 'Igel', englishWord: 'hedgehog', category: WordCategory.animals, imagePath: 'assets/images/animals/igel.png', audioPath: 'assets/audio/animals/igel.mp3'),
  const Word(germanWord: 'Hund', englishWord: 'dog', category: WordCategory.animals, imagePath: 'assets/images/animals/hund.png', audioPath: 'assets/audio/animals/hund.mp3'),
  const Word(germanWord: 'Huhn', englishWord: 'chicken', category: WordCategory.animals, imagePath: 'assets/images/animals/huhn.png', audioPath: 'assets/audio/animals/huhn.mp3'),
  const Word(germanWord: 'Löwe', englishWord: 'lion', category: WordCategory.animals, imagePath: 'assets/images/animals/lowe.png', audioPath: 'assets/audio/animals/loewe.mp3'), // Using 'lowe' for image filename
  const Word(germanWord: 'Tiger', englishWord: 'tiger', category: WordCategory.animals, imagePath: 'assets/images/animals/tiger.png', audioPath: 'assets/audio/animals/tiger.mp3'),
  const Word(germanWord: 'Affe', englishWord: 'monkey', category: WordCategory.animals, imagePath: 'assets/images/animals/affe.png', audioPath: 'assets/audio/animals/affe.mp3'),
  const Word(germanWord: 'Maus', englishWord: 'mouse', category: WordCategory.animals, imagePath: 'assets/images/animals/maus.png', audioPath: 'assets/audio/animals/maus.mp3'),
  const Word(germanWord: 'Bär', englishWord: 'bear', category: WordCategory.animals, imagePath: 'assets/images/animals/bar.png', audioPath: 'assets/audio/animals/baer.mp3'), // Using 'bar' for image filename
  const Word(germanWord: 'Hase', englishWord: 'rabbit', category: WordCategory.animals, imagePath: 'assets/images/animals/hase.png', audioPath: 'assets/audio/animals/hase.mp3'),
  const Word(germanWord: 'Vogel', englishWord: 'bird', category: WordCategory.animals, imagePath: 'assets/images/animals/vogel.png', audioPath: 'assets/audio/animals/vogel.mp3'),
  const Word(germanWord: 'Zebra', englishWord: 'zebra', category: WordCategory.animals, imagePath: 'assets/images/animals/zebra.png', audioPath: 'assets/audio/animals/zebra.mp3'),
  const Word(germanWord: 'Giraffe', englishWord: 'giraffe', category: WordCategory.animals, imagePath: 'assets/images/animals/giraffe.png', audioPath: 'assets/audio/animals/giraffe.mp3'),
  const Word(germanWord: 'Kuh', englishWord: 'cow', category: WordCategory.animals, imagePath: 'assets/images/animals/kuh.png', audioPath: 'assets/audio/animals/kuh.mp3'),
  const Word(germanWord: 'Frosch', englishWord: 'frog', category: WordCategory.animals, imagePath: 'assets/images/animals/frosch.png', audioPath: 'assets/audio/animals/frosch.mp3'),
  const Word(germanWord: 'Pferd', englishWord: 'horse', category: WordCategory.animals, imagePath: 'assets/images/animals/pferd.png', audioPath: 'assets/audio/animals/pferd.mp3'),
  const Word(germanWord: 'Schwein', englishWord: 'pig', category: WordCategory.animals, imagePath: 'assets/images/animals/schwein.png', audioPath: 'assets/audio/animals/schwein.mp3'),
  const Word(germanWord: 'Taube', englishWord: 'pigeon/dove', category: WordCategory.animals, imagePath: 'assets/images/animals/taube.png', audioPath: 'assets/audio/animals/taube.mp3'),

  // Clothing
  const Word(germanWord: 'Rock', englishWord: 'skirt', category: WordCategory.clothing, imagePath: 'assets/images/clothing/rock.png', audioPath: 'assets/audio/clothing/rock.mp3'),
  const Word(germanWord: 'Pullover', englishWord: 'sweater', category: WordCategory.clothing, imagePath: 'assets/images/clothing/pullover.png', audioPath: 'assets/audio/clothing/pullover.mp3'),
  const Word(germanWord: 'Hut', englishWord: 'hat', category: WordCategory.clothing, imagePath: 'assets/images/clothing/hut.png', audioPath: 'assets/audio/clothing/hut.mp3'),
  const Word(germanWord: 'Hose', englishWord: 'pants', category: WordCategory.clothing, imagePath: 'assets/images/clothing/hose.png', audioPath: 'assets/audio/clothing/hose.mp3'),
  const Word(germanWord: 'T-Shirt', englishWord: 'T-shirt', category: WordCategory.clothing, imagePath: 'assets/images/clothing/tshirt.png', audioPath: 'assets/audio/clothing/t-shirt.mp3'),
  const Word(germanWord: 'Kleid', englishWord: 'dress', category: WordCategory.clothing, imagePath: 'assets/images/clothing/kleid.png', audioPath: 'assets/audio/clothing/kleid.mp3'),
  const Word(germanWord: 'Hemd', englishWord: 'shirt', category: WordCategory.clothing, imagePath: 'assets/images/clothing/hemd.png', audioPath: 'assets/audio/clothing/hemd.mp3'),
  const Word(germanWord: 'Bluse', englishWord: 'blouse', category: WordCategory.clothing, imagePath: 'assets/images/clothing/bluse.png', audioPath: 'assets/audio/clothing/bluse.mp3'),
  const Word(germanWord: 'Shorts', englishWord: 'shorts', category: WordCategory.clothing, imagePath: 'assets/images/clothing/shorts.png', audioPath: 'assets/audio/clothing/shorts.mp3'),
  const Word(germanWord: 'Jacke', englishWord: 'jacket', category: WordCategory.clothing, imagePath: 'assets/images/clothing/jacke.png', audioPath: 'assets/audio/clothing/jacke.mp3'),
  const Word(germanWord: 'Gürtel', englishWord: 'belt', category: WordCategory.clothing, imagePath: 'assets/images/clothing/gurtel.png', audioPath: 'assets/audio/clothing/guertel.mp3'), // Using 'gurtel' for image filename

  // School Supplies
  const Word(germanWord: 'Lineal', englishWord: 'ruler', category: WordCategory.schoolSupplies, imagePath: 'assets/images/schoolsupplies/lineal.png', audioPath: 'assets/audio/schoolsupplies/lineal.mp3'),
  const Word(germanWord: 'Buch', englishWord: 'book', category: WordCategory.schoolSupplies, imagePath: 'assets/images/schoolsupplies/buch.png', audioPath: 'assets/audio/schoolsupplies/buch.mp3'),
  const Word(germanWord: 'Bleistift', englishWord: 'pencil', category: WordCategory.schoolSupplies, imagePath: 'assets/images/schoolsupplies/bleistift.png', audioPath: 'assets/audio/schoolsupplies/bleistift.mp3'),
  const Word(germanWord: 'Mäppchen', englishWord: 'pencil case', category: WordCategory.schoolSupplies, imagePath: 'assets/images/schoolsupplies/mappchen.png', audioPath: 'assets/audio/schoolsupplies/maeppchen.mp3'), // Using 'mappchen' for image filename
  const Word(germanWord: 'Radiergummi', englishWord: 'eraser', category: WordCategory.schoolSupplies, imagePath: 'assets/images/schoolsupplies/radiergummi.png', audioPath: 'assets/audio/schoolsupplies/radiergummi.mp3'),
  const Word(germanWord: 'Füller', englishWord: 'fountain pen', category: WordCategory.schoolSupplies, imagePath: 'assets/images/schoolsupplies/fuller.png', audioPath: 'assets/audio/schoolsupplies/fueller.mp3'), // Using 'fuller' for image filename
  const Word(germanWord: 'Pinsel', englishWord: 'paintbrush', category: WordCategory.schoolSupplies, imagePath: 'assets/images/schoolsupplies/pinsel.png', audioPath: 'assets/audio/schoolsupplies/pinsel.mp3'),
  const Word(germanWord: 'Tafel', englishWord: 'chalkboard', category: WordCategory.schoolSupplies, imagePath: 'assets/images/schoolsupplies/tafel.png', audioPath: 'assets/audio/schoolsupplies/tafel.mp3'),

  // Objects/Things
  const Word(germanWord: 'Auto', englishWord: 'car', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/auto.png', audioPath: 'assets/audio/objectsthings/auto.mp3'),
  const Word(germanWord: 'Ball', englishWord: 'ball', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/ball.png', audioPath: 'assets/audio/objectsthings/ball.mp3'),
  const Word(germanWord: 'Baum', englishWord: 'tree', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/baum.png', audioPath: 'assets/audio/objectsthings/baum.mp3'),
  const Word(germanWord: 'Chef', englishWord: 'boss', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/chef.png', audioPath: 'assets/audio/objectsthings/chef.mp3'),
  const Word(germanWord: 'Clown', englishWord: 'clown', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/clown.png', audioPath: 'assets/audio/objectsthings/clown.mp3'),
  const Word(germanWord: 'Computer', englishWord: 'computer', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/computer.png', audioPath: 'assets/audio/objectsthings/computer.mp3'),
  const Word(germanWord: 'Dose', englishWord: 'can', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/dose.png', audioPath: 'assets/audio/objectsthings/dose.mp3'),
  const Word(germanWord: 'Instrument', englishWord: 'instrument', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/instrument.png', audioPath: 'assets/audio/objectsthings/instrument.mp3'),
  const Word(germanWord: 'Insel', englishWord: 'island', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/insel.png', audioPath: 'assets/audio/objectsthings/insel.mp3'),
  const Word(germanWord: 'Glas', englishWord: 'glass', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/glas.png', audioPath: 'assets/audio/objectsthings/glas.mp3'),
  const Word(germanWord: 'Leiter', englishWord: 'ladder', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/leiter.png', audioPath: 'assets/audio/objectsthings/leiter.mp3'),
  const Word(germanWord: 'Lampe', englishWord: 'lamp', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/lampe.png', audioPath: 'assets/audio/objectsthings/lampe.mp3'),
  const Word(germanWord: 'Motorrad', englishWord: 'motorcycle', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/motorrad.png', audioPath: 'assets/audio/objectsthings/motorrad.mp3'),
  const Word(germanWord: 'Puppe', englishWord: 'doll', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/puppe.png', audioPath: 'assets/audio/objectsthings/puppe.mp3'),
  const Word(germanWord: 'Rutsche', englishWord: 'slide', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/rutsche.png', audioPath: 'assets/audio/objectsthings/rutsche.mp3'),
  const Word(germanWord: 'Rasen', englishWord: 'lawn', category: WordCategory.objectsThings, imagePath: 'assets/images/objectsthings/rasen.png', audioPath: 'assets/audio/objectsthings/rasen.mp3'),

  // Days of the Week
  const Word(germanWord: 'Montag', englishWord: 'Monday', category: WordCategory.daysOfWeek, imagePath: 'assets/images/daysofweek/montag.png', audioPath: 'assets/audio/daysofweek/montag.mp3'),
  const Word(germanWord: 'Dienstag', englishWord: 'Tuesday', category: WordCategory.daysOfWeek, imagePath: 'assets/images/daysofweek/dienstag.png', audioPath: 'assets/audio/daysofweek/dienstag.mp3'),
  const Word(germanWord: 'Mittwoch', englishWord: 'Wednesday', category: WordCategory.daysOfWeek, imagePath: 'assets/images/daysofweek/mittwoch.png', audioPath: 'assets/audio/daysofweek/mittwoch.mp3'),
  const Word(germanWord: 'Donnerstag', englishWord: 'Thursday', category: WordCategory.daysOfWeek, imagePath: 'assets/images/daysofweek/donnerstag.png', audioPath: 'assets/audio/daysofweek/donnerstag.mp3'),
  const Word(germanWord: 'Freitag', englishWord: 'Friday', category: WordCategory.daysOfWeek, imagePath: 'assets/images/daysofweek/freitag.png', audioPath: 'assets/audio/daysofweek/freitag.mp3'),
  const Word(germanWord: 'Samstag', englishWord: 'Saturday', category: WordCategory.daysOfWeek, imagePath: 'assets/images/daysofweek/samstag.png', audioPath: 'assets/audio/daysofweek/samstag.mp3'),
  const Word(germanWord: 'Sonntag', englishWord: 'Sunday', category: WordCategory.daysOfWeek, imagePath: 'assets/images/daysofweek/sonntag.png', audioPath: 'assets/audio/daysofweek/sonntag.mp3'),

  // Numbers
  const Word(germanWord: 'eins', englishWord: 'one', category: WordCategory.numbers, imagePath: 'assets/images/numbers/eins.png', audioPath: 'assets/audio/numbers/eins.mp3'),
  const Word(germanWord: 'zwei', englishWord: 'two', category: WordCategory.numbers, imagePath: 'assets/images/numbers/zwei.png', audioPath: 'assets/audio/numbers/zwei.mp3'),
  const Word(germanWord: 'drei', englishWord: 'three', category: WordCategory.numbers, imagePath: 'assets/images/numbers/drei.png', audioPath: 'assets/audio/numbers/drei.mp3'),
  const Word(germanWord: 'vier', englishWord: 'four', category: WordCategory.numbers, imagePath: 'assets/images/numbers/vier.png', audioPath: 'assets/audio/numbers/vier.mp3'),
  const Word(germanWord: 'fünf', englishWord: 'five', category: WordCategory.numbers, imagePath: 'assets/images/numbers/funf.png', audioPath: 'assets/audio/numbers/fuenf.mp3'), // Using 'funf' for image filename
  const Word(germanWord: 'sechs', englishWord: 'six', category: WordCategory.numbers, imagePath: 'assets/images/numbers/sechs.png', audioPath: 'assets/audio/numbers/sechs.mp3'),
  const Word(germanWord: 'sieben', englishWord: 'seven', category: WordCategory.numbers, imagePath: 'assets/images/numbers/sieben.png', audioPath: 'assets/audio/numbers/sieben.mp3'),
  const Word(germanWord: 'acht', englishWord: 'eight', category: WordCategory.numbers, imagePath: 'assets/images/numbers/acht.png', audioPath: 'assets/audio/numbers/acht.mp3'),
  const Word(germanWord: 'neun', englishWord: 'nine', category: WordCategory.numbers, imagePath: 'assets/images/numbers/neun.png', audioPath: 'assets/audio/numbers/neun.mp3'),
  const Word(germanWord: 'zehn', englishWord: 'ten', category: WordCategory.numbers, imagePath: 'assets/images/numbers/zehn.png', audioPath: 'assets/audio/numbers/zehn.mp3'),
];

// Helper function to get category name as string for directory paths
String categoryToString(WordCategory category) {
  return category.toString().split('.').last.toLowerCase();
}

// Helper function to get words by category
List<Word> getWordsByCategory(WordCategory category) {
  return germanWords.where((word) => word.category == category).toList();
}
