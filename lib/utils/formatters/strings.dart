class AppStrings {
  AppStrings._();

  static String capitalizeFirstOfSentence(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
