class PhotoLayout {
  final double photoWidthMm;
  final double photoHeightMm;

  final int count;
  final int columns;
  final int rows;

  const PhotoLayout({
    required this.photoWidthMm,
    required this.photoHeightMm,
    required this.count,
    required this.columns,
    required this.rows,
  });
}