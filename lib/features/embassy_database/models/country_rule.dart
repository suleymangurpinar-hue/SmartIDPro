class CountryRule {
  final String id;

  final String countryCode;
  final String countryName;

  final String region;

  final String documentType;

  final double widthMm;
  final double heightMm;

  final double minHeadPercent;
  final double maxHeadPercent;

  final double minEyeLinePercent;
  final double maxEyeLinePercent;

  final String backgroundType;

  final bool glassesAllowed;
  final bool smileAllowed;

  final bool icaoRequired;

  final int dpi;

  final String source;

  final DateTime updatedAt;

  final List<String> notes;

  const CountryRule({
    required this.id,
    required this.countryCode,
    required this.countryName,
    required this.region,
    required this.documentType,
    required this.widthMm,
    required this.heightMm,
    required this.minHeadPercent,
    required this.maxHeadPercent,
    required this.minEyeLinePercent,
    required this.maxEyeLinePercent,
    required this.backgroundType,
    required this.glassesAllowed,
    required this.smileAllowed,
    required this.icaoRequired,
    required this.dpi,
    required this.source,
    required this.updatedAt,
    required this.notes,
  });

  factory CountryRule.fromJson(Map<String, dynamic> json) {
    final notesJson = json['notes'] as List<dynamic>? ?? const [];

    return CountryRule(
      id: json['id'] as String,
      countryCode: json['countryCode'] as String,
      countryName: json['countryName'] as String,
      region: json['region'] as String? ?? 'Global',
      documentType: json['documentType'] as String,
      widthMm: (json['widthMm'] as num).toDouble(),
      heightMm: (json['heightMm'] as num).toDouble(),
      minHeadPercent: (json['minHeadPercent'] as num).toDouble(),
      maxHeadPercent: (json['maxHeadPercent'] as num).toDouble(),
      minEyeLinePercent: (json['minEyeLinePercent'] as num).toDouble(),
      maxEyeLinePercent: (json['maxEyeLinePercent'] as num).toDouble(),
      backgroundType: json['backgroundType'] as String,
      glassesAllowed: json['glassesAllowed'] as bool,
      smileAllowed: json['smileAllowed'] as bool,
      icaoRequired: json['icaoRequired'] as bool,
      dpi: json['dpi'] as int? ?? 300,
      source: json['source'] as String? ?? 'Embassy guidance',
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      notes: notesJson.map((note) => note.toString()).toList(growable: false),
    );
  }

  String get sizeLabel => '${_trim(widthMm)} x ${_trim(heightMm)} mm';

  String get headRangeLabel =>
      '${_trim(minHeadPercent)}-${_trim(maxHeadPercent)}%';

  String get eyeLineRangeLabel =>
      '${_trim(minEyeLinePercent)}-${_trim(maxEyeLinePercent)}%';

  CountryRule copyWith({
    String? id,
    String? countryCode,
    String? countryName,
    String? region,
    String? documentType,
    double? widthMm,
    double? heightMm,
    double? minHeadPercent,
    double? maxHeadPercent,
    double? minEyeLinePercent,
    double? maxEyeLinePercent,
    String? backgroundType,
    bool? glassesAllowed,
    bool? smileAllowed,
    bool? icaoRequired,
    int? dpi,
    String? source,
    DateTime? updatedAt,
    List<String>? notes,
  }) {
    return CountryRule(
      id: id ?? this.id,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      region: region ?? this.region,
      documentType: documentType ?? this.documentType,
      widthMm: widthMm ?? this.widthMm,
      heightMm: heightMm ?? this.heightMm,
      minHeadPercent: minHeadPercent ?? this.minHeadPercent,
      maxHeadPercent: maxHeadPercent ?? this.maxHeadPercent,
      minEyeLinePercent: minEyeLinePercent ?? this.minEyeLinePercent,
      maxEyeLinePercent: maxEyeLinePercent ?? this.maxEyeLinePercent,
      backgroundType: backgroundType ?? this.backgroundType,
      glassesAllowed: glassesAllowed ?? this.glassesAllowed,
      smileAllowed: smileAllowed ?? this.smileAllowed,
      icaoRequired: icaoRequired ?? this.icaoRequired,
      dpi: dpi ?? this.dpi,
      source: source ?? this.source,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'countryCode': countryCode,
      'countryName': countryName,
      'region': region,
      'documentType': documentType,
      'widthMm': widthMm,
      'heightMm': heightMm,
      'minHeadPercent': minHeadPercent,
      'maxHeadPercent': maxHeadPercent,
      'minEyeLinePercent': minEyeLinePercent,
      'maxEyeLinePercent': maxEyeLinePercent,
      'backgroundType': backgroundType,
      'glassesAllowed': glassesAllowed,
      'smileAllowed': smileAllowed,
      'icaoRequired': icaoRequired,
      'dpi': dpi,
      'source': source,
      'updatedAt': updatedAt.toIso8601String(),
      'notes': notes,
    };
  }

  static String _trim(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(1);
  }
}
