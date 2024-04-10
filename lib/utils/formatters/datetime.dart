import 'package:intl/intl.dart';

class AppDatetime {
  AppDatetime._();

  static String formatDate(DateTime date) {
    return DateFormat('dd MMM').format(date);
  }

  static String fromMinutesToFormattedHourMinute(int totalMinutes) {
    // Calculate hours and remaining minutes
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    // Format and return the string
    return hours == 0 ? "${minutes}m" : "${hours}h ${minutes}m";
  }
}
