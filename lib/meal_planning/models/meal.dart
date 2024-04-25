import 'package:intl/intl.dart';
import 'package:smart_fridge/utils/files/csv_file_loader.dart';

class Meal {
  final String name;
  final List<String> steps;
  final int nSteps;
  final String image;
  final List<String> ingredients;
  final int nIngredients;
  final int preparationMinutes;
  final String submitted;
  bool isFavorite = false;

  Meal({
    required this.name,
    required this.steps,
    required this.nSteps,
    required this.image,
    required this.ingredients,
    required this.nIngredients,
    required this.preparationMinutes,
    required this.submitted,
    this.isFavorite = false,
  });
}

final List<Meal> latestMealList = <Meal>[];
List<Meal> recommendedMealList = <Meal>[];

Future<void> loadMeals(String csvFilePath) async {
  print("== loaded meals ====");
  List<List<dynamic>> csvData = await AppCsvFileLoader.loadCsvFile(csvFilePath);

  // Skip the header row
  for (var i = 0; i < csvData.length; i++) {
    var row = csvData[i];

    var steps = breakIntoSentences(row[3]);
    var ingredients = extractText(row[5]);
    // Attempt to parse the date, use "Not Available" if parsing fails
    String submitted;
    try {
      DateFormat format = DateFormat('M/d/yyyy');
      DateTime parsedDate = format.parse(row[7].replaceAll("#", ""));
      submitted = DateFormat('d\'th\' MMMM yyyy').format(parsedDate);
    } catch (e) {
      submitted = "Not Available";
    }

    Meal meal = Meal(
      name: row[1],
      steps: steps,
      nSteps: steps.length,
      image: 'assets/datasets/images/' + row[4] + '.jpg',
      ingredients: ingredients,
      nIngredients: ingredients.length,
      preparationMinutes: row[6],
      submitted: submitted,
    );

    latestMealList.add(meal);
    recommendedMealList.add(meal);
  }

  // Sort the list based on the 'submitted' date in descending order
  latestMealList.sort((Meal a, Meal b) => b.submitted.compareTo(a.submitted));
}

List<String> breakIntoSentences(String text) {
  RegExp exp = RegExp(r'[^\.!?\s][\.!?](?=\s|$)');
  List<String> sentences = [];
  int start = 0;

  while (true) {
    final match = exp.firstMatch(text.substring(start));
    if (match != null) {
      int end = start + match.end;
      String sentence = text.substring(start, end).trim();

      // Check and remove an extra period if it exists
      if (sentence.endsWith('.')) {
        sentence = sentence.substring(0, sentence.length - 1);
      }

      sentences.add(sentence);
      start = end;
    } else {
      break;
    }
  }

  return sentences;
}

List<String> extractText(String tagString) {
  // Remove the leading '[' and trailing ']' from the string
  String cleanedString = tagString.substring(1, tagString.length - 1);

  // Split the string by "', '" and remove any single quotes from each tag
  List<String> tags = cleanedString
      .split("', '")
      .map((tag) => tag.replaceAll("'", ""))
      .toList();

  return tags;
}

String capitalizeSentences(String text) {
  var buffer = StringBuffer();

  bool capitalizeNext = true;

  for (var i = 0; i < text.length; i++) {
    var char = text[i];

    // Check if the current character is a letter.
    if (RegExp(r'[A-Za-z]').hasMatch(char)) {
      buffer.write(capitalizeNext ? char.toUpperCase() : char);

      capitalizeNext = false;
    } else {
      buffer.write(char);

      if (char == '.' || char == '!' || char == '?') {
        capitalizeNext = true;
      }
    }
  }

  return buffer.toString();
}
