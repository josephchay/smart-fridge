import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_fridge/food/widgets/read.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class FoodScannerController {
  final Function(Map<String, dynamic>) onNutrientsAvailable;
  final BuildContext context;
  final String modelPath;
  final String labelsPath;

  FoodScannerController({
    required this.context,
    required this.onNutrientsAvailable,
    required this.modelPath,
    required this.labelsPath,
  });

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: modelPath,
      labels: labelsPath,
    );
  }

  Future<void> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      File _image = File(image.path);
      runModelOnImage(_image);
    }
  }

  Future<void> runModelOnImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.1,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    if (output != null) {
      Map<String, dynamic> nutrients = {};
      for (var result in output) {
        nutrients[result['label']] = result['confidence'];
      }
      onNutrientsAvailable(nutrients);
      navigateToRead(nutrients);
    }
  }

  void navigateToRead(Map<String, dynamic> nutrientsData) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Read(nutrients: nutrientsData)));
  }

  void dispose() {
    Tflite.close();
  }
}
