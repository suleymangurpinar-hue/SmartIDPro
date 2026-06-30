import 'package:flutter/material.dart';

class PrintStudioProvider extends ChangeNotifier {
  String paper = '10x15';

  String layout = '4';

  int quantity = 1;

  double photoWidthMm = 50;
  double photoHeightMm = 60;

  void applyPreset({
    required String paperSize,
    required int photoLayout,
  }) {
    paper = paperSize;
    layout = photoLayout.toString();
    notifyListeners();
  }

  void setPhotoSize(
    double width,
    double height,
  ) {
    photoWidthMm = width;
    photoHeightMm = height;
    notifyListeners();
  }

  void setPaper(String value) {
    paper = value;
    notifyListeners();
  }

  void setLayout(String value) {
    layout = value;
    notifyListeners();
  }

  void setQuantity(int value) {
    quantity = value;
    notifyListeners();
  }

  int get photoCount {
    if (layout == 'Auto') {
      return 8;
    }

    return int.tryParse(layout) ?? 8;
  }

  int get crossCount {
    switch (photoCount) {
      case 4:
        return 2;

      case 6:
        return 3;

      case 8:
        return 4;

      case 12:
        return 4;

      case 16:
        return 4;

      default:
        return 4;
    }
  }

  int get rowCount {
    switch (photoCount) {
      case 4:
        return 2;

      case 6:
        return 2;

      case 8:
        return 2;

      case 12:
        return 3;

      case 16:
        return 4;

      default:
        return 2;
    }
  }
}