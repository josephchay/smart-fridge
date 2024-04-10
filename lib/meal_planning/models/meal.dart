import 'package:intl/intl.dart';
import 'package:smart_fridge/utils/files/csv_file_loader.dart';

class Meal {
  final String name;
  final int preparationMinutes;
  final String submitted;
  final List<String> tags;
  final int nSteps;
  final List<String> steps;
  final String description;
  final List<String> ingredients;
  final int nIngredients;
  bool isFavorite = false;
  final String image;

  Meal({
    required this.name,
    required this.preparationMinutes,
    required this.submitted,
    required this.tags,
    required this.nSteps,
    required this.steps,
    required this.description,
    required this.ingredients,
    required this.nIngredients,
    this.isFavorite = false,
    required this.image,
  });
}

final List<Meal> latestMealList = <Meal>[];
List<Meal> recommendedMealList = <Meal>[];

Future<void> loadMeals(String csvFilePath) async {
  List<List<dynamic>> csvData = await AppCsvFileLoader.loadCsvFile(csvFilePath);

  // Skip the header row
  for (var i = 0; i < csvData.length; i++) {
    var row = csvData[i];

    // Attempt to parse the date, use "Not Available" if parsing fails
    String submitted;
    try {
      DateFormat format = DateFormat('M/d/yyyy');
      DateTime parsedDate = format.parse(row[4].replaceAll("#", ""));
      submitted = DateFormat('d\'th\' MMMM yyyy').format(parsedDate);
    } catch (e) {
      submitted = "Not Available";
    }

    Meal meal = Meal(
      name: row[0]
          .trim() // Remove leading and trailing white spaces
          .split(RegExp(r'\s+')) // Split by one or more space characters
          .map((s) =>
              '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}') // Capitalize each word
          .join(' '),
      preparationMinutes: row[2],
      submitted: submitted,
      tags: extractTags(row[5]),
      nSteps: row[7],
      steps: extractTags(row[8]),
      description: row[9],
      ingredients: extractTags(row[10]),
      nIngredients: row[11],
      image: 'assets/images/meals/shrimp_sushi_bowls.jpeg',
    );

    latestMealList.add(meal);
    recommendedMealList.add(meal);
  }

  // Sort the list based on the 'submitted' date in descending order
  latestMealList.sort((Meal a, Meal b) => b.submitted.compareTo(a.submitted));
  print(latestMealList);
}

List<String> extractTags(String tagString) {
  // Remove the leading '[' and trailing ']' from the string
  String cleanedString = tagString.substring(1, tagString.length - 1);

  // Split the string by "', '" and remove any single quotes from each tag
  List<String> tags = cleanedString
      .split("', '")
      .map((tag) => tag.replaceAll("'", ""))
      .toList();

  return tags;
}
