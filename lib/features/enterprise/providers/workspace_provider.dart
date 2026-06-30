import 'package:flutter/material.dart';

class WorkspaceProvider extends ChangeNotifier {
  String? _imagePath;

  double _scale = 1;
  Offset _offset = Offset.zero;

  String? get imagePath => _imagePath;
  double get scale => _scale;
  Offset get offset => _offset;

  void setImage(String path) {
    _imagePath = path;
    _scale = 1;
    _offset = Offset.zero;
    notifyListeners();
  }

  void applyAutoCrop({
    required double scale,
    required Offset offset,
  }) {
    _scale = scale;
    _offset = offset;
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
    final scale =
        targetHeadRatio / faceHeight;

    final centerX =
        faceX + (faceWidth / 2);

    final dx =
        (0.50 - centerX) * 900;

    final dy =
        (targetEyeRatio - faceY) * 900;

    _scale = scale;
    _offset = Offset(dx, dy);

    notifyListeners();
  }

  void resetTransform() {
    _scale = 1;
    _offset = Offset.zero;
    notifyListeners();
  }

  void clear() {
    _imagePath = null;
    _scale = 1;
    _offset = Offset.zero;
    notifyListeners();
  }
}