import 'package:flutter/foundation.dart';

import '../../compliance/models/face_box.dart';

class OnnxFaceDetectorService {
  static const int inputSize = 640;

  Future<void> init() async {}

  Future<List<FaceBox>> detectFaces(
    Float32List inputTensor, {
    required int imageWidth,
    required int imageHeight,
  }) async {
    debugPrint('==============================');
    debugPrint('TEST DETECTOR CALLED');
    debugPrint('WIDTH : $imageWidth');
    debugPrint('HEIGHT: $imageHeight');
    debugPrint('==============================');

    return [];
  }

  void dispose() {}
}
