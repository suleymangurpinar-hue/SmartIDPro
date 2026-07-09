import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:image/image.dart' as img;

import '../models/face_analysis_result.dart';
import 'onnx_face_detector_service.dart';

class FaceAnalysisService {
  Future<FaceAnalysisResult> analyze(
    String imagePath,
  ) async {
    try {
      final detector =
          OnnxFaceDetectorService();

      await detector.init();

      final bytes =
          await File(imagePath)
              .readAsBytes();

      final image =
          img.decodeImage(bytes);

      if (image == null) {
        return FaceAnalysisResult.empty();
      }

      final tensor =
          _createInputTensor(image);

      final faces =
          await detector.detectFaces(
        tensor,
        imageWidth: image.width,
        imageHeight: image.height,
      );

      if (faces.isEmpty) {
        return FaceAnalysisResult.empty();
      }

      faces.sort((a, b) {
        double score(dynamic f) {
          final centerX =
              (f.x1 + f.x2) / 2;

          final centerY =
              (f.y1 + f.y2) / 2;

          final dx =
              (centerX -
                      image.width / 2)
                  .abs();

          final dy =
              (centerY -
                      image.height / 2)
                  .abs();

          final distancePenalty =
              (dx + dy);

          return f.area -
              distancePenalty;
        }

        return score(b)
            .compareTo(score(a));
      });

      final face = faces.first;

      final faceRect =
          Rect.fromLTRB(
        face.x1,
        face.y1,
        face.x2,
        face.y2,
      );

      final leftEye = Offset(
        faceRect.left +
            faceRect.width * 0.34,
        faceRect.top +
            faceRect.height * 0.42,
      );

      final rightEye = Offset(
        faceRect.left +
            faceRect.width * 0.66,
        faceRect.top +
            faceRect.height * 0.42,
      );

      final imageHeight =
          image.height.toDouble();

      final headRatio =
          faceRect.height /
              imageHeight;

      final eyeLineRatio =
          leftEye.dy /
              imageHeight;

      return FaceAnalysisResult(
        faceDetected: true,
        faceRect: faceRect,
        leftEye: leftEye,
        rightEye: rightEye,
        headRatio: headRatio,
        eyeLineRatio:
            eyeLineRatio,
        resolutionScore: 100,
        backgroundScore: 95,
        centeringScore: 100,
        overallScore: 95,
        isCompliant: true,
      );
    } catch (_) {
      return FaceAnalysisResult.empty();
    }
  }

  Float32List _createInputTensor(
    img.Image image,
  ) {
    final resized =
        img.copyResize(
      image,
      width:
          OnnxFaceDetectorService
              .inputSize,
      height:
          OnnxFaceDetectorService
              .inputSize,
    );

    final tensor =
        Float32List(
      1 *
          3 *
          OnnxFaceDetectorService
              .inputSize *
          OnnxFaceDetectorService
              .inputSize,
    );

    int r = 0;
    int g =
        OnnxFaceDetectorService
                .inputSize *
            OnnxFaceDetectorService
                .inputSize;
    int b = g * 2;

    for (int y = 0;
        y < resized.height;
        y++) {
      for (int x = 0;
          x < resized.width;
          x++) {
        final p =
            resized.getPixel(
          x,
          y,
        );

        tensor[r++] =
            p.r / 255.0;

        tensor[g++] =
            p.g / 255.0;

        tensor[b++] =
            p.b / 255.0;
      }
    }

    return tensor;
  }
}