import 'dart:math' as math;

import '../core/app_constants.dart';
import '../models/photo_type.dart';
import '../models/print_layout.dart';

final class PrintEngine {
  const PrintEngine({
    this.preferredMarginMm = AppConstants.cutMarginMm,
    this.preferredSpacingMm = AppConstants.spacingMm,
  });

  static const double paperWidthMm = 150.0;
  static const double paperHeightMm = 100.0;
  static const double toleranceMm = 0.001;

  final double preferredMarginMm;
  final double preferredSpacingMm;

  PrintLayout generate(PhotoType type) {
    _validateNonNegativeMillimeters('preferredMarginMm', preferredMarginMm);
    _validateNonNegativeMillimeters('preferredSpacingMm', preferredSpacingMm);

    final spec = _LayoutSpec.byId(type.id);
    _validatePhotoType(type, spec);

    final geometry = _resolveGeometry(spec);
    final photos = _buildPhotos(
      photoType: type,
      spec: spec,
      geometry: geometry,
    );

    final layout = PrintLayout(
      paperWidthMm: paperWidthMm,
      paperHeightMm: paperHeightMm,
      marginMm: geometry.marginMm,
      spacingMm: geometry.spacingMm,
      photos: photos,
    );

    _validateLayout(layout, spec);

    return layout;
  }

  static double gridExtentMm({
    required double itemExtentMm,
    required int itemCount,
    required double spacingMm,
  }) {
    _validatePositiveMillimeters('itemExtentMm', itemExtentMm);
    _validatePositiveCount('itemCount', itemCount);
    _validateNonNegativeMillimeters('spacingMm', spacingMm);

    return (itemExtentMm * itemCount) + (spacingMm * (itemCount - 1));
  }

  static double centeredOffsetMm({
    required double containerExtentMm,
    required double contentExtentMm,
  }) {
    _validatePositiveMillimeters('containerExtentMm', containerExtentMm);
    _validatePositiveMillimeters('contentExtentMm', contentExtentMm);

    return (containerExtentMm - contentExtentMm) / 2;
  }

  static bool fitsOnPaper({
    required double contentWidthMm,
    required double contentHeightMm,
    double marginMm = 0,
  }) {
    _validatePositiveMillimeters('contentWidthMm', contentWidthMm);
    _validatePositiveMillimeters('contentHeightMm', contentHeightMm);
    _validateNonNegativeMillimeters('marginMm', marginMm);

    return contentWidthMm + (marginMm * 2) <= paperWidthMm + toleranceMm &&
        contentHeightMm + (marginMm * 2) <= paperHeightMm + toleranceMm;
  }

  _LayoutGeometry _resolveGeometry(_LayoutSpec spec) {
    final printSize = spec.printSize;
    final marginMm = _effectiveMarginMm(spec: spec, printSize: printSize);
    final spacingMm = _effectiveSpacingMm(
      spec: spec,
      printSize: printSize,
      marginMm: marginMm,
    );

    final contentWidthMm = gridExtentMm(
      itemExtentMm: printSize.widthMm,
      itemCount: spec.columns,
      spacingMm: spacingMm,
    );
    final contentHeightMm = gridExtentMm(
      itemExtentMm: printSize.heightMm,
      itemCount: spec.rows,
      spacingMm: spacingMm,
    );

    if (!fitsOnPaper(
      contentWidthMm: contentWidthMm,
      contentHeightMm: contentHeightMm,
      marginMm: marginMm,
    )) {
      throw StateError(
        'The ${spec.id} layout cannot fit on 150 x 100 mm paper.',
      );
    }

    return _LayoutGeometry(
      marginMm: marginMm,
      spacingMm: spacingMm,
      startXMm: centeredOffsetMm(
        containerExtentMm: paperWidthMm,
        contentExtentMm: contentWidthMm,
      ),
      startYMm: centeredOffsetMm(
        containerExtentMm: paperHeightMm,
        contentExtentMm: contentHeightMm,
      ),
      printWidthMm: printSize.widthMm,
      printHeightMm: printSize.heightMm,
    );
  }

