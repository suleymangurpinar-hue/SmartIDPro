import 'package:flutter/material.dart';

class WorkspaceProvider
    extends ChangeNotifier {
  String? _imagePath;

  String? get imagePath =>
      _imagePath;

  void setImage(
    String path,
  ) {
    _imagePath = path;
    notifyListeners();
  }

  void clear() {
    _imagePath = null;
    notifyListeners();
  }
}