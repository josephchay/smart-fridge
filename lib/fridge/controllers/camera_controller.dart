import 'package:smart_fridge/fridge/models/recognition_model.dart';
import 'package:smart_fridge/fridge/models/stats_model.dart';

class CameraController {
  final Function(List<Recognition>) onNewResults;
  final Function(Stats) onUpdateStats;
  Stats totalStats;

  CameraController({
    required this.onNewResults,
    required this.onUpdateStats,
  }) : totalStats = Stats(
            totalPredictTime: 0,
            inferenceTime: 0,
            preProcessingTime: 0,
            totalElapsedTime: 0,
            count: 0);

  /// Method to update recognition results and notify the screen to rebuild
  void updateResults(List<Recognition> newResults) {
    onNewResults(newResults);
  }

  /// Method to update stats and notify the screen to rebuild
  void updateStats(Stats newStats) {
    totalStats += newStats;
    onUpdateStats(newStats);
  }

  /// Resets the total statistics to zero
  void resetStats() {
    totalStats = Stats(
        totalPredictTime: 0,
        inferenceTime: 0,
        preProcessingTime: 0,
        totalElapsedTime: 0,
        count: 0);
    onUpdateStats(totalStats);
  }
}
