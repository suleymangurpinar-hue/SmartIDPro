import 'package:flutter/material.dart';

import '../models/background_category.dart';
import '../models/background_item.dart';

class BackgroundLibrary {
  static const List<BackgroundItem> items = [
    BackgroundItem(
      id: 'solid-white',
      title: 'White',
      category: BackgroundCategory.solid,
      color: Color(0xFFFFFFFF),
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    BackgroundItem(
      id: 'neutral-light-gray',
      title: 'Light Gray',
      category: BackgroundCategory.neutral,
      color: Color(0xFFF3F4F6),
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    BackgroundItem(
      id: 'neutral-gray',
      title: 'Gray',
      category: BackgroundCategory.neutral,
      color: Color(0xFFD1D5DB),
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    BackgroundItem(
      id: 'official-light-blue',
      title: 'Light Blue',
      category: BackgroundCategory.official,
      color: Color(0xFFBFDBFE),
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    BackgroundItem(
      id: 'official-navy',
      title: 'Navy',
      category: BackgroundCategory.official,
      color: Color(0xFF1E3A8A),
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
    BackgroundItem(
      id: 'solid-black',
      title: 'Black',
      category: BackgroundCategory.solid,
      color: Color(0xFF000000),
      thumbnail: '',
      preview: '',
      premium: false,
      enabled: true,
    ),
  ];

  static List<BackgroundItem> byCategory(BackgroundCategory category) {
    return items.where((item) => item.category == category).toList();
  }
}
