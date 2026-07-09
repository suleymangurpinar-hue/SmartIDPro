import 'package:flutter/foundation.dart';

import '../data/clothing_library.dart';
import '../models/clothing_category.dart';
import '../models/clothing_item.dart';
import '../models/clothing_result.dart';
import '../services/ai_clothing_service.dart';
import '../services/mock_ai_clothing_service.dart';

class AiClothingController extends ChangeNotifier {
  AiClothingController({AiClothingService? service})
    : _service = service ?? MockAiClothingService() {
    _selectedClothing = clothingItems.isNotEmpty ? clothingItems.first : null;
  }

  final AiClothingService _service;

  String _currentGender = 'male';
  ClothingCategory _currentCategory = ClothingCategory.business;
  ClothingItem? _selectedClothing;
  ClothingStatus _engineStatus = ClothingStatus.idle;

  String get currentGender => _currentGender;
  ClothingCategory get currentCategory => _currentCategory;
  ClothingItem? get selectedClothing => _selectedClothing;
  ClothingStatus get engineStatus => _engineStatus;

  List<ClothingItem> get clothingItems {
    return ClothingLibrary.byGender(_currentGender);
  }

  void setGender(String gender) {
    if (_currentGender == gender) {
      return;
    }

    _currentGender = gender;
    _selectedClothing = clothingItems.isNotEmpty ? clothingItems.first : null;
    notifyListeners();
  }

  void setCategory(ClothingCategory category) {
    if (_currentCategory == category) {
      return;
    }

    _currentCategory = category;
    notifyListeners();
  }

  void selectClothing(ClothingItem item) {
    if (_selectedClothing == item) {
      return;
    }

    _selectedClothing = item;
    notifyListeners();
  }

  Future<void> generate() async {
    _setEngineStatus(ClothingStatus.preparing);
    await Future<void>.delayed(const Duration(milliseconds: 250));

    _setEngineStatus(ClothingStatus.processing);

    try {
      final result = await _service.generate();
      _selectedClothing = result.selectedItem ?? _selectedClothing;
      _setEngineStatus(result.status);
    } catch (_) {
      _setEngineStatus(ClothingStatus.failed);
    }
  }

  void _setEngineStatus(ClothingStatus status) {
    _engineStatus = status;
    notifyListeners();
  }
}
