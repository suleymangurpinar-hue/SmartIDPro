import '../models/photo_layout.dart';

class AutoLayoutService {
  static PhotoLayout build({
    required double widthMm,
    required double heightMm,
    required int count,
  }) {
    switch (count) {
      case 4:
        return PhotoLayout(
          photoWidthMm: widthMm,
          photoHeightMm: heightMm,
          count: 4,
          columns: 2,
          rows: 2,
        );

      case 6:
        return PhotoLayout(
          photoWidthMm: widthMm,
          photoHeightMm: heightMm,
          count: 6,
          columns: 3,
          rows: 2,
        );

      case 8:
        return PhotoLayout(
          photoWidthMm: widthMm,
          photoHeightMm: heightMm,
          count: 8,
          columns: 4,
          rows: 2,
        );

      case 12:
        return PhotoLayout(
          photoWidthMm: widthMm,
          photoHeightMm: heightMm,
          count: 12,
          columns: 4,
          rows: 3,
        );

      default:
        return PhotoLayout(
          photoWidthMm: widthMm,
          photoHeightMm: heightMm,
          count: 16,
          columns: 4,
          rows: 4,
        );
    }
  }
}
