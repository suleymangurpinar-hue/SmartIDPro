import 'package:file_picker/file_picker.dart';

class PhotoImportService {
  static Future<String?> pickPhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'heic',
        'dng',
        'arw',
        'raf',
        'cr3',
        'tif',
        'tiff',
      ],
    );

    if (result == null) {
      return null;
    }

    return result.files.single.path;
  }
}