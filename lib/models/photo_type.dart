enum PhotoOrientation {
  portrait,
  landscape,
  square;

  bool get isPortrait {
    return this == PhotoOrientation.portrait;
  }

  bool get isLandscape {
    return this == PhotoOrientation.landscape;
  }

  bool get isSquare {
    return this == PhotoOrientation.square;
  }

  String get label {
    return switch (this) {
      PhotoOrientation.portrait => 'Portrait',
      PhotoOrientation.landscape => 'Landscape',
      PhotoOrientation.square => 'Square',
    };
  }

  static PhotoOrientation fromMillimeters({
    required double widthMm,
    required double heightMm,
  }) {
    _validatePositiveMillimeters('widthMm', widthMm);
    _validatePositiveMillimeters('heightMm', heightMm);

    if (_nearlyEqual(widthMm, heightMm)) {
      return PhotoOrientation.square;
    }

    return widthMm > heightMm
        ? PhotoOrientation.landscape
        : PhotoOrientation.portrait;
  }
}

final class PhotoType {
  factory PhotoType({
    required String id,
    required String title,
    required double widthMm,
    required double heightMm,
    PhotoOrientation? orientation,
    required int defaultCount,
    bool icao = true,
  }) {
    final normalizedId = id.trim();
    final normalizedTitle = title.trim();

    _validateNonEmptyString('id', normalizedId);
    _validateNonEmptyString('title', normalizedTitle);
    _validatePositiveMillimeters('widthMm', widthMm);
    _validatePositiveMillimeters('heightMm', heightMm);
    _validatePositiveCount('defaultCount', defaultCount);

    final resolvedOrientation =
        orientation ??
        PhotoOrientation.fromMillimeters(widthMm: widthMm, heightMm: heightMm);

    _validateOrientation(
      orientation: resolvedOrientation,
      widthMm: widthMm,
      heightMm: heightMm,
    );

    return PhotoType._(
      id: normalizedId,
      title: normalizedTitle,
      widthMm: widthMm,
      heightMm: heightMm,
      orientation: resolvedOrientation,
      defaultCount: defaultCount,
      icao: icao,
    );
  }

  const PhotoType._({
    required this.id,
    required this.title,
    required this.widthMm,
    required this.heightMm,
    required this.orientation,
    required this.defaultCount,
    required this.icao,
  });

  final String id;
  final String title;
  final double widthMm;
  final double heightMm;
  final PhotoOrientation orientation;
  final int defaultCount;
  final bool icao;

  double get aspectRatio {
    return widthMm / heightMm;
  }

  bool get isLandscape {
    return orientation.isLandscape;
  }

  bool get isPortrait {
    return orientation.isPortrait;
  }

  bool get isSquare {
    return orientation.isSquare;
  }

  bool get isIcaoCompliant {
    return icao;
  }

  int get defaultPrintCount {
    return defaultCount;
  }

  String get sizeLabel {
    return '${_formatMillimeters(widthMm)} x ${_formatMillimeters(heightMm)} mm';
  }

  PhotoType copyWith({
    String? id,
    String? title,
    double? widthMm,
    double? heightMm,
    PhotoOrientation? orientation,
    int? defaultCount,
    bool? icao,
  }) {
    final resolvedWidthMm = widthMm ?? this.widthMm;
    final resolvedHeightMm = heightMm ?? this.heightMm;
    final sizeChanged = widthMm != null || heightMm != null;

    return PhotoType(
      id: id ?? this.id,
      title: title ?? this.title,
      widthMm: resolvedWidthMm,
      heightMm: resolvedHeightMm,
      orientation:
          orientation ??
          (sizeChanged
              ? PhotoOrientation.fromMillimeters(
                  widthMm: resolvedWidthMm,
                  heightMm: resolvedHeightMm,
                )
              : this.orientation),
      defaultCount: defaultCount ?? this.defaultCount,
      icao: icao ?? this.icao,
    );
  }

  static final PhotoType p35x45 = PhotoType(
    id: '35x45',
    title: '3.5 x 4.5 cm',
    widthMm: 35,
    heightMm: 45,
    defaultCount: 8,
    icao: true,
  );

  static final PhotoType p45x60 = PhotoType(
    id: '45x60',
    title: '4.5 x 6 cm',
    widthMm: 45,
    heightMm: 60,
    defaultCount: 4,
    icao: true,
  );

  static final PhotoType p50x60 = PhotoType(
    id: '50x60',
    title: '5 x 6 cm',
    widthMm: 50,
    heightMm: 60,
    defaultCount: 4,
    icao: true,
  );

  static final PhotoType p50x50 = PhotoType(
    id: '50x50',
    title: '5 x 5 cm',
    widthMm: 50,
    heightMm: 50,
    defaultCount: 4,
    icao: true,
  );

  static final List<PhotoType> values = List<PhotoType>.unmodifiable(
    <PhotoType>[p35x45, p45x60, p50x60, p50x50],
  );

  static PhotoType byId(String id) {
    final match = tryById(id);

    if (match == null) {
      throw ArgumentError.value(id, 'id', 'Unsupported photo type id');
    }

    return match;
  }

  static PhotoType? tryById(String id) {
    final normalizedId = id.trim();

    for (final photoType in values) {
      if (photoType.id == normalizedId) {
        return photoType;
      }
    }

    return null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is PhotoType &&
        other.id == id &&
        other.title == title &&
        other.widthMm == widthMm &&
        other.heightMm == heightMm &&
        other.orientation == orientation &&
        other.defaultCount == defaultCount &&
        other.icao == icao;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      widthMm,
      heightMm,
      orientation,
      defaultCount,
      icao,
    );
  }

  @override
  String toString() {
    return 'PhotoType(id: $id, title: $title, size: $sizeLabel, '
        'orientation: ${orientation.label}, defaultCount: $defaultCount, '
        'icao: $icao)';
  }
}

void _validateNonEmptyString(String name, String value) {
  if (value.isEmpty) {
    throw ArgumentError.value(value, name, 'Must not be empty');
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

void _validatePositiveCount(String name, int value) {
  if (value <= 0) {
    throw ArgumentError.value(value, name, 'Must be greater than zero');
  }
}

void _validateOrientation({
  required PhotoOrientation orientation,
  required double widthMm,
  required double heightMm,
}) {
  final measuredOrientation = PhotoOrientation.fromMillimeters(
    widthMm: widthMm,
    heightMm: heightMm,
  );

  if (orientation != measuredOrientation) {
    throw ArgumentError.value(
      orientation,
      'orientation',
      'Must match the millimeter dimensions: ${measuredOrientation.label}',
    );
  }
}

bool _nearlyEqual(double a, double b) {
  return (a - b).abs() <= 0.001;
}

String _formatMillimeters(double value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  }

  return value.toStringAsFixed(1);
}
