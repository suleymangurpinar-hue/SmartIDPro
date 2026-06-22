class FileValidationService {
  static const allowedExtensions =
      [
    '.jpg',
    '.jpeg',
    '.png',
    '.heic',
    '.dng',
    '.arw',
    '.raf',
    '.cr3',
  ];

  static bool validate(
    String path,
  ) {
    final lower =
        path.toLowerCase();

    for (final ext
        in allowedExtensions) {
      if (lower.endsWith(ext)) {
        return true;
      }
    }

    return false;
  }
}