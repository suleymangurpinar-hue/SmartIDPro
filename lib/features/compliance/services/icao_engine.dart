class IcaoResult {
  final double eyeScore;
  final double headScore;
  final double overallScore;
  final bool icaoReady;

  const IcaoResult({
    required this.eyeScore,
    required this.headScore,
    required this.overallScore,
    required this.icaoReady,
  });
}

class IcaoEngine {
  IcaoResult evaluate({
    required double eyeY,
    required double faceHeight,
    double minHead = 70,
    double maxHead = 80,
    double minEye = 28,
    double maxEye = 35,
  }) {
    final headPercent =
        faceHeight * 100;

    final eyePercent =
        eyeY * 100;

    final headDiff =
        (75 - headPercent).abs();

    final eyeDiff =
        (31.5 - eyePercent).abs();

    final headScore =
        (100 - (headDiff * 4))
            .clamp(0, 100)
            .toDouble();

    final eyeScore =
        (100 - (eyeDiff * 5))
            .clamp(0, 100)
            .toDouble();

    final overall =
        (headScore + eyeScore) / 2;

    return IcaoResult(
      eyeScore: eyeScore,
      headScore: headScore,
      overallScore: overall,
      icaoReady: overall >= 85,
    );
  }
}