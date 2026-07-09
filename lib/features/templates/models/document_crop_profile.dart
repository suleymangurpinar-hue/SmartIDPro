class DocumentCropProfile {
  final String id;
  final String country;
  final String documentName;

  final double widthMm;
  final double heightMm;

  final double headRatio;
  final double eyeRatio;

  final int printCount;

  const DocumentCropProfile({
    required this.id,
    required this.country,
    required this.documentName,
    required this.widthMm,
    required this.heightMm,
    required this.headRatio,
    required this.eyeRatio,
    required this.printCount,
  });

  static const turkeyBiometric = DocumentCropProfile(
    id: 'tr_biometric',
    country: 'Türkiye',
    documentName: 'Türkiye Biyometrik',
    widthMm: 50,
    heightMm: 60,
    headRatio: 0.70,
    eyeRatio: 0.46,
    printCount: 4,
  );

  static const passport = DocumentCropProfile(
    id: 'passport',
    country: 'Uluslararası',
    documentName: 'Pasaport',
    widthMm: 50,
    heightMm: 60,
    headRatio: 0.72,
    eyeRatio: 0.45,
    printCount: 4,
  );

  static const usaVisa = DocumentCropProfile(
    id: 'usa_visa',
    country: 'Amerika',
    documentName: 'USA Visa',
    widthMm: 50,
    heightMm: 50,
    headRatio: 0.76,
    eyeRatio: 0.44,
    printCount: 4,
  );

  static const nikah = DocumentCropProfile(
    id: 'nikah',
    country: 'Türkiye',
    documentName: 'Nikah Dairesi',
    widthMm: 45,
    heightMm: 60,
    headRatio: 0.58,
    eyeRatio: 0.48,
    printCount: 8,
  );

  static const schengenVisa = DocumentCropProfile(
    id: 'schengen',
    country: 'Avrupa Birliği',
    documentName: 'Schengen Visa',
    widthMm: 35,
    heightMm: 45,
    headRatio: 0.72,
    eyeRatio: 0.45,
    printCount: 8,
  );

  static const canadaVisa = DocumentCropProfile(
    id: 'canada',
    country: 'Kanada',
    documentName: 'Canada Visa',
    widthMm: 50,
    heightMm: 70,
    headRatio: 0.72,
    eyeRatio: 0.45,
    printCount: 4,
  );

  static const greenCard = DocumentCropProfile(
    id: 'green_card',
    country: 'Amerika',
    documentName: 'Green Card',
    widthMm: 50,
    heightMm: 50,
    headRatio: 0.74,
    eyeRatio: 0.45,
    printCount: 4,
  );

  static const all = <DocumentCropProfile>[
    turkeyBiometric,
    passport,
    usaVisa,
    nikah,
    schengenVisa,
    canadaVisa,
    greenCard,
  ];
}