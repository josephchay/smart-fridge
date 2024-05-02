import 'package:camera/camera.dart';
import 'package:smart_fridge/fridge/widgets/classifier.dart';
import 'package:smart_fridge/fridge/models/recognition_model.dart';
import 'package:smart_fridge/fridge/models/stats_model.dart';
import 'package:smart_fridge/fridge/utils/isolate_utils.dart';

class CameraControllerManager {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _predicting = false;
  Classifier _classifier;
  IsolateUtils _isolateUtils;
  Function(List<Recognition>) onResult;
  Function(Stats) onUpdateStats;

  CameraControllerManager(
      this.onResult, this.onUpdateStats, this._classifier, this._isolateUtils);

  CameraController? get cameraController => _cameraController;

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController =
        CameraController(_cameras[0], ResolutionPreset.low, enableAudio: false);

    await _cameraController!.initialize().then((_) async {
      await _cameraController!.startImageStream(_onLatestImageAvailable);
    });
  }

  void _onLatestImageAvailable(CameraImage cameraImage) async {
    if (_predicting) return;

    _setPredicting(true);

    var inferenceResults = await _performInference(cameraImage);

    onResult(inferenceResults["recognitions"] as List<Recognition>);
    onUpdateStats(inferenceResults["stats"] as Stats);

    _setPredicting(false);
  }

  Future<Map<String, dynamic>> _performInference(
      CameraImage cameraImage) async {
    var interpreter = _classifier.interpreter;
    var labels = _classifier.labels;
    if (interpreter == null || labels == null) {
      return {};
    }

    var isolateData = IsolateData(cameraImage, interpreter.address, labels);
    return await _isolateUtils.runInference(isolateData);
  }

  void _setPredicting(bool status) {
    _predicting = status;
  }

  void dispose() {
    _cameraController?.dispose();
  }

  void pauseCameraStream() {
    _cameraController?.stopImageStream();
  }

  Future<void> resumeCameraStream() async {
    if (_cameraController != null &&
        !_cameraController!.value.isStreamingImages) {
      await _cameraController!.startImageStream(_onLatestImageAvailable);
    }
  }
}
