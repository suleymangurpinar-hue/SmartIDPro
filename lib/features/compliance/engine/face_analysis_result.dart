class FaceAnalysisResult {
  final bool photoLoaded;
  final bool faceDetected;

  final bool eyePositionOk;
  final bool headRatioOk;
  final bool backgroundOk;

  final bool icaoReady;

  final double overallScore;

  final double eyeScore;
  final double headScore;
  final double backgroundScore;
  final double resolutionScore;

  final double faceX;
  final double faceY;

  final double faceWidth;
  final double faceHeight;

  const FaceAnalysisResult({
    required this.photoLoaded,
    required this.faceDetected,

    required this.eyePositionOk,
    required this.headRatioOk,
    required this.backgroundOk,

    required this.icaoReady,

    required this.overallScore,

    required this.eyeScore,
    required this.headScore,
    required this.backgroundScore,
    required this.resolutionScore,

    required this.faceX,
    required this.faceY,

    required this.faceWidth,
    required this.faceHeight,
  });

  factory FaceAnalysisResult.empty() {
    return const FaceAnalysisResult(
      photoLoaded: false,
      faceDetected: false,

      eyePositionOk: false,
      headRatioOk: false,
      backgroundOk: false,

      icaoReady: false,

      overallScore: 0,

      eyeScore: 0,
      headScore: 0,
      backgroundScore: 0,
      resolutionScore: 0,

      faceX: 0,
      faceY: 0,

      faceWidth: 0,
      faceHeight: 0,
    );
  }
}
