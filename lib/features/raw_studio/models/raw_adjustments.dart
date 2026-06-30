class RawAdjustments {
  final double exposure;
  final double contrast;
  final double highlights;
  final double shadows;
  final double temperature;
  final double tint;
  final double clarity;
  final double sharpening;

  const RawAdjustments({
    this.exposure = 0,
    this.contrast = 12,
    this.highlights = -10,
    this.shadows = 8,
    this.temperature = 0,
    this.tint = 0,
    this.clarity = 15,
    this.sharpening = 35,
  });

  RawAdjustments copyWith({
    double? exposure,
    double? contrast,
    double? highlights,
    double? shadows,
    double? temperature,
    double? tint,
    double? clarity,
    double? sharpening,
  }) {
    return RawAdjustments(
      exposure: exposure ?? this.exposure,
      contrast: contrast ?? this.contrast,
      highlights: highlights ?? this.highlights,
      shadows: shadows ?? this.shadows,
      temperature: temperature ?? this.temperature,
      tint: tint ?? this.tint,
      clarity: clarity ?? this.clarity,
      sharpening: sharpening ?? this.sharpening,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'exposure': exposure,
      'contrast': contrast,
      'highlights': highlights,
      'shadows': shadows,
      'temperature': temperature,
      'tint': tint,
      'clarity': clarity,
      'sharpening': sharpening,
    };
  }
}
