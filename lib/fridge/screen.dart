import 'package:camera/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutter/material.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'dart:async';

import 'package:smart_fridge/src/config/themes/app_theme.dart';

late List<CameraDescription> cameras;

// YOLO V5 REAL-TIME OBJECT DETECTION
class FridgeScreen extends StatefulWidget {
  const FridgeScreen({
    super.key,
  });

  @override
  State<FridgeScreen> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen>
    with WidgetsBindingObserver {
  late CameraController controller;
  List<Map<String, dynamic>> yoloResults = [];
  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;

  late FlutterVision vision; // YOLO
  FlutterTts flutterTts = FlutterTts(); // TTS
  bool isTTSActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    vision = FlutterVision(); // YOLO
    // initTTS();
    initCamera();
  }

  // Initialize camera and start detection
  void initCamera() async {
    cameras = await availableCameras();
    controller =
        CameraController(cameras[0], ResolutionPreset.max, enableAudio: false);
    await controller.initialize();
    await loadYoloModel();
    startDetection();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      stopDetection(); // Stop detection when the app is paused
    } else if (state == AppLifecycleState.resumed) {
      startDetection(); // Resume detection when the app is resumed
    }
  }

  /// Text to Speech
  Future<void> initTTS() async {
    await flutterTts.setLanguage("en-US"); // Set the language
    await flutterTts.setSpeechRate(1.0); // Adjust speech rate (1.0 is normal)
    await flutterTts.setVolume(1.0); // Adjust volume (0.0 to 1.0)
    await flutterTts.setPitch(1.0); // Adjust pitch (1.0 is normal)

    setState(() {
      isTTSActive = true;
    });
  }

  Future<void> speak(String text) async {
    if (isTTSActive) {
      await flutterTts.speak(text); // TTS
    }
  }

  void init() async {
    cameras = await availableCameras();
    controller =
        CameraController(cameras[0], ResolutionPreset.max, enableAudio: false);
    controller.initialize().then((value) {
      loadYoloModel().then((value) {
        setState(() {
          isLoaded = true;
          isDetecting = false;
          yoloResults = [];
        });
      });
    });
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    stopDetection(); // Stop detection

    flutterTts.stop(); // TTS Stop
    vision.closeYoloModel(); // YOLO Stop

    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (!isLoaded) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text(
            "Getting camera ready",
            style: TextStyle(
                color: AppTheme.white,
                fontSize: 16 * Scaler.textScaleFactor(context)),
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(
            controller,
          ),
        ),
        ...displayBoxesAroundRecognizedObjects(size),
      ],
    );
  }

  // Load YOLO model
  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
      labels: 'assets/object_detection/yolo/labels.txt',
      modelPath: 'assets/object_detection/yolo/yolov5n.tflite',
      modelVersion: "yolov5",
      numThreads: 8,
      useGpu: true,
    );
    setState(() {
      isLoaded = true;
    });
    // Optionally call startDetection() here if you want to wait for the model to load
    // startDetection();
  }

  // Process each frame for YOLO
  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        iouThreshold: 0.4,
        confThreshold: 0.4,
        classThreshold: 0.5);
    if (result.isNotEmpty && mounted) {
      setState(() {
        yoloResults = result;
      });
      for (var res in result) {
        speak(res['tag']); // For each detection, speak out the result
      }
    }
  }

  // Ensure that the startDetection is awaited and starts the image stream
  Future<void> startDetection() async {
    if (!controller.value.isStreamingImages) {
      setState(() {
        isDetecting = true;
      });
      controller.startImageStream((image) {
        if (isDetecting) {
          cameraImage = image;
          yoloOnFrame(image);
        }
      });
    }
  }

  // Stop the detection process
  Future<void> stopDetection() async {
    if (isDetecting) {
      await controller.stopImageStream();
      isDetecting = false;
      yoloResults.clear();
    }
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty) return [];
    double factorX = screen.width / (cameraImage?.height ?? 1);
    double factorY = screen.height / (cameraImage?.width ?? 1);

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);

    return yoloResults.map((result) {
      speak("${result['tag']}");

      String detection =
          "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%";
      String detectionWithoutConfidence = "${result['tag']}";

      return Positioned(
        left: result["box"][0] * factorX,
        top: result["box"][1] * factorY,
        width: (result["box"][2] - result["box"][0]) * factorX,
        height: (result["box"][3] - result["box"][1]) * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color: colorPick,
              width: 2.0,
            ),
          ),
          child: Text(
            detection,
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.white,
              fontSize: 16.0 * Scaler.textScaleFactor(context),
            ),
          ),
        ),
      );
    }).toList();
  }
}
