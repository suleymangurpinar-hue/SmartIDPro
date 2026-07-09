import 'dart:ui';

class FaceAnalysisResult {
  final bool faceDetected;

  final Rect faceRect;

  final Offset leftEye;
  final Offset rightEye;

  final double headRatio;
  final double eyeLineRatio;

  final double resolutionScore;
  final double backgroundScore;
  final double centeringScore;
  final double overallScore;

  final bool isCompliant;

  const FaceAnalysisResult({
    required this.faceDetected,
    required this.faceRect,
    required this.leftEye,
    required this.rightEye,
    required this.headRatio,
    required this.eyeLineRatio,
    required this.resolutionScore,
    required this.backgroundScore,
    required this.centeringScore,
    required this.overallScore,
    required this.isCompliant,
  });

  double get eyeScore {
    final diff =
        (eyeLineRatio - 0.40).abs();

    final score =
        (100 - diff * 500);

    return score.clamp(0, 100);
  }

  double get headScore {
    final diff =
        (headRatio - 0.75).abs();

    final score =
        (100 - diff * 400);

    return score.clamp(0, 100);
  }

  bool get icaoReady =>
      isCompliant &&
      faceDetected &&
      overallScore >= 80;

  factory FaceAnalysisResult.empty() {
    return FaceAnalysisResult(
      faceDetected: false,
      faceRect: Rect.zero,
      leftEye: Offset.zero,
      rightEye: Offset.zero,
      headRatio: 0,
      eyeLineRatio: 0,
      resolutionScore: 0,
      backgroundScore: 0,
      centeringScore: 0,
      overallScore: 0,
      isCompliant: false,
    );
  }
}