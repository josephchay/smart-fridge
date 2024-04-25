import 'package:smart_fridge/grocery_listings/model/popular_filter_list.dart';
import 'package:smart_fridge/utils/files/csv_file_loader.dart';

class GroceryData {
  String imagePath;
  String category;
  String name;
  String brand;
  String price;

  GroceryData({
    this.imagePath = "",
    this.category = "",
    this.name = "",
    this.brand = "",
    required double price, // Accept price as a double
  }) : price =
            price.toStringAsFixed(2); // Convert to string with 2 decimal places
}

final List<GroceryData> groceryList = <GroceryData>[];

final Set<String> uniqueCategories = {};
final Set<String> uniqueBrands = {};

Future<void> loadGroceryData(String csvFilePath) async {
  List<List<dynamic>> csvData = await AppCsvFileLoader.loadCsvFile(csvFilePath);

  // Skip the header row
  for (var i = 1; i < csvData.length; i++) {
    // Start with 1 if the first row is the header
    var row = csvData[i];

    // Parse the price as a double and multiply before passing to the constructor
    double price = double.parse(row[9].toString()) * 4.76;

    GroceryData groceryData = GroceryData(
      category: row[2],
      name: row[7],
      brand: row[8],
      price: price, // Pass the double price here
    );

    groceryList.add(groceryData);
    uniqueCategories.add(groceryData.category);
    uniqueBrands.add(groceryData.brand);
  }

  // convert to list for easier access where needed
  List<String> uniqueCategoriesList = uniqueCategories.toList();
  List<String> uniqueBrandsList = uniqueBrands.toList();
}
