abstract final class AppConstants {
  AppConstants._();

  static const String appName = 'Smart ID Pro';
  static const String appVersion = '1.0.0';
  static const String defaultExportFilePrefix = 'smart-id-pro';

  static const double millimetersPerInch = 25.4;

  static const double paperWidthMm = 150.0;
  static const double paperHeightMm = 100.0;
  static const double paperAspectRatio = paperWidthMm / paperHeightMm;

  static const double cutMarginMm = 2.0;
  static const double minCutMarginMm = 0.0;
  static const double maxCutMarginMm = 10.0;

  static const double spacingMm = 2.0;
  static const double minSpacingMm = 0.0;
  static const double maxSpacingMm = 12.0;

  static const int exportDpi = 300;
  static const int minExportDpi = 150;
  static const int maxExportDpi = 600;
  static const int jpegQuality = 96;

  static const double minPhotoWidthMm = 20.0;
  static const double maxPhotoWidthMm = paperWidthMm;
  static const double minPhotoHeightMm = 20.0;
  static const double maxPhotoHeightMm = paperHeightMm;

  static const double minZoom = 0.50;
  static const double defaultZoom = 1.0;
  static const double maxZoom = 5.00;
  static const double zoomStep = 0.10;

  static const double rotationStep = 90.0;
  static const double fullRotationDegrees = 360.0;

  static const double minWindowWidth = 1180.0;
  static const double minWindowHeight = 760.0;
  static const double preferredWindowWidth = 1440.0;
  static const double preferredWindowHeight = 920.0;

  static const double sidebarWidth = 320.0;
  static const double inspectorWidth = 360.0;
  static const double toolbarHeight = 56.0;
  static const double statusBarHeight = 32.0;

  static const double previewPadding = 24.0;
  static const double pagePadding = 24.0;
  static const double sectionSpacing = 20.0;
  static const double controlSpacing = 12.0;

  static const double canvasCornerRadius = 8.0;
  static const double panelCornerRadius = 8.0;
  static const double controlCornerRadius = 6.0;

  static const Duration fastAnimation = Duration(milliseconds: 120);
  static const Duration animation = Duration(milliseconds: 180);
  static const Duration slowAnimation = Duration(milliseconds: 260);

  static const List<String> supportedImageExtensions = <String>[
    'jpg',
    'jpeg',
    'png',
    'heic',
    'heif',
    'tif',
    'tiff',
  ];

  static const List<String> supportedExportExtensions = <String>[
    'pdf',
    'jpg',
    'jpeg',
  ];

  static double millimetersToInches(double millimeters) {
    return millimeters / millimetersPerInch;
  }

  static double inchesToMillimeters(double inches) {
    return inches * millimetersPerInch;
  }

  static int pixelsForMillimeters(double millimeters, {int dpi = exportDpi}) {
    return (millimetersToInches(millimeters) * dpi).round();
  }

  static int get exportPixelWidth {
    return pixelsForMillimeters(paperWidthMm);
  }

  static int get exportPixelHeight {
    return pixelsForMillimeters(paperHeightMm);
  }
}
