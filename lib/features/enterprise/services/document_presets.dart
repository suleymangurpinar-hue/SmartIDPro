class DocumentPreset {
  final String id;
  final String name;
  final String country;

  final double widthMm;
  final double heightMm;

  final double headMinPercent;
  final double headMaxPercent;

  final double eyeMinPercent;
  final double eyeMaxPercent;

  final String paper;
  final int layout;
  final int dpi;

  const DocumentPreset({
    required this.id,
    required this.name,
    required this.country,
    required this.widthMm,
    required this.heightMm,
    required this.headMinPercent,
    required this.headMaxPercent,
    required this.eyeMinPercent,
    required this.eyeMaxPercent,
    required this.paper,
    required this.layout,
    required this.dpi,
  });
}

class DocumentPresets {
  static const all = [
    turkeyBiometric,
    turkeyPassport,
    turkeyIdentity,
    turkeyDriver,
    turkeyStudent,
    turkeyMarriage,
    turkeyOfficer,
    schengenVisa,
    germanyVisa,
    franceVisa,
    italyVisa,
    usaVisa,
    canadaVisa,
    mexicoVisa,
    japanVisa,
    chinaVisa,
    koreaVisa,
    singaporeVisa,
    dubaiVisa,
    saudiVisa,
    qatarVisa,
    kuwaitVisa,
  ];

  static const turkeyBiometric = DocumentPreset(
    id: 'tr_biometric',
    name: 'Türkiye Biyometrik',
    country: 'TR',
    widthMm: 50,
    heightMm: 60,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 4,
    dpi: 300,
  );

  static const turkeyPassport = DocumentPreset(
    id: 'tr_passport',
    name: 'Türkiye Vesikalık',
    country: 'TR',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const turkeyIdentity = DocumentPreset(
    id: 'tr_identity',
    name: 'Kimlik',
    country: 'TR',
    widthMm: 50,
    heightMm: 60,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 4,
    dpi: 300,
  );

  static const turkeyDriver = DocumentPreset(
    id: 'tr_driver',
    name: 'Ehliyet',
    country: 'TR',
    widthMm: 50,
    heightMm: 60,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 4,
    dpi: 300,
  );

  static const turkeyStudent = DocumentPreset(
    id: 'tr_student',
    name: 'Öğrenci Kartı',
    country: 'TR',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const turkeyMarriage = DocumentPreset(
    id: 'tr_marriage',
    name: 'Nikah Dairesi',
    country: 'TR',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const turkeyOfficer = DocumentPreset(
    id: 'tr_officer',
    name: 'Memur Kimliği',
    country: 'TR',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const schengenVisa = DocumentPreset(
    id: 'schengen',
    name: 'Schengen',
    country: 'EU',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const germanyVisa = DocumentPreset(
    id: 'germany',
    name: 'Germany Visa',
    country: 'DE',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const franceVisa = DocumentPreset(
    id: 'france',
    name: 'France Visa',
    country: 'FR',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const italyVisa = DocumentPreset(
    id: 'italy',
    name: 'Italy Visa',
    country: 'IT',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const usaVisa = DocumentPreset(
    id: 'usa',
    name: 'USA Visa',
    country: 'USA',
    widthMm: 51,
    heightMm: 51,
    headMinPercent: 68,
    headMaxPercent: 78,
    eyeMinPercent: 30,
    eyeMaxPercent: 40,
    paper: '10x15',
    layout: 4,
    dpi: 300,
  );

  static const canadaVisa = DocumentPreset(
    id: 'canada',
    name: 'Canada Visa',
    country: 'CA',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const mexicoVisa = DocumentPreset(
    id: 'mexico',
    name: 'Mexico Visa',
    country: 'MX',
    widthMm: 31,
    heightMm: 39,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const japanVisa = DocumentPreset(
    id: 'japan',
    name: 'Japan Visa',
    country: 'JP',
    widthMm: 45,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 30,
    eyeMaxPercent: 40,
    paper: '10x15',
    layout: 4,
    dpi: 300,
  );

  static const chinaVisa = DocumentPreset(
    id: 'china',
    name: 'China Visa',
    country: 'CN',
    widthMm: 33,
    heightMm: 48,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const koreaVisa = DocumentPreset(
    id: 'korea',
    name: 'Korea Visa',
    country: 'KR',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const singaporeVisa = DocumentPreset(
    id: 'singapore',
    name: 'Singapore Visa',
    country: 'SG',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const dubaiVisa = DocumentPreset(
    id: 'dubai',
    name: 'Dubai Visa',
    country: 'AE',
    widthMm: 43,
    heightMm: 55,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 4,
    dpi: 300,
  );

  static const saudiVisa = DocumentPreset(
    id: 'saudi',
    name: 'Saudi Visa',
    country: 'SA',
    widthMm: 40,
    heightMm: 60,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 4,
    dpi: 300,
  );

  static const qatarVisa = DocumentPreset(
    id: 'qatar',
    name: 'Qatar Visa',
    country: 'QA',
    widthMm: 38,
    heightMm: 48,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const kuwaitVisa = DocumentPreset(
    id: 'kuwait',
    name: 'Kuwait Visa',
    country: 'KW',
    widthMm: 40,
    heightMm: 50,
    headMinPercent: 70,
    headMaxPercent: 80,
    eyeMinPercent: 28,
    eyeMaxPercent: 35,
    paper: '10x15',
    layout: 6,
    dpi: 300,
  );
}