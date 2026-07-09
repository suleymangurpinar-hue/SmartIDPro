class PaperSize {
  final String name;
  final double widthMm;
  final double heightMm;

  const PaperSize({
    required this.name,
    required this.widthMm,
    required this.heightMm,
  });

  static const sizes = [
    PaperSize(name: '10x15', widthMm: 150, heightMm: 100),
    PaperSize(name: '13x18', widthMm: 180, heightMm: 130),
    PaperSize(name: '15x21', widthMm: 210, heightMm: 150),
    PaperSize(name: 'A4', widthMm: 297, heightMm: 210),
  ];

  static PaperSize byName(String name) {
    return sizes.firstWhere(
      (paper) => paper.name == name,
      orElse: () => sizes.first,
    );
  }
}
