/// Bundles different elapsed times
class Stats {
  /// Total time taken in the isolate where the inference runs
  int totalPredictTime;

  /// [totalPredictTime] + communication overhead time
  /// between main isolate and another isolate
  int? totalElapsedTime;

  /// Time for which inference runs
  int inferenceTime;

  /// Time taken to pre-process the image
  int preProcessingTime;
  int count;

  Stats(
      {required this.totalPredictTime,
      this.totalElapsedTime,
      required this.inferenceTime,
      required this.preProcessingTime,
      this.count = 1});

  Stats operator +(Stats other) {
    return Stats(
        totalPredictTime: totalPredictTime + other.totalPredictTime,
        totalElapsedTime: (totalElapsedTime ?? 0) + (other.totalElapsedTime ?? 0),
        inferenceTime: inferenceTime + other.inferenceTime,
        preProcessingTime: preProcessingTime + other.preProcessingTime,
        count: count + other.count);
  }

  Stats get average {
    if (count == 0) {
      return this;
    }

    return Stats(
        totalPredictTime: totalPredictTime ~/ count,
        totalElapsedTime: totalElapsedTime! ~/ count,
        inferenceTime: inferenceTime ~/ count,
        preProcessingTime: preProcessingTime ~/ count,
        count: count);
  }

  @override
  String toString() {
    return 'Stats{totalPredictTime: $totalPredictTime, totalElapsedTime: $totalElapsedTime, inferenceTime: $inferenceTime, preProcessingTime: $preProcessingTime}';
  }
}
