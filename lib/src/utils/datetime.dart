import 'package:intl/intl.dart';

class AppDateTime {
  AppDateTime._();

  static String formatDate(DateTime date) {
    return DateFormat('dd MMM').format(date);
  }
}
