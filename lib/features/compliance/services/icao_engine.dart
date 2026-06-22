class IcaoResult {
  final double eyeScore;
  final double headScore;
  final bool icaoReady;

  const IcaoResult({
    required this.eyeScore,
    required this.headScore,
    required this.icaoReady,
  });
}

class IcaoEngine {
  IcaoResult evaluate({
    required double eyeY,
    required double faceHeight,
  }) {
    final eyeScore = 92.0;
    final headScore = 88.0;

    return IcaoResult(
      eyeScore: eyeScore,
      headScore: headScore,
      icaoReady: true,
    );
  }
}