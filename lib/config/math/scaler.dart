import 'dart:math';
import 'package:flutter/material.dart';

/// Scaler class to scale values based on the screen size
class Scaler {
  static double textScaleFactor(BuildContext context,
      {double maxScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxScaleFactor;
    return max(1, min(val, maxScaleFactor));
  }

  static double paddingHorizontalScaleFactor(BuildContext context,
      {double maxScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double scaleFactor = (width / 400); // Example base width of 400

    // Ensure scaleFactor is at least 1 and does not exceed maxScaleFactor
    return max(1, min(scaleFactor, maxScaleFactor));
  }

  static double paddingVerticalScaleFactor(BuildContext context,
      {double maxScaleFactor = 2}) {
    final height = MediaQuery.of(context).size.height;
    double scaleFactor = (height / 800); // Example base height of 800

    // Ensure scaleFactor is at least 1 and does not exceed maxScaleFactor
    return max(1, min(scaleFactor, maxScaleFactor));
  }
}
