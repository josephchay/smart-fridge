import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class AppCsvFileLoader {
  AppCsvFileLoader._();

  static Future<List<List<dynamic>>> loadCsvFile(String path,
      {bool skipFirstRow = true}) async {
    final rawData = await rootBundle.loadString(path);
    List<List<dynamic>> data = const CsvToListConverter().convert(rawData);

    if (skipFirstRow) {
      // Remove the first row if `skipFirstRow` is true
      data.removeAt(0);
    }

    return data;
  }
}
