import 'package:flutter/material.dart';

import '../engine/biometric_engine.dart';
import '../engine/face_analysis_result.dart';

class ComplianceProvider extends ChangeNotifier {
  final BiometricEngine _engine = BiometricEngine();

  FaceAnalysisResult _result =
      FaceAnalysisResult.empty();

  bool _loading = false;

  FaceAnalysisResult get result => _result;

  bool get loading => _loading;

  Future<void> analyzePhoto(
    String imagePath,
  ) async {
    _loading = true;
    notifyListeners();

    _result =
        await _engine.analyze(imagePath);

    _loading = false;
    notifyListeners();
  }

  void clear() {
    _result =
        FaceAnalysisResult.empty();

    notifyListeners();
  }
}