import 'dart:async';

import 'package:flutter/material.dart';

import '../../templates/models/document_crop_profile.dart';
import '../models/workspace_image.dart';
import '../models/workspace_state.dart';
import '../services/workspace_service.dart';

class WorkspaceController extends ChangeNotifier {
  WorkspaceController({WorkspaceService? service})
    : _service = service ?? WorkspaceService();

  final WorkspaceService _service;
  final List<WorkspaceState> _redoStack = [];

  WorkspaceState _state = WorkspaceState.empty;
  Offset _offset = Offset.zero;
  DocumentCropProfile _profile = DocumentCropProfile.turkeyBiometric;

  WorkspaceState get state => _state;
  WorkspaceImage? get originalImage => _state.originalImage;
  WorkspaceImage? get workingImage => _state.workingImage;
  WorkspaceImage? get previewImage => _state.previewImage;
  int? get imageWidth => _state.imageWidth;
  int? get imageHeight => _state.imageHeight;
  String? get fileName => _state.fileName;
  double get rotation => _state.rotation;
  Rect? get cropRect => _state.cropRect;
  List<WorkspaceState> get history => _state.history;

  String? get imagePath => _state.workingImage?.path;
  bool get hasImage => imagePath != null;
  double get scale => _state.zoom;
  double get zoomValue => _state.zoom;
  Offset get offset => _offset;
  DocumentCropProfile get profile => _profile;

  Future<void> loadImage(String imagePath) async {
    final image = await _service.buildImage(imagePath);
    _replaceState(
      WorkspaceState(
        originalImage: image,
        workingImage: image,
        previewImage: image,
        imageWidth: image.width,
        imageHeight: image.height,
        fileName: image.fileName,
      ),
      recordHistory: false,
    );
    _offset = Offset.zero;
  }

  void setImage(String imagePath) {
    unawaited(loadImage(imagePath));
  }

  void setWorkingImage(WorkspaceImage image) {
    _replaceState(
      _state.copyWith(
        workingImage: image,
        imageWidth: image.width,
        imageHeight: image.height,
        fileName: image.fileName,
      ),
    );
  }

  void setPreviewImage(WorkspaceImage image) {
    _replaceState(_state.copyWith(previewImage: image));
  }

  void rotate([double degrees = 90]) {
    _replaceState(_state.copyWith(rotation: _state.rotation + degrees));
  }

  void zoom(double value) {
    _replaceState(_state.copyWith(zoom: value.clamp(0.5, 3.0)));
  }

  void reset() {
    _offset = Offset.zero;
    _replaceState(
      _state.copyWith(zoom: 1.0, rotation: 0.0, clearCropRect: true),
    );
  }

  void undo() {
    if (_state.history.isEmpty) {
      return;
    }

    _redoStack.add(_state.copyWith(history: const []));
    final previous = _state.history.last;
    final remaining = _state.history.sublist(0, _state.history.length - 1);
    _state = previous.copyWith(history: remaining);
    _service.save(_state);
    notifyListeners();
  }

  void redo() {
    if (_redoStack.isEmpty) {
      return;
    }

    final next = _redoStack.removeLast();
    _replaceState(next);
  }

  void clear() {
    _offset = Offset.zero;
    _replaceState(
      WorkspaceState.empty.copyWith(clearImages: true),
      recordHistory: false,
    );
  }

  void resetTransform() {
    _offset = Offset.zero;
    _replaceState(_state.copyWith(zoom: 1.0), recordHistory: false);
  }

  void updateTransform({required double scale, required Offset offset}) {
    _offset = offset;
    _replaceState(
      _state.copyWith(zoom: scale.clamp(0.5, 3.0)),
      recordHistory: false,
    );
  }

  void setScale(double value) {
    zoom(value);
  }

  void setOffset(Offset value) {
    _offset = value;
    notifyListeners();
  }

  void move(double dx, double dy) {
    _offset = Offset(_offset.dx + dx, _offset.dy + dy);
    notifyListeners();
  }

  void setProfile(DocumentCropProfile profile) {
    _profile = profile;
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
    final eyeLine = faceY + (faceHeight * 0.35);

    double newScale = targetHeadRatio / faceHeight;
    newScale = newScale.clamp(0.70, 2.20);

    final dx = (0.5 - faceCenterX) * 1300;
    final dy = (targetEyeRatio - eyeLine) * 1300;

    _offset = Offset(dx.clamp(-700.0, 700.0), dy.clamp(-700.0, 700.0));
    _replaceState(
      _state.copyWith(
        zoom: newScale,
        cropRect: Rect.fromLTWH(faceX, faceY, faceWidth, faceHeight),
      ),
    );
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

  void _replaceState(WorkspaceState state, {bool recordHistory = true}) {
    final history = recordHistory
        ? [..._state.history, _state.copyWith(history: const [])]
        : state.history;

    _state = state.copyWith(history: history);
    _service.save(_state);
    if (recordHistory) {
      _redoStack.clear();
    }
    notifyListeners();
  }
}
