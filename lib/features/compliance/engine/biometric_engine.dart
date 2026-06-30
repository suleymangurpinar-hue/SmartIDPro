import 'dart:io';

import 'package:image/image.dart' as img;

import '../services/face_detector_service.dart';
import '../services/face_landmark_service.dart';
import '../services/icao_engine.dart';

import 'face_analysis_result.dart';

class BiometricEngine {
  final FaceDetectorService _faceDetector = FaceDetectorService();

  final FaceLandmarkService _landmarkService = FaceLandmarkService();

  final IcaoEngine _icaoEngine = IcaoEngine();

  Future<FaceAnalysisResult> analyze(String imagePath) async {
    final file = File(imagePath);

    if (!file.existsSync()) {
      return FaceAnalysisResult.empty();
    }

    final bytes = await file.readAsBytes();

    final image = img.decodeImage(bytes);

    if (image == null) {
      return FaceAnalysisResult.empty();
    }

    final face = await _faceDetector.detectFace(imagePath);

    if (!face.faceFound) {
      return FaceAnalysisResult.empty();
    }

    final landmarks = await _landmarkService.detectLandmarks(imagePath);

    final icao = _icaoEngine.evaluate(
      eyeY: landmarks.leftEyeY,
      faceHeight: face.height,
    );

    final resolutionScore = _calculateResolutionScore(
      image.width,
      image.height,
    );

    final backgroundScore = _calculateBackgroundScore(image);

    final overallScore =
        (icao.eyeScore + icao.headScore + resolutionScore + backgroundScore) /
        4;

    return FaceAnalysisResult(
      photoLoaded: true,
      faceDetected: true,

      eyePositionOk: icao.eyeScore >= 80,

      headRatioOk: icao.headScore >= 80,

      backgroundOk: backgroundScore >= 70,

      icaoReady: overallScore >= 85,

      overallScore: overallScore,

      eyeScore: icao.eyeScore,

      headScore: icao.headScore,

      backgroundScore: backgroundScore,

      resolutionScore: resolutionScore,

      faceX: face.x,
      faceY: face.y,

      faceWidth: face.width,
      faceHeight: face.height,
    );
  }

  double _calculateResolutionScore(int width, int height) {
    final megapixel = (width * height) / 1000000;

    if (megapixel >= 8) {
      return 100;
    }

    if (megapixel >= 4) {
      return 90;
    }

    if (megapixel >= 2) {
      return 80;
    }

    return 60;
  }

  double _calculateBackgroundScore(img.Image image) {
    final width = image.width;
    final height = image.height;

    double brightness = 0;
    int count = 0;

    final step = (width ~/ 80).clamp(1, 20);

    for (int y = 0; y < height; y += step) {
      for (int x = 0; x < width; x += step) {
        final pixel = image.getPixel(x, y);

        brightness += (pixel.r + pixel.g + pixel.b) / 3;

        count++;
      }
    }

    if (count == 0) {
      return 0;
    }

    brightness /= count;

    if (brightness > 220) {
      return 100;
    }

    if (brightness > 180) {
      return 90;
    }

    if (brightness > 140) {
      return 75;
    }

    return 55;
  }
}
