import 'package:flutter/material.dart';
import '../services/document_presets.dart';

class DocumentPresetProvider extends ChangeNotifier {
  DocumentPreset _selected =
      DocumentPresets.turkeyBiometric;

  DocumentPreset get selected => _selected;

  String get paperSize =>
      _selected.paper;

  int get autoLayout =>
      _selected.layout;

  double get targetHeadRatio =>
      (_selected.headMinPercent +
          _selected.headMaxPercent) /
      200;

  double get targetEyeRatio {
    if (_selected.country == 'USA') {
      return 0.40;
    }

    return 0.38;
  }

  void changePreset(
    DocumentPreset preset,
  ) {
    _selected = preset;
    notifyListeners();
  }
}