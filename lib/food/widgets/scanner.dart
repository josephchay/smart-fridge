import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_fridge/food/controllers/scanner_controller.dart';

class FoodScanner extends StatefulWidget {
  final String modelPath;
  final String labelsPath;

  FoodScanner({Key? key, required this.modelPath, required this.labelsPath})
      : super(key: key);

  @override
  _FoodScannerState createState() => _FoodScannerState();
}

class _FoodScannerState extends State<FoodScanner> {
  late FoodScannerController _controller;
  bool isImageLoaded = false;
  File? _image;
  Map<String, dynamic> nutrients = {};

  @override
  void initState() {
    super.initState();
    _controller = FoodScannerController(
        context: context,
        modelPath: widget.modelPath,
        labelsPath: widget.labelsPath,
        onNutrientsAvailable: (nutrientsData) {
          setState(() {
            nutrients = nutrientsData;
          });
        });
    _controller.loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Your Food Nutrients'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          isImageLoaded && _image != null
              ? Image.file(_image!)
              : Text("No image selected, tap below to take a picture."),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _controller.pickImage,
            child: Text('Take Picture'),
          ),
          SizedBox(height: 20),
          nutrients.isNotEmpty ? displayNutritionInfo() : Container(),
        ],
      ),
    );
  }

  Widget displayNutritionInfo() {
    return Column(
      children: <Widget>[
        Text("Nutritional Information:",
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ...nutrients.keys
            .map((key) => nutritionalDetail(
                key.toUpperCase(), "${nutrients[key]}", Colors.blue[300]!))
            .toList(),
      ],
    );
  }

  Widget nutritionalDetail(String nutrient, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 35,
          backgroundColor: color.withOpacity(0.2),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(nutrient,
                    style:
                        TextStyle(color: color, fontWeight: FontWeight.bold)),
                Text(value, style: TextStyle(color: color)),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
