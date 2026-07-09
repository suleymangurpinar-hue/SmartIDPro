import 'package:flutter/material.dart';

import '../models/paper_size.dart';
import '../models/photo_layout.dart';
import '../services/auto_layout_service.dart';

class PrintStudioProvider extends ChangeNotifier {
  String _paper = '10x15';
  String _layout = 'Auto';

  double _photoWidthMm = 50;
  double _photoHeightMm = 60;

  String get paper => _paper;
  String get layout => _layout;

  double get photoWidthMm => _photoWidthMm;
  double get photoHeightMm => _photoHeightMm;
  PhotoLayout get photoLayout => AutoLayoutService.build(
    paperWidthMm: paperWidthMm,
    paperHeightMm: paperHeightMm,
    widthMm: _photoWidthMm,
    heightMm: _photoHeightMm,
  );

  void setPaper(String value) {
    _paper = PaperSize.byName(value).name;
    notifyListeners();
  }

  void setLayout(String value) {
    _layout = 'Auto';
    notifyListeners();
  }

  void setPhotoSize(double width, double height) {
    _photoWidthMm = width;
    _photoHeightMm = height;
    notifyListeners();
  }

  void applyPreset({required String paperSize, required String photoLayout}) {
    _paper = PaperSize.byName(paperSize).name;
    _layout = 'Auto';
    notifyListeners();
  }

  int get photoCount {
    return photoLayout.count;
  }

  int get crossCount {
    return photoLayout.columns;
  }

  int get rowCount {
    return photoLayout.rows;
  }

  double get paperWidthMm {
    return PaperSize.byName(_paper).widthMm;
  }

  double get paperHeightMm {
    return PaperSize.byName(_paper).heightMm;
  }
}
