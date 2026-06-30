import 'package:flutter/material.dart';

import '../models/face_analysis_model.dart';

class FaceAnalysisProvider extends ChangeNotifier {
  FaceAnalysisModel _result = FaceAnalysisModel.demo();

  bool _isAnalyzing = false;

  bool _faceDetected = false;

  FaceAnalysisModel get result => _result;

  bool get isAnalyzing => _isAnalyzing;

  bool get faceDetected => _faceDetected;

  Future<void> analyzePhoto(String imagePath) async {
    _isAnalyzing = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _faceDetected = true;

    _result = FaceAnalysisModel(
      eyeAngle: 0.12,
      headAngle: 0.18,
      faceRatio: 74.6,
      symmetry: 98.9,
      backgroundPass: true,
      lightingPass: true,
    );

    _isAnalyzing = false;

    notifyListeners();
  }

  void reset() {
    _faceDetected = false;

    _isAnalyzing = false;

    _result = FaceAnalysisModel.demo();

    notifyListeners();
  }
}
