class PrintPreviewService {
  static const Map<String, List<double>> _paperSizes = {
    '10x15': [100, 150],
    '13x18': [130, 180],
    '15x21': [150, 210],
    'A4': [210, 297],
  };

  static double getPaperWidth(String paper) {
    return _paperSizes[paper]?[0] ?? 100;
  }

  static double getPaperHeight(String paper) {
    return _paperSizes[paper]?[1] ?? 150;
  }

  static int calculatePhotoCount({
    required double paperWidthMm,
    required double paperHeightMm,
    required double photoWidthMm,
    required double photoHeightMm,
  }) {
    const spacing = 3.0;
    const margin = 5.0;

    final usableWidth = paperWidthMm - (margin * 2);

    final usableHeight = paperHeightMm - (margin * 2);

    final columns = ((usableWidth + spacing) / (photoWidthMm + spacing))
        .floor();

    final rows = ((usableHeight + spacing) / (photoHeightMm + spacing)).floor();

    final normal = columns * rows;

    final rotatedColumns = ((usableWidth + spacing) / (photoHeightMm + spacing))
        .floor();

    final rotatedRows = ((usableHeight + spacing) / (photoWidthMm + spacing))
        .floor();

    final rotated = rotatedColumns * rotatedRows;

    return normal > rotated ? normal : rotated;
  }

  static int calculateCrossCount(int count) {
    if (count <= 2) return 2;
    if (count <= 4) return 2;
    if (count <= 6) return 3;
    if (count <= 8) return 4;
    if (count <= 12) return 4;
    if (count <= 16) return 4;
    if (count <= 20) return 5;

    return 6;
  }

  static int calculateRowCount(int count, int crossCount) {
    return (count / crossCount).ceil();
  }
}
