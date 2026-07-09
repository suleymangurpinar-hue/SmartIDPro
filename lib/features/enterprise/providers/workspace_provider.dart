import 'package:flutter/material.dart';

class WorkspaceProvider extends ChangeNotifier {
  String? _imagePath;

  double _scale = 1.0;
  Offset _offset = Offset.zero;

  String? get imagePath => _imagePath;
  double get scale => _scale;
  Offset get offset => _offset;

  void setImage(String path) {
    _imagePath = path;
    _scale = 1.0;
    _offset = Offset.zero;
    notifyListeners();
  }

  void calculateAutoCrop({
    required double faceX,
    required double faceY,
    required double faceWidth,
    required double faceHeight,
    required double targetHeadRatio,
    required double targetEyeRatio,
  }) {
    if (faceWidth <= 0 || faceHeight <= 0) {
      resetTransform();
      return;
    }

    final faceCenterX = faceX + (faceWidth / 2);
    final eyeLine = faceY + (faceHeight * 0.38);

    double desiredScale = targetHeadRatio / faceHeight;

    desiredScale = desiredScale.clamp(
      1.0,
      1.35,
    );

    final dx = (0.5 - faceCenterX) * 120;
    final dy = (targetEyeRatio - eyeLine) * 120;

    _scale = desiredScale;

    _offset = Offset(
      dx.clamp(-120.0, 120.0),
      dy.clamp(-120.0, 120.0),
    );

    notifyListeners();
  }

  void updateTransform({
    required double scale,
    required Offset offset,
  }) {
    _scale = scale.clamp(
      1.0,
      1.35,
    );

    _offset = offset;

    notifyListeners();
  }

  void resetTransform() {
    _scale = 1.0;
    _offset = Offset.zero;
    notifyListeners();
  }

  void clear() {
    _imagePath = null;
    _scale = 1.0;
    _offset = Offset.zero;
    notifyListeners();
  }
}