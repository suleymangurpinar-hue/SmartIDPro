import '../models/face_box.dart';

class ScrfdDecoder {
  static FaceBox? bestFace(
    List<List<double>> scores,
    List<List<double>> boxes,
    int stride,
  ) {
    double bestScore = 0;
    FaceBox? best;

    final featureWidth = 640 ~/ stride;
    const anchors = 2;

    final count = scores.length < boxes.length ? scores.length : boxes.length;

    for (int i = 0; i < count; i++) {
      final score = scores[i][0];

      if (score < 0.60) {
        continue;
      }

      final box = boxes[i];

      final anchorIndex = i ~/ anchors;

      final x = anchorIndex % featureWidth;
      final y = anchorIndex ~/ featureWidth;

      final cx = (x + 0.5) * stride;
      final cy = (y + 0.5) * stride;

      final l = box[0] * stride;
      final t = box[1] * stride;
      final r = box[2] * stride;
      final b = box[3] * stride;

      final x1 = cx - l;
      final y1 = cy - t;
      final x2 = cx + r;
      final y2 = cy + b;

      final width = x2 - x1;
      final height = y2 - y1;

      if (width < 40 || height < 40) {
        continue;
      }

      if (score > bestScore) {
        bestScore = score;

        best = FaceBox(
          x1: x1.clamp(0.0, 640.0),
          y1: y1.clamp(0.0, 640.0),
          x2: x2.clamp(0.0, 640.0),
          y2: y2.clamp(0.0, 640.0),
          score: score,
        );
      }
    }

    return best;
  }
}
