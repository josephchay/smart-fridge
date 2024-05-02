import 'package:flutter/services.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image/image.dart';
import 'package:smart_fridge/fridge/tflite/recognition_model.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../detection/stats_model.dart';

/// Classifier
class Classifier {
  /// Instance of Interpreter
  Interpreter? _interpreter;

  /// Labels file loaded as list
  List<String>? _labels;

  static const String MODEL_FILE_NAME = "model_unquant.tflite";
  static const String LABEL_FILE_NAME = "labels.txt";

  /// Input size of image (height = width = 300)
  static const int INPUT_SIZE = 300;

  /// Result score threshold
  static const double THRESHOLD = 0.5;

  /// Padding the image to transform into square
  int padSize = INPUT_SIZE;

  /// Number of results to show
  static const int NUM_RESULTS = 10;

  Classifier({
    Interpreter? interpreter,
    List<String>? labels,
  }) {
    loadModel(interpreter: interpreter);
    loadLabels(labels: labels);
  }

  /// Loads interpreter from asset
  void loadModel({Interpreter? interpreter}) async {
    try {
      if (interpreter == null) {
        final file =
            await rootBundle.load('assets/object_detection/$MODEL_FILE_NAME');
        _interpreter = Interpreter.fromBuffer(
          file.buffer.asUint8List(),
          options: InterpreterOptions()..threads = 4,
        );
      } else {
        _interpreter = interpreter;
      }
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }

  /// Loads labels from assets
  void loadLabels({List<String>? labels}) async {
    try {
      _labels = labels ??
          (await rootBundle
                  .loadString("assets/object_detection/" + LABEL_FILE_NAME))
              .split('\n');
    } catch (e) {
      print("Error while loading labels: $e");
    }
  }

  Map<String, dynamic> predict(imageLib.Image image) {
    var predictStartTime = DateTime.now().millisecondsSinceEpoch;
    var preProcessStart = DateTime.now().millisecondsSinceEpoch;

    /// Pre-process the image
    /// Resizing image for model [300, 300]
    final imageInput = imageLib.copyResize(
      image,
      width: INPUT_SIZE,
      height: INPUT_SIZE,
      interpolation: Interpolation.linear,
    );

    final imageMatrix = imageInput.getBytes(format: Format.rgb);

    var preProcessElapsedTime =
        DateTime.now().millisecondsSinceEpoch - preProcessStart;

    final input = [imageMatrix];

    // Set output tensor
    // Locations: [1, 10, 4]
    // Classes: [1, 10],
    // Scores: [1, 10],
    // Number of detections: [1]
    final outputLocations = [
      List<List<num>>.filled(10, List<num>.filled(4, 0))
    ];
    final outputClasses = [List<num>.filled(10, 0)];
    final outputScores = [List<num>.filled(10, 0)];
    final numLocations = [0.0];

    final output = {
      0: outputLocations,
      1: outputClasses,
      2: outputScores,
      3: numLocations,
    };

    var inferenceTimeStart = DateTime.now().millisecondsSinceEpoch;

    _interpreter!.runForMultipleInputs(input, output);

    var inferenceElapsedTime =
        DateTime.now().millisecondsSinceEpoch - inferenceTimeStart;

    // Location
    final locationsRaw = outputLocations.first as List<List<double>>;

    final List<Rect> locations = locationsRaw
        .map((list) => list.map((value) => (value * INPUT_SIZE)).toList())
        .map((rect) => Rect.fromLTRB(rect[1], rect[0], rect[3], rect[2]))
        .toList();

    // Classes
    final classesRaw = outputClasses.first as List<double>;
    final classes = classesRaw.map((value) => value.toInt()).toList();

    // Scores
    final scores = outputScores.first as List<double>;

    // Number of detections
    final numberOfDetectionsRaw = numLocations.first;
    final numberOfDetections = numberOfDetectionsRaw.toInt();

    // Using labelOffset = 1 as ??? at index 0
    int labelOffset = 1;

    final List<String> classification = [];
    for (var i = 0; i < numberOfDetections; i++) {
      classification.add(_labels![classes[i] + labelOffset]);
    }

    /// Generate recognitions
    List<Recognition> recognitions = [];
    for (int i = 0; i < numberOfDetections; i++) {
      // Prediction score
      var score = scores[i];
      // Label string
      var label = classification[i];

      if (score > THRESHOLD) {
        final originalSize = Size(INPUT_SIZE.toDouble(), INPUT_SIZE.toDouble());
        Size targetSize = Size(image.width.toDouble(), image.height.toDouble());
        final transformedRect =
            transformRectForImage(locations[i], originalSize, targetSize);
        recognitions.add(
          Recognition(i, label, score, transformedRect),
        );
      }
    }

    var predictElapsedTime =
        DateTime.now().millisecondsSinceEpoch - predictStartTime;

    return {
      "recognitions": recognitions,
      "stats": Stats(
        totalPredictTime: predictElapsedTime,
        inferenceTime: inferenceElapsedTime,
        preProcessingTime: preProcessElapsedTime,
      )
    };
  }

  Rect transformRectForImage(
      Rect originalRect, fromImageSize, Size toImageSize) {
    final double widthScale = toImageSize.width / fromImageSize.width;
    final double heightScale = toImageSize.height / fromImageSize.height;

    // Calculate new dimensions
    double newLeft = originalRect.left * widthScale;
    double newTop = originalRect.top * heightScale;
    double newRight = originalRect.right * widthScale;
    double newBottom = originalRect.bottom * heightScale;

    // Adjust for center alignment if necessary
    double dx = (toImageSize.width - fromImageSize.width * widthScale) / 2;
    double dy = (toImageSize.height - fromImageSize.height * heightScale) / 2;
    newLeft += dx;
    newRight += dx;
    newTop += dy;
    newBottom += dy;

    return Rect.fromLTRB(newLeft, newTop, newRight, newBottom);
  }

  /// Gets the interpreter instance
  Interpreter? get interpreter => _interpreter;

  /// Gets the loaded labels
  List<String>? get labels => _labels;
}
