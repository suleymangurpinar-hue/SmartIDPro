import 'clothing_category.dart';

class ClothingItem {
  final String id;
  final String title;
  final String gender;
  final ClothingCategory category;
  final String thumbnail;
  final String preview;
  final bool premium;
  final bool enabled;

  const ClothingItem({
    required this.id,
    required this.title,
    required this.gender,
    required this.category,
    required this.thumbnail,
    required this.preview,
    required this.premium,
    required this.enabled,
  });

  ClothingItem copyWith({
    String? id,
    String? title,
    String? gender,
    ClothingCategory? category,
    String? thumbnail,
    String? preview,
    bool? premium,
    bool? enabled,
  }) {
    return ClothingItem(
      id: id ?? this.id,
      title: title ?? this.title,
      gender: gender ?? this.gender,
      category: category ?? this.category,
      thumbnail: thumbnail ?? this.thumbnail,
      preview: preview ?? this.preview,
      premium: premium ?? this.premium,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ClothingItem &&
            other.id == id &&
            other.title == title &&
            other.gender == gender &&
            other.category == category &&
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
      gender,
      category,
      thumbnail,
      preview,
      premium,
      enabled,
    );
  }
}
