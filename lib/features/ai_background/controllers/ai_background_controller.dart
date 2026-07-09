import 'package:flutter/foundation.dart';

import '../data/background_library.dart';
import '../models/background_category.dart';
import '../models/background_item.dart';
import '../models/background_result.dart';
import '../services/ai_background_service.dart';
import '../services/mock_ai_background_service.dart';

class AiBackgroundController extends ChangeNotifier {
  AiBackgroundController({AiBackgroundService? service})
    : _service = service ?? MockAiBackgroundService() {
    _selectedBackground = backgroundItems.isNotEmpty
        ? backgroundItems.first
        : null;
  }

  final AiBackgroundService _service;

  BackgroundCategory _currentCategory = BackgroundCategory.solid;
  BackgroundItem? _selectedBackground;
  BackgroundStatus _engineStatus = BackgroundStatus.idle;

  BackgroundCategory get currentCategory => _currentCategory;
  BackgroundItem? get selectedBackground => _selectedBackground;
  BackgroundStatus get engineStatus => _engineStatus;

  List<BackgroundItem> get backgroundItems {
    return BackgroundLibrary.items;
  }

  void setCategory(BackgroundCategory category) {
    if (_currentCategory == category) {
      return;
    }

    _currentCategory = category;
    notifyListeners();
  }

  void selectBackground(BackgroundItem item) {
    if (_selectedBackground == item) {
      return;
    }

    _selectedBackground = item;
    notifyListeners();
  }

  Future<void> generate() async {
    _setEngineStatus(BackgroundStatus.preparing);
    await Future<void>.delayed(const Duration(milliseconds: 250));

    _setEngineStatus(BackgroundStatus.processing);

    try {
      final result = await _service.generate();
      _selectedBackground = result.selectedItem ?? _selectedBackground;
      _setEngineStatus(result.status);
    } catch (_) {
      _setEngineStatus(BackgroundStatus.failed);
    }
  }

  void _setEngineStatus(BackgroundStatus status) {
    _engineStatus = status;
    notifyListeners();
  }
}
