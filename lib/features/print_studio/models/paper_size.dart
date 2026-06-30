class PaperSize {
  final String name;
  final double widthCm;
  final double heightCm;

  const PaperSize({
    required this.name,
    required this.widthCm,
    required this.heightCm,
  });

  static const sizes = [
    PaperSize(name: '10x15', widthCm: 10, heightCm: 15),
    PaperSize(name: '13x18', widthCm: 13, heightCm: 18),
    PaperSize(name: '15x21', widthCm: 15, heightCm: 21),
    PaperSize(name: 'A4', widthCm: 21, heightCm: 29.7),
  ];
}