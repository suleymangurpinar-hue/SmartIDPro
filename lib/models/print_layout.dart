import 'photo_type.dart';

final class PrintPhoto {
  factory PrintPhoto({
    required double xMm,
    required double yMm,
    required double widthMm,
    required double heightMm,
    required bool rotate,
    required PhotoType photoType,
  }) {
    _validateFiniteMillimeters('xMm', xMm);
    _validateFiniteMillimeters('yMm', yMm);
    _validatePositiveMillimeters('widthMm', widthMm);
    _validatePositiveMillimeters('heightMm', heightMm);

    return PrintPhoto._(
      xMm: xMm,
      yMm: yMm,
      widthMm: widthMm,
      heightMm: heightMm,
      rotate: rotate,
      photoType: photoType,
    );
  }

  const PrintPhoto._({
    required this.xMm,
    required this.yMm,
    required this.widthMm,
    required this.heightMm,
    required this.rotate,
    required this.photoType,
  });

  final double xMm;
  final double yMm;
  final double widthMm;
  final double heightMm;
  final bool rotate;
  final PhotoType photoType;

  double get rightMm {
    return xMm + widthMm;
  }

  double get bottomMm {
    return yMm + heightMm;
  }

  double get centerXMm {
    return xMm + (widthMm / 2);
  }

  double get centerYMm {
    return yMm + (heightMm / 2);
  }

  double get aspectRatio {
    return widthMm / heightMm;
  }

  double get sourceWidthMm {
    return rotate ? heightMm : widthMm;
  }

  double get sourceHeightMm {
    return rotate ? widthMm : heightMm;
  }

  PhotoOrientation get printOrientation {
    return PhotoOrientation.fromMillimeters(
      widthMm: widthMm,
      heightMm: heightMm,
    );
  }

  PhotoOrientation get sourceOrientation {
    return PhotoOrientation.fromMillimeters(
      widthMm: sourceWidthMm,
      heightMm: sourceHeightMm,
    );
  }

  bool get matchesPhotoTypeSize {
    return _nearlyEqual(sourceWidthMm, photoType.widthMm) &&
        _nearlyEqual(sourceHeightMm, photoType.heightMm);
  }

  bool fitsWithin({
    required double paperWidthMm,
    required double paperHeightMm,
    double toleranceMm = 0.001,
  }) {
    _validatePositiveMillimeters('paperWidthMm', paperWidthMm);
    _validatePositiveMillimeters('paperHeightMm', paperHeightMm);
    _validateNonNegativeMillimeters('toleranceMm', toleranceMm);

    return xMm >= -toleranceMm &&
        yMm >= -toleranceMm &&
        rightMm <= paperWidthMm + toleranceMm &&
        bottomMm <= paperHeightMm + toleranceMm;
  }

  bool overlaps(PrintPhoto other, {double toleranceMm = 0.001}) {
    _validateNonNegativeMillimeters('toleranceMm', toleranceMm);

    return xMm < other.rightMm - toleranceMm &&
        rightMm > other.xMm + toleranceMm &&
        yMm < other.bottomMm - toleranceMm &&
        bottomMm > other.yMm + toleranceMm;
  }

  PrintPhoto copyWith({
    double? xMm,
    double? yMm,
    double? widthMm,
    double? heightMm,
    bool? rotate,
    PhotoType? photoType,
  }) {
    return PrintPhoto(
      xMm: xMm ?? this.xMm,
      yMm: yMm ?? this.yMm,
      widthMm: widthMm ?? this.widthMm,
      heightMm: heightMm ?? this.heightMm,
      rotate: rotate ?? this.rotate,
      photoType: photoType ?? this.photoType,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is PrintPhoto &&
        other.xMm == xMm &&
        other.yMm == yMm &&
        other.widthMm == widthMm &&
        other.heightMm == heightMm &&
        other.rotate == rotate &&
        other.photoType == photoType;
  }

  @override
  int get hashCode {
    return Object.hash(xMm, yMm, widthMm, heightMm, rotate, photoType);
  }

  @override
  String toString() {
    return 'PrintPhoto(xMm: $xMm, yMm: $yMm, widthMm: $widthMm, '
        'heightMm: $heightMm, rotate: $rotate, photoType: ${photoType.id})';
  }
}

final class PrintLayout {
  factory PrintLayout({
    required double paperWidthMm,
    required double paperHeightMm,
    required double marginMm,
    required double spacingMm,
    required Iterable<PrintPhoto> photos,
  }) {
    _validatePositiveMillimeters('paperWidthMm', paperWidthMm);
    _validatePositiveMillimeters('paperHeightMm', paperHeightMm);
    _validateNonNegativeMillimeters('marginMm', marginMm);
    _validateNonNegativeMillimeters('spacingMm', spacingMm);

    if (marginMm * 2 >= paperWidthMm || marginMm * 2 >= paperHeightMm) {
      throw ArgumentError.value(
        marginMm,
        'marginMm',
        'Must leave a printable area on the selected paper size',
      );
    }

    return PrintLayout._(
      paperWidthMm: paperWidthMm,
      paperHeightMm: paperHeightMm,
      marginMm: marginMm,
      spacingMm: spacingMm,
      photos: List<PrintPhoto>.unmodifiable(photos),
    );
  }

