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

  // ICAO 70-80 yerine daha stabil ortalama
  static const _headMin = 72.0;
  static const _headMax = 76.0;
  static const _eyeMin = 54.0;
  static const _eyeMax = 58.0;

  static const turkeyBiometric = DocumentPreset(
    id: 'tr_biometric',
    name: 'Türkiye Biyometrik',
    country: 'TR',
    widthMm: 50,
    heightMm: 60,
    headMinPercent: _headMin,
    headMaxPercent: _headMax,
    eyeMinPercent: _eyeMin,
    eyeMaxPercent: _eyeMax,
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
    headMinPercent: _headMin,
    headMaxPercent: _headMax,
    eyeMinPercent: _eyeMin,
    eyeMaxPercent: _eyeMax,
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
    headMinPercent: _headMin,
    headMaxPercent: _headMax,
    eyeMinPercent: _eyeMin,
    eyeMaxPercent: _eyeMax,
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
    headMinPercent: _headMin,
    headMaxPercent: _headMax,
    eyeMinPercent: _eyeMin,
    eyeMaxPercent: _eyeMax,
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
    headMinPercent: _headMin,
    headMaxPercent: _headMax,
    eyeMinPercent: _eyeMin,
    eyeMaxPercent: _eyeMax,
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
    headMaxPercent: 74,
    eyeMinPercent: 54,
    eyeMaxPercent: 58,
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
    headMinPercent: _headMin,
    headMaxPercent: _headMax,
    eyeMinPercent: _eyeMin,
    eyeMaxPercent: _eyeMax,
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
    headMinPercent: 72,
    headMaxPercent: 76,
    eyeMinPercent: 54,
    eyeMaxPercent: 58,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const germanyVisa = schengenVisa;

  static const franceVisa = DocumentPreset(
    id: 'france',
    name: 'France Visa',
    country: 'FR',
    widthMm: 35,
    heightMm: 45,
    headMinPercent: 72,
    headMaxPercent: 76,
    eyeMinPercent: 54,
    eyeMaxPercent: 58,
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
    headMinPercent: 72,
    headMaxPercent: 76,
    eyeMinPercent: 54,
    eyeMaxPercent: 58,
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
    headMinPercent: 66,
    headMaxPercent: 70,
    eyeMinPercent: 52,
    eyeMaxPercent: 56,
    paper: '10x15',
    layout: 4,
    dpi: 300,
  );

  static const canadaVisa = schengenVisa;

  static const mexicoVisa = DocumentPreset(
    id: 'mexico',
    name: 'Mexico Visa',
    country: 'MX',
    widthMm: 31,
    heightMm: 39,
    headMinPercent: 72,
    headMaxPercent: 76,
    eyeMinPercent: 54,
    eyeMaxPercent: 58,
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
    headMinPercent: 68,
    headMaxPercent: 72,
    eyeMinPercent: 53,
    eyeMaxPercent: 57,
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
    headMinPercent: 72,
    headMaxPercent: 76,
    eyeMinPercent: 54,
    eyeMaxPercent: 58,
    paper: '10x15',
    layout: 8,
    dpi: 300,
  );

  static const koreaVisa = schengenVisa;
  static const singaporeVisa = schengenVisa;

  static const dubaiVisa = DocumentPreset(
    id: 'dubai',
    name: 'Dubai Visa',
    country: 'AE',
    widthMm: 43,
    heightMm: 55,
    headMinPercent: 72,
    headMaxPercent: 76,
    eyeMinPercent: 54,
    eyeMaxPercent: 58,
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
    headMaxPercent: 74,
    eyeMinPercent: 54,
    eyeMaxPercent: 58,
    paper: '10x15',
    layout: 4,
    dpi: 300,
  );

  static const qatarVisa = schengenVisa;

  static const kuwaitVisa = DocumentPreset(
    id: 'kuwait',
    name: 'Kuwait Visa',
    country: 'KW',
    widthMm: 40,
    heightMm: 50,
    headMinPercent: 72,
    headMaxPercent: 76,
    eyeMinPercent: 54,
    eyeMaxPercent: 58,
    paper: '10x15',
    layout: 6,
    dpi: 300,
  );
}
