import '../models/photo_layout.dart';

class AutoLayoutService {
  static PhotoLayout build({
    double paperWidthMm = 150,
    double paperHeightMm = 100,
    required double widthMm,
    required double heightMm,
    int? count,
  }) {
    final layout = _knownLayout(
      paperWidthMm: paperWidthMm,
      paperHeightMm: paperHeightMm,
      widthMm: widthMm,
      heightMm: heightMm,
    );
    if (layout != null) {
      return layout;
    }

    return _centeredFour(
      paperWidthMm: paperWidthMm,
      paperHeightMm: paperHeightMm,
      widthMm: widthMm,
      heightMm: heightMm,
    );
  }

  static int mmToPx(double millimeters, {int dpi = 300}) {
    return (millimeters / 25.4 * dpi).round();
  }

  static double pxToMm(int pixels, {int dpi = 300}) {
    return pixels / dpi * 25.4;
  }

  static PhotoLayout? _knownLayout({
    required double paperWidthMm,
    required double paperHeightMm,
    required double widthMm,
    required double heightMm,
  }) {
    if (_sameSize(widthMm, heightMm, 35, 45)) {
      return _layout(
        paperWidthMm: paperWidthMm,
        paperHeightMm: paperHeightMm,
        widthMm: widthMm,
        heightMm: heightMm,
        count: 8,
        columns: 4,
        rows: 2,
        rotatePhoto: false,
      );
    }

    if (_sameSize(widthMm, heightMm, 45, 60) ||
        _sameSize(widthMm, heightMm, 50, 60)) {
      return _layout(
        paperWidthMm: paperWidthMm,
        paperHeightMm: paperHeightMm,
        widthMm: widthMm,
        heightMm: heightMm,
        count: 4,
        columns: 2,
        rows: 2,
        rotatePhoto: true,
      );
    }

    if (_sameSize(widthMm, heightMm, 50, 50)) {
      return _centeredFour(
        paperWidthMm: paperWidthMm,
        paperHeightMm: paperHeightMm,
        widthMm: widthMm,
        heightMm: heightMm,
      );
    }

    return null;
  }

  static PhotoLayout _centeredFour({
    required double paperWidthMm,
    required double paperHeightMm,
    required double widthMm,
    required double heightMm,
  }) {
    return _layout(
      paperWidthMm: paperWidthMm,
      paperHeightMm: paperHeightMm,
      widthMm: widthMm,
      heightMm: heightMm,
      count: 4,
      columns: 2,
      rows: 2,
      rotatePhoto: false,
    );
  }

  static PhotoLayout _layout({
    required double paperWidthMm,
    required double paperHeightMm,
    required double widthMm,
    required double heightMm,
    required int count,
    required int columns,
    required int rows,
    required bool rotatePhoto,
  }) {
    final slotWidthMm = rotatePhoto ? heightMm : widthMm;
    final slotHeightMm = rotatePhoto ? widthMm : heightMm;
    final usedWidthMm = columns * slotWidthMm;
    final usedHeightMm = rows * slotHeightMm;
    final remainingWidthMm = paperWidthMm - usedWidthMm;
    final remainingHeightMm = paperHeightMm - usedHeightMm;
    final gapXmm = columns > 1 ? remainingWidthMm / (columns + 1) : 0.0;
    final gapYmm = rows > 1 ? remainingHeightMm / (rows + 1) : 0.0;

    return PhotoLayout(
      paperWidthMm: paperWidthMm,
      paperHeightMm: paperHeightMm,
      photoWidthMm: widthMm,
      photoHeightMm: heightMm,
      count: count,
      columns: columns,
      rows: rows,
      rotatePhoto: rotatePhoto,
      marginXmm: columns > 1 ? gapXmm : remainingWidthMm / 2,
      marginYmm: rows > 1 ? gapYmm : remainingHeightMm / 2,
      gapXmm: gapXmm,
      gapYmm: gapYmm,
    );
  }

  static bool _sameSize(
    double actualWidthMm,
    double actualHeightMm,
    double expectedWidthMm,
    double expectedHeightMm,
  ) {
    const tolerance = 0.01;

    return (actualWidthMm - expectedWidthMm).abs() < tolerance &&
        (actualHeightMm - expectedHeightMm).abs() < tolerance;
  }
}
