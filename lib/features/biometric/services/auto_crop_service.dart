import 'dart:ui';

import '../models/face_analysis_result.dart';

class AutoCropResult {
  final double scale;
  final Offset offset;

  const AutoCropResult({
    required this.scale,
    required this.offset,
  });
}

class AutoCropService {
  const AutoCropService();

  AutoCropResult calculate(
    FaceAnalysisResult result, {
    required double imageWidth,
    required double imageHeight,
    double targetHeadRatio = 0.76,
    double targetEyeLineRatio = 0.53,
  }) {
    if (!result.faceDetected ||
        imageWidth <= 0 ||
        imageHeight <= 0) {
      return const AutoCropResult(
        scale: 1.0,
        offset: Offset.zero,
      );
    }

    final face = result.faceRect;

    final scale =
        (targetHeadRatio / result.headRatio)
            .clamp(0.80, 3.00);

    final centerX =
        face.center.dx / imageWidth;

    final eyeCenter =
        (result.leftEye.dy +
                result.rightEye.dy) /
            2;

    final currentEyeRatio =
        eyeCenter / imageHeight;

    final dx =
        (0.5 - centerX) *
            imageWidth;

    final dy =
        (targetEyeLineRatio -
                currentEyeRatio) *
            imageHeight;

    return AutoCropResult(
      scale: scale,
      offset: Offset(dx, dy),
    );
  }
}