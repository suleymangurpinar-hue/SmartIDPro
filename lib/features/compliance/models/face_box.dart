class FaceBox {
  final double x1;
  final double y1;
  final double x2;
  final double y2;
  final double score;

  const FaceBox({
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
    required this.score,
  });

  double get width =>
      x2 - x1;

  double get height =>
      y2 - y1;

  double get area =>
      width * height;

  double get centerX =>
      x1 + width / 2;

  double get centerY =>
      y1 + height / 2;

  double get left => x1;
  double get top => y1;
  double get right => x2;
  double get bottom => y2;
}