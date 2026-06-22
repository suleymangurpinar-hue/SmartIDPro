class DocumentPreset {
  final String name;

  final double widthMm;

  final double heightMm;

  final double headMinPercent;

  final double headMaxPercent;

  final String country;

  const DocumentPreset({
    required this.name,
    required this.widthMm,
    required this.heightMm,
    required this.headMinPercent,
    required this.headMaxPercent,
    required this.country,
  });
}

class DocumentPresets {
  static const turkeyBiometric =
      DocumentPreset(
    name: "Turkey Biometric",
    widthMm: 50,
    heightMm: 60,
    headMinPercent: 70,
    headMaxPercent: 80,
    country: "TR",
  );

  static const schengenVisa =
      DocumentPreset(
    name: "Schengen Visa",
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    country: "EU",
  );

  static const usaVisa =
      DocumentPreset(
    name: "USA Visa",
    widthMm: 51,
    heightMm: 51,
    headMinPercent: 68,
    headMaxPercent: 78,
    country: "USA",
  );

  static const ukVisa =
      DocumentPreset(
    name: "UK Visa",
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    country: "UK",
  );

  static const canadaVisa =
      DocumentPreset(
    name: "Canada Visa",
    widthMm: 50,
    heightMm: 70,
    headMinPercent: 70,
    headMaxPercent: 80,
    country: "CA",
  );

  static const all = [
    turkeyBiometric,
    schengenVisa,
    usaVisa,
    ukVisa,
    canadaVisa,
  ];
}