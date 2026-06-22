class FileNameService {
  static String extract(
    String path,
  ) {
    final normalized =
        path.replaceAll(
      '\\',
      '/',
    );

    return normalized
        .split('/')
        .last;
  }
}