  const PrintLayout._({
    required this.paperWidthMm,
    required this.paperHeightMm,
    required this.marginMm,
    required this.spacingMm,
    required this.photos,
  });

  final double paperWidthMm;
  final double paperHeightMm;
  final double marginMm;
  final double spacingMm;
  final List<PrintPhoto> photos;

  int get count {
    return photos.length;
  }

  bool get isEmpty {
    return photos.isEmpty;
  }

  bool get isNotEmpty {
    return photos.isNotEmpty;
  }

  double get aspectRatio {
    return paperWidthMm / paperHeightMm;
  }

  double get printableWidthMm {
    return paperWidthMm - (marginMm * 2);
  }

  double get printableHeightMm {
    return paperHeightMm - (marginMm * 2);
  }

  bool get allPhotosFitOnPaper {
    return photos.every(
      (photo) => photo.fitsWithin(
        paperWidthMm: paperWidthMm,
        paperHeightMm: paperHeightMm,
      ),
    );
  }

  bool get hasOverflow {
    return !allPhotosFitOnPaper;
  }

  List<PrintPhoto> get overflowingPhotos {
    return List<PrintPhoto>.unmodifiable(
      photos.where(
        (photo) => !photo.fitsWithin(
          paperWidthMm: paperWidthMm,
          paperHeightMm: paperHeightMm,
        ),
      ),
    );
  }

  bool get hasOverlaps {
    for (var firstIndex = 0; firstIndex < photos.length; firstIndex++) {
      for (
        var secondIndex = firstIndex + 1;
        secondIndex < photos.length;
        secondIndex++
      ) {
        if (photos[firstIndex].overlaps(photos[secondIndex])) {
          return true;
        }
      }
    }

    return false;
  }

  PhotoType? get primaryPhotoType {
    if (photos.isEmpty) {
      return null;
    }

    final firstType = photos.first.photoType;

    for (final photo in photos.skip(1)) {
      if (photo.photoType != firstType) {
        return null;
      }
    }

    return firstType;
  }

  PrintLayout copyWith({
    double? paperWidthMm,
    double? paperHeightMm,
    double? marginMm,
    double? spacingMm,
    Iterable<PrintPhoto>? photos,
  }) {
    return PrintLayout(
      paperWidthMm: paperWidthMm ?? this.paperWidthMm,
      paperHeightMm: paperHeightMm ?? this.paperHeightMm,
      marginMm: marginMm ?? this.marginMm,
      spacingMm: spacingMm ?? this.spacingMm,
      photos: photos ?? this.photos,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is PrintLayout &&
        other.paperWidthMm == paperWidthMm &&
        other.paperHeightMm == paperHeightMm &&
        other.marginMm == marginMm &&
        other.spacingMm == spacingMm &&
        _listEquals(other.photos, photos);
  }

  @override
  int get hashCode {
    return Object.hash(
      paperWidthMm,
      paperHeightMm,
      marginMm,
      spacingMm,
      Object.hashAll(photos),
    );
  }

  @override
  String toString() {
    return 'PrintLayout(paperWidthMm: $paperWidthMm, '
        'paperHeightMm: $paperHeightMm, marginMm: $marginMm, '
        'spacingMm: $spacingMm, count: $count)';
  }
}

void _validateFiniteMillimeters(String name, double value) {
  if (!value.isFinite) {
    throw ArgumentError.value(value, name, 'Must be a finite millimeter value');
  }
}

void _validatePositiveMillimeters(String name, double value) {
  if (!value.isFinite || value <= 0) {
    throw ArgumentError.value(
      value,
      name,
      'Must be a finite millimeter value greater than zero',
    );
  }
}

void _validateNonNegativeMillimeters(String name, double value) {
  if (!value.isFinite || value < 0) {
    throw ArgumentError.value(
      value,
      name,
      'Must be a finite millimeter value greater than or equal to zero',
    );
  }
}

bool _nearlyEqual(double a, double b) {
  return (a - b).abs() <= 0.001;
}

bool _listEquals<T>(List<T> first, List<T> second) {
  if (identical(first, second)) {
    return true;
  }

  if (first.length != second.length) {
    return false;
  }

  for (var index = 0; index < first.length; index++) {
    if (first[index] != second[index]) {
      return false;
    }
  }

  return true;
}
