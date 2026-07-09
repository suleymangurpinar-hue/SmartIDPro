import 'package:flutter/material.dart';

import '../../templates/models/document_crop_profile.dart';

class WorkspaceProvider extends ChangeNotifier {
  String? _imagePath;

  double _scale = 1.0;
  Offset _offset = Offset.zero;

  DocumentCropProfile _profile =
      DocumentCropProfile.turkeyBiometric;

  String? get imagePath => _imagePath;

  double get scale => _scale;

  Offset get offset => _offset;

  DocumentCropProfile get profile => _profile;

  bool get hasImage => _imagePath != null;

  void setImage(String path) {
    _imagePath = path;
    resetTransform();
    notifyListeners();
  }

  void clear() {
    _imagePath = null;
    resetTransform();
    notifyListeners();
  }

  void setProfile(
    DocumentCropProfile profile,
  ) {
    _profile = profile;
    notifyListeners();
  }

  void resetTransform() {
    _scale = 1.0;
    _offset = Offset.zero;
  }

  void setScale(double value) {
    _scale = value;
    notifyListeners();
  }

  void setOffset(Offset value) {
    _offset = value;
    notifyListeners();
  }

  void move(double dx, double dy) {
    _offset = Offset(
      _offset.dx + dx,
      _offset.dy + dy,
    );

    notifyListeners();
  }

  void zoom(double value) {
    _scale = value.clamp(
      0.5,
      3.0,
    );

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
      return;
    }

    final faceCenterX =
        faceX + (faceWidth / 2);

    final eyeLine =
        faceY + (faceHeight * 0.35);

    double newScale =
        targetHeadRatio / faceHeight;

    newScale = newScale.clamp(
      0.70,
      2.20,
    );

    final dx =
        (0.5 - faceCenterX) * 1300;

    final dy =
        (targetEyeRatio - eyeLine) * 1300;

    _scale = newScale;

    _offset = Offset(
      dx.clamp(
        -700.0,
        700.0,
      ),
      dy.clamp(
        -700.0,
        700.0,
      ),
    );

    notifyListeners();
  }

  void applyAutoCrop({
    required double faceX,
    required double faceY,
    required double faceWidth,
    required double faceHeight,
  }) {
    calculateAutoCrop(
      faceX: faceX,
      faceY: faceY,
      faceWidth: faceWidth,
      faceHeight: faceHeight,
      targetHeadRatio: _profile.headRatio,
      targetEyeRatio: _profile.eyeRatio,
    );
  }
}