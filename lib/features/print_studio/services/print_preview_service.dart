class PrintPreviewService {
  static int calculateCrossCount(
    int count,
  ) {
    if (count <= 4) {
      return 2;
    }

    if (count <= 8) {
      return 4;
    }

    return 4;
  }
}