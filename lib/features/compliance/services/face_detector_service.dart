import 'package:flutter/foundation.dart';

import 'onnx_loader.dart';

class FaceDetectionResult {
  final bool faceFound;

  final double x;
  final double y;

  final double width;
  final double height;

  const FaceDetectionResult({
    required this.faceFound,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  factory FaceDetectionResult.empty() {
    return const FaceDetectionResult(
      faceFound: false,
      x: 0,
      y: 0,
      width: 0,
      height: 0,
    );
  }
}

class FaceDetectorService {
  Future<FaceDetectionResult> detectFace(
    String imagePath,
  ) async {
    try {
      final session =
          await OnnxLoader.session();

      debugPrint(
        'ONNX SESSION LOADED: $session',
      );

      return const FaceDetectionResult(
        faceFound: true,
        x: 0.35,
        y: 0.18,
        width: 0.30,
        height: 0.48,
      );
    } catch (e) {
      debugPrint(
        'ONNX ERROR: $e',
      );

      return FaceDetectionResult.empty();
    }
  }
}