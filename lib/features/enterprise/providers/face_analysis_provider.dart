import 'package:flutter/material.dart';

import '../models/face_analysis_model.dart';

class FaceAnalysisProvider extends ChangeNotifier {
  FaceAnalysisModel _result =
      FaceAnalysisModel.demo();

  bool _isAnalyzing = false;
  bool _faceDetected = false;

  FaceAnalysisModel get result =>
      _result;

  bool get isAnalyzing =>
      _isAnalyzing;

  bool get faceDetected =>
      _faceDetected;

  double get score =>
      _result.symmetry;

  bool get backgroundPass =>
      _result.backgroundPass;

  bool get lightingPass =>
      _result.lightingPass;

  Future<void> analyzePhoto(
    String imagePath,
  ) async {
    _isAnalyzing = true;
    notifyListeners();

    await Future.delayed(
      const Duration(
        milliseconds: 800,
      ),
    );

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

  void setResult(
    FaceAnalysisModel value,
  ) {
    _result = value;
    _faceDetected = true;
    notifyListeners();
  }

  void reset() {
    _result =
        FaceAnalysisModel.demo();

    _isAnalyzing = false;
    _faceDetected = false;

    notifyListeners();
  }
}