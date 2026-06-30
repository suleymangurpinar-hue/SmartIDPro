class FaceAnalysisModel {
  final double eyeAngle;
  final double headAngle;
  final double faceRatio;
  final double symmetry;
  final bool backgroundPass;
  final bool lightingPass;

  const FaceAnalysisModel({
    required this.eyeAngle,
    required this.headAngle,
    required this.faceRatio,
    required this.symmetry,
    required this.backgroundPass,
    required this.lightingPass,
  });

  factory FaceAnalysisModel.demo() {
    return const FaceAnalysisModel(
      eyeAngle: 0.1,
      headAngle: 0.2,
      faceRatio: 74.0,
      symmetry: 98.8,
      backgroundPass: true,
      lightingPass: true,
    );
  }
}
