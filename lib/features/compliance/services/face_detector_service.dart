import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:onnxruntime/onnxruntime.dart';

import '../models/face_box.dart';
import 'image_tensor_converter.dart';
import 'onnx_loader.dart';
import 'scrfd_decoder.dart';

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

      final bytes =
          await File(imagePath)
              .readAsBytes();

      final image =
          img.decodeImage(bytes);

      if (image == null) {
        return FaceDetectionResult.empty();
      }

      final input =
          ImageTensorConverter
              .imageToTensor(image);

      final tensor =
          OrtValueTensor
              .createTensorWithDataList(
        input,
        [1, 3, 640, 640],
      );

      final runOptions =
          OrtRunOptions();

      final outputs = session.run(
        runOptions,
        {'input.1': tensor},
      );

      final s8 =
          outputs[0]!.value
              as List<List<double>>;
      final b8 =
          outputs[1]!.value
              as List<List<double>>;

      final s16 =
          outputs[3]!.value
              as List<List<double>>;
      final b16 =
          outputs[4]!.value
              as List<List<double>>;

      final s32 =
          outputs[6]!.value
              as List<List<double>>;
      final b32 =
          outputs[7]!.value
              as List<List<double>>;

      final faces = <FaceBox>[];

      final f8 =
          ScrfdDecoder.bestFace(
        s8,
        b8,
        8,
      );

      final f16 =
          ScrfdDecoder.bestFace(
        s16,
        b16,
        16,
      );

      final f32 =
          ScrfdDecoder.bestFace(
        s32,
        b32,
        32,
      );

      if (f8 != null) faces.add(f8);
      if (f16 != null) faces.add(f16);
      if (f32 != null) faces.add(f32);

      tensor.release();
      runOptions.release();

      for (final o in outputs) {
        o?.release();
      }

      if (faces.isEmpty) {
        debugPrint(
          'SCRFD FACE => NONE',
        );
        return FaceDetectionResult.empty();
      }

      faces.sort((a, b) {
        double score(FaceBox f) {
          final centerX =
              (f.x1 + f.x2) / 2;

          final centerY =
              (f.y1 + f.y2) / 2;

          final dx =
              (centerX - 320).abs();

          final dy =
              (centerY - 320).abs();

          final distancePenalty =
              (dx + dy) / 640.0;

          final areaBonus =
              f.area /
                  (640.0 * 640.0);

          return areaBonus -
              distancePenalty;
        }

        return score(b)
            .compareTo(score(a));
      });

      final candidates =
          faces.where((f) {
        return f.width > 120 &&
            f.height > 120 &&
            f.width < 520 &&
            f.height < 520;
      }).toList();

      final best =
          candidates.isNotEmpty
              ? candidates.first
              : faces.first;

      final expandedX =
          (best.x1 -
                  best.width * 0.15)
              .clamp(0.0, 640.0);

      final expandedY =
          (best.y1 -
                  best.height * 0.12)
              .clamp(8.0, 640.0);

      final expandedW =
          (best.width * 1.30)
              .clamp(0.0, 640.0);

      final expandedH =
          (best.height * 1.45)
              .clamp(0.0, 640.0);

      final result =
          FaceDetectionResult(
        faceFound: true,
        x: expandedX / 640,
        y: expandedY / 640,
        width: expandedW / 640,
        height: expandedH / 640,
      );

      debugPrint(
        'FACE BOX => '
        '${best.x1} '
        '${best.y1} '
        '${best.x2} '
        '${best.y2}',
      );

      debugPrint(
        'SCRFD FACE => '
        '${result.x} '
        '${result.y} '
        '${result.width} '
        '${result.height}',
      );

      return result;
    } catch (e, s) {
      debugPrint(
        'FACE DETECTOR ERROR: $e',
      );
      debugPrint('$s');

      return FaceDetectionResult.empty();
    }
  }
}