  double _effectiveMarginMm({
    required _LayoutSpec spec,
    required _PrintSize printSize,
  }) {
    final preferredFits = _maxUniformSpacingMm(
      spec: spec,
      printSize: printSize,
      marginMm: preferredMarginMm,
    );

    if (preferredFits >= -toleranceMm) {
      return preferredMarginMm;
    }

    final maxMarginWithNoSpacing = _maxUniformMarginMm(
      spec: spec,
      printSize: printSize,
      spacingMm: 0,
    );

    if (maxMarginWithNoSpacing < -toleranceMm) {
      throw StateError(
        'The ${spec.id} layout cannot fit on 150 x 100 mm paper.',
      );
    }

    return math.min(preferredMarginMm, math.max(0, maxMarginWithNoSpacing));
  }

  double _effectiveSpacingMm({
    required _LayoutSpec spec,
    required _PrintSize printSize,
    required double marginMm,
  }) {
    final maxSpacingMm = _maxUniformSpacingMm(
      spec: spec,
      printSize: printSize,
      marginMm: marginMm,
    );

    if (maxSpacingMm < -toleranceMm) {
      throw StateError(
        'The ${spec.id} layout cannot fit on 150 x 100 mm paper.',
      );
    }

    return math.min(preferredSpacingMm, math.max(0, maxSpacingMm));
  }

  double _maxUniformSpacingMm({
    required _LayoutSpec spec,
    required _PrintSize printSize,
    required double marginMm,
  }) {
    final horizontalSpacingSlots = math.max(0, spec.columns - 1);
    final verticalSpacingSlots = math.max(0, spec.rows - 1);

    final maxHorizontalSpacing = horizontalSpacingSlots == 0
        ? double.infinity
        : (paperWidthMm - (marginMm * 2) - (printSize.widthMm * spec.columns)) /
              horizontalSpacingSlots;
    final maxVerticalSpacing = verticalSpacingSlots == 0
        ? double.infinity
        : (paperHeightMm - (marginMm * 2) - (printSize.heightMm * spec.rows)) /
              verticalSpacingSlots;

    return math.min(maxHorizontalSpacing, maxVerticalSpacing);
  }

  double _maxUniformMarginMm({
    required _LayoutSpec spec,
    required _PrintSize printSize,
    required double spacingMm,
  }) {
    final contentWidthMm = gridExtentMm(
      itemExtentMm: printSize.widthMm,
      itemCount: spec.columns,
      spacingMm: spacingMm,
    );
    final contentHeightMm = gridExtentMm(
      itemExtentMm: printSize.heightMm,
      itemCount: spec.rows,
      spacingMm: spacingMm,
    );

    return math.min(
      (paperWidthMm - contentWidthMm) / 2,
      (paperHeightMm - contentHeightMm) / 2,
    );
  }

  List<PrintPhoto> _buildPhotos({
    required PhotoType photoType,
    required _LayoutSpec spec,
    required _LayoutGeometry geometry,
  }) {
    final photos = <PrintPhoto>[];

    for (var row = 0; row < spec.rows; row++) {
      for (var column = 0; column < spec.columns; column++) {
        photos.add(
          PrintPhoto(
            xMm:
                geometry.startXMm +
                (column * (geometry.printWidthMm + geometry.spacingMm)),
            yMm:
                geometry.startYMm +
                (row * (geometry.printHeightMm + geometry.spacingMm)),
            widthMm: geometry.printWidthMm,
            heightMm: geometry.printHeightMm,
            rotate: spec.requiresRotation,
            photoType: photoType,
          ),
        );
      }
    }

    return photos;
  }

  void _validatePhotoType(PhotoType type, _LayoutSpec spec) {
    if (!_nearlyEqual(type.widthMm, spec.sourceWidthMm) ||
        !_nearlyEqual(type.heightMm, spec.sourceHeightMm)) {
      throw ArgumentError.value(
        type,
        'type',
        'Photo type dimensions must match ${spec.sourceWidthMm} x '
            '${spec.sourceHeightMm} mm.',
      );
    }

    if (type.defaultCount != spec.count) {
      throw ArgumentError.value(
        type.defaultCount,
        'type.defaultCount',
        'Expected ${spec.count} prints for ${spec.id}.',
      );
    }
  }

