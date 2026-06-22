class AutoAlignEngine {
  Future<String> autoAlign(
    String imagePath,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    return imagePath;
  }
}