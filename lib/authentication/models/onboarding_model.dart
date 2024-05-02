import 'package:flutter/material.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;
  final String? number;
  final List<Color> bgColors;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
    this.number,
    required this.bgColors,
  });
}
