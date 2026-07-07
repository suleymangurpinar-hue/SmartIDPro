import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';

class FileService {
  const FileService();

  Future<File?> pickImage() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: const [
        'jpg',
        'jpeg',
        'png',
        'bmp',
        'tif',
        'tiff',
        'webp',
      ],
    );

    if (result == null) return null;

    final path = result.files.single.path;

    if (path == null) return null;

    return File(path);
  }

  Future<Uint8List> readBytes(File file) async {
    return file.readAsBytes();
  }

  Future<ui.Image> decodeImage(File file) async {
    final bytes = await file.readAsBytes();

    final codec = await ui.instantiateImageCodec(bytes);

    final frame = await codec.getNextFrame();

    return frame.image;
  }

  Future<ImageInfo> imageInfo(File file) async {
    final image = await decodeImage(file);
    try {
      return ImageInfo(width: image.width, height: image.height);
    } finally {
      image.dispose();
    }
  }

  String extension(File file) {
    return file.path.split('.').last.toLowerCase();
  }

  String fileName(File file) {
    return file.uri.pathSegments.last;
  }

  bool isSupported(File file) {
    final ext = extension(file);

    return const [
      'jpg',
      'jpeg',
      'png',
      'bmp',
      'tif',
      'tiff',
      'webp',
    ].contains(ext);
  }
}

class ImageInfo {
  final int width;
  final int height;

  const ImageInfo({required this.width, required this.height});

  double get ratio => width / height;

  bool get portrait => height > width;

  bool get landscape => width > height;

  bool get square => width == height;
}
