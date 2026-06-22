class FaceLandmarkResult {
  final double leftEyeX;
  final double leftEyeY;

  final double rightEyeX;
  final double rightEyeY;

  final double noseX;
  final double noseY;

  const FaceLandmarkResult({
    required this.leftEyeX,
    required this.leftEyeY,
    required this.rightEyeX,
    required this.rightEyeY,
    required this.noseX,
    required this.noseY,
  });
}

class FaceLandmarkService {
  Future<FaceLandmarkResult> detectLandmarks(
    String imagePath,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: 200),
    );

    return const FaceLandmarkResult(
      leftEyeX: 0.43,
      leftEyeY: 0.36,
      rightEyeX: 0.57,
      rightEyeY: 0.36,
      noseX: 0.50,
      noseY: 0.48,
    );
  }
}