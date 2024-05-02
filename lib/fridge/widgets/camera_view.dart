import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:smart_fridge/fridge/widgets/classifier.dart';
import 'package:smart_fridge/fridge/controllers/camera_view_controller.dart';
import 'package:smart_fridge/fridge/models/recognition_model.dart';
import 'package:smart_fridge/fridge/models/stats_model.dart';
import 'package:smart_fridge/fridge/utils/isolate_utils.dart';
import 'package:smart_fridge/fridge/models/camera_view_model.dart';

/// [CameraView] sends each frame for inference
class CameraView extends StatefulWidget {
  /// Callback to pass results after inference to [HomeView]
  final Function(List<Recognition> recognitions) resultsCallback;

  /// Callback to inference stats to [HomeView]
  final Function(Stats stats) statsCallback;

  /// Constructor
  const CameraView(this.resultsCallback, this.statsCallback);
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  late CameraControllerManager _cameraManager;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _cameraManager = CameraControllerManager(
      widget.resultsCallback,
      widget.statsCallback,
      Classifier(),
      IsolateUtils(),
    );

    _cameraManager.initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return CameraPreview(_cameraManager._cameraController);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _cameraManager.pauseCameraStream();
    } else if (state == AppLifecycleState.resumed) {
      _cameraManager.resumeCameraStream();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraManager.dispose();
    super.dispose();
  }
}
