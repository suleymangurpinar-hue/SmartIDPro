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
    final headPercent = faceHeight * 100;
    final eyePercent = eyeY * 100;

    final headOk =
        headPercent >= minHead &&
        headPercent <= maxHead;

    final eyeOk =
        eyePercent >= minEye &&
        eyePercent <= maxEye;

    final headScore = headOk ? 100.0 : 65.0;
    final eyeScore = eyeOk ? 100.0 : 65.0;

    final overall =
        (headScore + eyeScore) / 2;

    return IcaoResult(
      eyeScore: eyeScore,
      headScore: headScore,
      overallScore: overall,
      icaoReady: overall >= 90,
    );
  }
}