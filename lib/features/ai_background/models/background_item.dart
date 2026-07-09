import 'package:flutter/material.dart';

import 'background_category.dart';

class BackgroundItem {
  final String id;
  final String title;
  final BackgroundCategory category;
  final Color color;
  final String thumbnail;
  final String preview;
  final bool premium;
  final bool enabled;

  const BackgroundItem({
    required this.id,
    required this.title,
    required this.category,
    required this.color,
    required this.thumbnail,
    required this.preview,
    required this.premium,
    required this.enabled,
  });

  BackgroundItem copyWith({
    String? id,
    String? title,
    BackgroundCategory? category,
    Color? color,
    String? thumbnail,
    String? preview,
    bool? premium,
    bool? enabled,
  }) {
    return BackgroundItem(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      color: color ?? this.color,
      thumbnail: thumbnail ?? this.thumbnail,
      preview: preview ?? this.preview,
      premium: premium ?? this.premium,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BackgroundItem &&
            other.id == id &&
            other.title == title &&
            other.category == category &&
            other.color == color &&
            other.thumbnail == thumbnail &&
            other.preview == preview &&
            other.premium == premium &&
            other.enabled == enabled;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      category,
      color,
      thumbnail,
      preview,
      premium,
      enabled,
    );
  }
}
