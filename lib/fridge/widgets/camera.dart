import 'package:flutter/material.dart';
import 'package:smart_fridge/fridge/controllers/camera_controller.dart';
import 'package:smart_fridge/fridge/models/recognition_model.dart';
import 'package:smart_fridge/fridge/models/stats_model.dart';
import 'package:smart_fridge/fridge/widgets/box_widget.dart';
import 'package:smart_fridge/fridge/models/camera_view_model.dart';

import 'camera_view.dart';

/// [CameraScreen] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late List<Recognition> results;
  late Stats stats;
  late Stats totalStats;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      onNewResults: (results) {
        setState(() => this.results = results);
      },
      onUpdateStats: (stats) {
        setState(() {
          this.stats = stats;
          this.totalStats += stats;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void resultsCallback(List<Recognition> results) {
    _controller.updateResults(results);
  }

  void statsCallback(Stats stats) {
    _controller.updateStats(stats);
  }

  _reset() {
    _controller.resetStats();
  }

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

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 0.5,
              builder: (_, ScrollController scrollController) => Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), borderRadius: 20),
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
                                      'Decision time:',
                                      '${stats.inferenceTime}ms (${avg.inferenceTime}ms)',
                                    ),
                                    Metric(
                                      'Setup time:',
                                      '${stats.preProcessingTime}ms (${avg.preProcessingTime}ms)',
                                    ),
                                    Metric(
                                      'Total Analysis time:',
                                      '${stats.totalPredictTime}ms (${avg.totalPredictTime}ms)',
                                    ),
                                    Metric(
                                      'Total time taken:',
                                      '${stats.totalElapsedTime}ms (${avg.totalElapsedTime}ms)',
                                    ),
                                    Metric(
                                      'Items Processed:',
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
