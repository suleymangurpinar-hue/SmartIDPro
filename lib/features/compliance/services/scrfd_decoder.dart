import '../models/face_box.dart';

class ScrfdDecoder {
  static FaceBox? bestFace(
    List<List<double>> scores,
    List<List<double>> boxes,
    int stride,
  ) {
    FaceBox? best;

    final featureWidth = 640 ~/ stride;
    const anchors = 2;

    final count =
        scores.length < boxes.length
            ? scores.length
            : boxes.length;

    for (int i = 0; i < count; i++) {
      if (scores[i].isEmpty) continue;

      final score = scores[i][0];

      if (score < 0.45) continue;

      final box = boxes[i];

      if (box.length < 4) continue;

      final anchorIndex = i ~/ anchors;

      final x = anchorIndex % featureWidth;
      final y = anchorIndex ~/ featureWidth;

      final cx = (x + 0.5) * stride;
      final cy = (y + 0.5) * stride;

      final l = box[0] * stride;
      final t = box[1] * stride;
      final r = box[2] * stride;
      final b = box[3] * stride;

      final x1 =
          (cx - l).clamp(0.0, 640.0);

      final y1 =
          (cy - t).clamp(0.0, 640.0);

      final x2 =
          (cx + r).clamp(0.0, 640.0);

      final y2 =
          (cy + b).clamp(0.0, 640.0);

      final width = x2 - x1;
      final height = y2 - y1;

      if (width < 80 ||
          height < 80) {
        continue;
      }

      final ratio = width / height;

      if (ratio < 0.55 ||
          ratio > 1.60) {
        continue;
      }

      final candidate = FaceBox(
        x1: x1,
        y1: y1,
        x2: x2,
        y2: y2,
        score: score,
      );

      if (best == null) {
        best = candidate;
        continue;
      }

      final candidateValue =
          candidate.area *
              candidate.score;

      final bestValue =
          best.area * best.score;

      if (candidateValue >
          bestValue) {
        best = candidate;
      }
    }

    return best;
  }
}