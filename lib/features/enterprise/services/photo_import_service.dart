import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class PhotoImportService {
  static const List<String> _allowedExtensions = [
    'jpg',
    'jpeg',
    'png',
    'heic',
    'tif',
    'tiff',
    'dng',
    'arw',
    'raf',
    'cr3',
  ];

  static Future<String?> pickPhoto() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: _allowedExtensions,
        allowMultiple: false,
        lockParentWindow: true,
      );

      if (result == null || result.files.isEmpty) {
        return null;
      }

      final path = result.files.single.path;

      if (path == null) {
        return null;
      }

      final file = File(path);

      if (!await file.exists()) {
        return null;
      }

      return path;
    } catch (e) {
      debugPrint('PhotoImportService error: $e');
      return null;
    }
  }
}
