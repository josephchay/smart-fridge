import 'package:flutter/material.dart';
import 'package:smart_fridge/camera/tflite/recognition.dart';
import 'package:smart_fridge/camera/tflite/stats.dart';
import 'package:smart_fridge/camera/ui/box_widget.dart';
import 'package:smart_fridge/camera/ui/camera_view_singleton.dart';

import 'camera_view.dart';

/// [CameraScreen] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  /// Results to draw bounding boxes
  List<Recognition>? results;

  /// Realtime stats
  Stats? stats;
  Stats totalStats = Stats(
      totalPredictTime: 0,
      inferenceTime: 0,
      preProcessingTime: 0,
      totalElapsedTime: 0,
      count: 0);

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final stats = this.stats;
    final avg = totalStats.average;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Camera View
          CameraView(resultsCallback, statsCallback),

          // Bounding boxes
          boundingBoxes(results),

          // Heading
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Object Detection Flutter',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent.withOpacity(0.4),
                ),
              ),
            ),
          ),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.1,
              maxChildSize: 0.5,
              builder: (_, ScrollController scrollController) => Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BORDER_RADIUS_BOTTOM_SHEET),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.keyboard_arrow_up,
                            size: 48, color: Colors.orange),
                        (stats != null)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Metric(
                                      'Inference time:',
                                      '${stats.inferenceTime}ms (${avg.inferenceTime}ms)',
                                    ),
                                    Metric(
                                      'Pre-processing time:',
                                      '${stats.preProcessingTime}ms (${avg.preProcessingTime}ms)',
                                    ),
                                    Metric(
                                      'Total predict time:',
                                      '${stats.totalPredictTime}ms (${avg.totalPredictTime}ms)',
                                    ),
                                    Metric(
                                      'Total elapsed time:',
                                      '${stats.totalElapsedTime}ms (${avg.totalElapsedTime}ms)',
                                    ),
                                    Metric(
                                      'Count:',
                                      '${totalStats.count}',
                                    ),
                                    Metric(
                                      'Frame',
                                      '${CameraViewSingleton.inputImageSize?.width} X ${CameraViewSingleton.inputImageSize?.height}',
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: OutlinedButton(
                                          onPressed: _reset,
                                          child: Text(
                                            "Reset average",
                                            style:
                                                TextStyle(color: Colors.orange),
                                          )),
                                    )
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition>? results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results
          .map((e) => BoxWidget(
                result: e,
              ))
          .toList(),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results) {
    setState(() {
      this.results = results;
    });
  }

  _reset() {
    setState(() {
      totalStats = Stats(
          totalPredictTime: 0,
          inferenceTime: 0,
          preProcessingTime: 0,
          totalElapsedTime: 0,
          count: 0);
    });
  }

  /// Callback to get inference stats from [CameraView]
  void statsCallback(Stats stats) {
    setState(() {
      this.stats = stats;
      this.totalStats += stats;
    });
  }

  static const BOTTOM_SHEET_RADIUS = Radius.circular(24.0);
  static const BORDER_RADIUS_BOTTOM_SHEET = BorderRadius.only(
      topLeft: BOTTOM_SHEET_RADIUS, topRight: BOTTOM_SHEET_RADIUS);
}

/// Row for one Stats field
class Metric extends StatelessWidget {
  final String left;
  final String right;

  Metric(this.left, this.right);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(left), Text(right)],
      ),
    );
  }
}
