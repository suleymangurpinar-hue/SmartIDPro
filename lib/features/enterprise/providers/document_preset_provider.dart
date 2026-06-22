import 'package:flutter/material.dart';

import '../services/document_presets.dart';

class DocumentPresetProvider
    extends ChangeNotifier {
  DocumentPreset selected =
      DocumentPresets.turkeyBiometric;

  void changePreset(
    DocumentPreset preset,
  ) {
    selected = preset;
    notifyListeners();
  }
}