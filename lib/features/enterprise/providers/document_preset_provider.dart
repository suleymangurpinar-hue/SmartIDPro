import 'package:flutter/material.dart';
import '../services/document_presets.dart';

class DocumentPresetProvider extends ChangeNotifier {
  DocumentPreset _selected =
      DocumentPresets.turkeyBiometric;

  DocumentPreset get selected =>
      _selected;

  String get paperSize =>
      _selected.paper;

  int get autoLayout =>
      _selected.layout;

  double get targetHeadRatio {
    final name =
        _selected.name.toLowerCase();

    if (name.contains('usa')) {
      return 0.76;
    }

    if (name.contains('nikah')) {
      return 0.50;
    }

    if (name.contains('passport')) {
      return 0.72;
    }

    if (name.contains('biyometrik')) {
      return 0.66;
    }

    return 0.70;
  }

  double get targetEyeRatio {
    final name =
        _selected.name.toLowerCase();

    if (name.contains('usa')) {
      return 0.44;
    }

    if (name.contains('nikah')) {
      return 0.50;
    }

    if (name.contains('passport')) {
      return 0.45;
    }

    if (name.contains('biyometrik')) {
      return 0.46;
    }

    return 0.46;
  }

  double get photoAspectRatio {
    return _selected.widthMm /
        _selected.heightMm;
  }

  void changePreset(
    DocumentPreset preset,
  ) {
    _selected = preset;
    notifyListeners();
  }
}