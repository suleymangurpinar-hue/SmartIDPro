import 'package:flutter/material.dart';

import '../models/ai_engine_task_result.dart';
import '../models/raw_adjustments.dart';
import '../services/ai_background_engine.dart';
import '../services/ai_clothing_engine.dart';
import '../services/ai_retouch_engine.dart';

class RawStudioProvider extends ChangeNotifier {
  RawStudioProvider({
    AiBackgroundEngine? backgroundEngine,
    AiRetouchEngine? retouchEngine,
    AiClothingEngine? clothingEngine,
  }) : _backgroundEngine = backgroundEngine ?? AiBackgroundEngine(),
       _retouchEngine = retouchEngine ?? AiRetouchEngine(),
       _clothingEngine = clothingEngine ?? AiClothingEngine();

  final AiBackgroundEngine _backgroundEngine;
  final AiRetouchEngine _retouchEngine;
  final AiClothingEngine _clothingEngine;

  RawAdjustments _adjustments = const RawAdjustments();
  final List<AiEngineTaskResult> _tasks = [];

  String? _imagePath;
  bool _processing = false;
  String _retouchPreset = 'Studio';
  String _clothingCategory = 'Business';
  String _clothingStyle = 'Suit 1';
  int _backgroundColor = const Color(0xFFFFFFFF).toARGB32();

  RawAdjustments get adjustments => _adjustments;

  List<AiEngineTaskResult> get tasks => List.unmodifiable(_tasks);

  String? get imagePath => _imagePath;

  bool get processing => _processing;

  String get retouchPreset => _retouchPreset;

  String get clothingCategory => _clothingCategory;

  String get clothingStyle => _clothingStyle;

  int get backgroundColor => _backgroundColor;

  void setImage(String? path) {
    _imagePath = path;
    notifyListeners();
  }

  void updateAdjustments(RawAdjustments adjustments) {
    _adjustments = adjustments;
    notifyListeners();
  }

  void setRetouchPreset(String value) {
    _retouchPreset = value;
    notifyListeners();
  }

  void setClothing({required String category, required String style}) {
    _clothingCategory = category;
    _clothingStyle = style;
    notifyListeners();
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color.toARGB32();
    notifyListeners();
  }

  Future<void> queueBackground() async {
    await _run(
      () => _backgroundEngine.apply(
        AiBackgroundRequest(
          imagePath: _imagePath,
          mode: 'replace',
          colorValue: _backgroundColor,
        ),
      ),
    );
  }

  Future<void> queueRetouch() async {
    await _run(
      () => _retouchEngine.apply(
        AiRetouchRequest(
          imagePath: _imagePath,
          preset: _retouchPreset,
          skinSmoothing: 70,
          blemishRemoval: 65,
          underEyeCorrection: 50,
          shineRemoval: 55,
        ),
      ),
    );
  }

  Future<void> queueClothing() async {
    await _run(
      () => _clothingEngine.apply(
        AiClothingRequest(
          imagePath: _imagePath,
          category: _clothingCategory,
          style: _clothingStyle,
        ),
      ),
    );
  }

  Future<void> _run(Future<AiEngineTaskResult> Function() action) async {
    _processing = true;
    notifyListeners();

    final result = await action();
    _tasks.insert(0, result);

    _processing = false;
    notifyListeners();
  }
}