  void _validateLayout(PrintLayout layout, _LayoutSpec spec) {
    if (layout.count != spec.count) {
      throw StateError(
        'The ${spec.id} layout produced ${layout.count} prints instead of '
        '${spec.count}.',
      );
    }

    if (layout.hasOverflow) {
      throw StateError(
        'The ${spec.id} layout exceeds the 150 x 100 mm paper bounds.',
      );
    }

    if (layout.hasOverlaps) {
      throw StateError('The ${spec.id} layout contains overlapping prints.');
    }

    for (final photo in layout.photos) {
      if (!photo.matchesPhotoTypeSize) {
        throw StateError(
          'The ${spec.id} layout produced a print that does not match the '
          'source document dimensions.',
        );
      }
    }
  }
}

final class _LayoutSpec {
  const _LayoutSpec({
    required this.id,
    required this.sourceWidthMm,
    required this.sourceHeightMm,
    required this.printOrientation,
    required this.rows,
    required this.columns,
  });

  final String id;
  final double sourceWidthMm;
  final double sourceHeightMm;
  final PhotoOrientation printOrientation;
  final int rows;
  final int columns;

  int get count {
    return rows * columns;
  }

  bool get requiresRotation {
    final printSize = this.printSize;

    return !_nearlyEqual(printSize.widthMm, sourceWidthMm) ||
        !_nearlyEqual(printSize.heightMm, sourceHeightMm);
  }

  _PrintSize get printSize {
    return switch (printOrientation) {
      PhotoOrientation.portrait => _PrintSize(
        widthMm: math.min(sourceWidthMm, sourceHeightMm),
        heightMm: math.max(sourceWidthMm, sourceHeightMm),
      ),
      PhotoOrientation.landscape => _PrintSize(
        widthMm: math.max(sourceWidthMm, sourceHeightMm),
        heightMm: math.min(sourceWidthMm, sourceHeightMm),
      ),
      PhotoOrientation.square => _PrintSize(
        widthMm: sourceWidthMm,
        heightMm: sourceHeightMm,
      ),
    };
  }

  static _LayoutSpec byId(String id) {
    final normalizedId = id.trim();

    for (final spec in _supportedSpecs) {
      if (spec.id == normalizedId) {
        return spec;
      }
    }

    throw ArgumentError.value(id, 'id', 'Unsupported print layout size');
  }

  static const List<_LayoutSpec> _supportedSpecs = <_LayoutSpec>[
    _LayoutSpec(
      id: '35x45',
      sourceWidthMm: 35,
      sourceHeightMm: 45,
      printOrientation: PhotoOrientation.portrait,
      rows: 2,
      columns: 4,
    ),
    _LayoutSpec(
      id: '45x60',
      sourceWidthMm: 45,
      sourceHeightMm: 60,
      printOrientation: PhotoOrientation.landscape,
      rows: 2,
      columns: 2,
    ),
    _LayoutSpec(
      id: '50x60',
      sourceWidthMm: 50,
      sourceHeightMm: 60,
      printOrientation: PhotoOrientation.landscape,
      rows: 2,
      columns: 2,
    ),
    _LayoutSpec(
      id: '50x50',
      sourceWidthMm: 50,
      sourceHeightMm: 50,
      printOrientation: PhotoOrientation.square,
      rows: 2,
      columns: 2,
    ),
  ];
}

final class _LayoutGeometry {
  const _LayoutGeometry({
    required this.marginMm,
    required this.spacingMm,
    required this.startXMm,
    required this.startYMm,
    required this.printWidthMm,
    required this.printHeightMm,
  });

  final double marginMm;
  final double spacingMm;
  final double startXMm;
  final double startYMm;
  final double printWidthMm;
  final double printHeightMm;
}

final class _PrintSize {
  const _PrintSize({required this.widthMm, required this.heightMm});

  final double widthMm;
  final double heightMm;
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

void _validatePositiveCount(String name, int value) {
  if (value <= 0) {
    throw ArgumentError.value(value, name, 'Must be greater than zero');
  }
}

bool _nearlyEqual(double a, double b) {
  return (a - b).abs() <= PrintEngine.toleranceMm;
}
