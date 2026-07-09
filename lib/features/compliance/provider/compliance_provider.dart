import 'package:flutter/material.dart';

import '../../biometric/models/face_analysis_result.dart';
import '../../biometric/services/biometric_engine.dart';

class ComplianceProvider extends ChangeNotifier {
  final BiometricEngine _engine =
      BiometricEngine();

  FaceAnalysisResult _result =
      FaceAnalysisResult.empty();

  bool _loading = false;

  FaceAnalysisResult get result =>
      _result;

  bool get loading => _loading;

  Future<void> analyzePhoto(
    String imagePath, {
    double imageWidth = 0,
    double imageHeight = 0,
  }) async {
    _loading = true;
    notifyListeners();

    final process =
        await _engine.analyze(
      imagePath,
      imageWidth,
      imageHeight,
    );

    _result =
        process?.analysis ??
            FaceAnalysisResult.empty();

    _loading = false;
    notifyListeners();
  }

  void clear() {
    _result =
        FaceAnalysisResult.empty();

    notifyListeners();
  }
}