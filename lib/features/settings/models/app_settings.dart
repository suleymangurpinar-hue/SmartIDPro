class AppSettings {
  final String languageCode;
  final String defaultCountryCode;
  final String defaultDocumentType;
  final int defaultDpi;
  final bool autoBackground;
  final bool autoRetouch;
  final bool autoClothing;
  final bool archiveCustomers;
  final String exportFolder;

  const AppSettings({
    this.languageCode = 'tr',
    this.defaultCountryCode = 'TR',
    this.defaultDocumentType = 'Biometric Passport',
    this.defaultDpi = 300,
    this.autoBackground = true,
    this.autoRetouch = true,
    this.autoClothing = false,
    this.archiveCustomers = true,
    this.exportFolder = 'Smart ID Pro Exports',
  });

  AppSettings copyWith({
    String? languageCode,
    String? defaultCountryCode,
    String? defaultDocumentType,
    int? defaultDpi,
    bool? autoBackground,
    bool? autoRetouch,
    bool? autoClothing,
    bool? archiveCustomers,
    String? exportFolder,
  }) {
    return AppSettings(
      languageCode: languageCode ?? this.languageCode,
      defaultCountryCode:
          defaultCountryCode ?? this.defaultCountryCode,
      defaultDocumentType:
          defaultDocumentType ?? this.defaultDocumentType,
      defaultDpi: defaultDpi ?? this.defaultDpi,
      autoBackground: autoBackground ?? this.autoBackground,
      autoRetouch: autoRetouch ?? this.autoRetouch,
      autoClothing: autoClothing ?? this.autoClothing,
      archiveCustomers:
          archiveCustomers ?? this.archiveCustomers,
      exportFolder: exportFolder ?? this.exportFolder,
    );
  }

  factory AppSettings.fromJson(
    Map<String, dynamic> json,
  ) {
    return AppSettings(
      languageCode:
          json['languageCode'] as String? ?? 'tr',
      defaultCountryCode:
          json['defaultCountryCode'] as String? ?? 'TR',
      defaultDocumentType:
          json['defaultDocumentType'] as String? ??
              'Biometric Passport',
      defaultDpi:
          json['defaultDpi'] as int? ?? 300,
      autoBackground:
          json['autoBackground'] as bool? ?? true,
      autoRetouch:
          json['autoRetouch'] as bool? ?? true,
      autoClothing:
          json['autoClothing'] as bool? ?? false,
      archiveCustomers:
          json['archiveCustomers'] as bool? ?? true,
      exportFolder:
          json['exportFolder'] as String? ??
              'Smart ID Pro Exports',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'languageCode': languageCode,
      'defaultCountryCode': defaultCountryCode,
      'defaultDocumentType': defaultDocumentType,
      'defaultDpi': defaultDpi,
      'autoBackground': autoBackground,
      'autoRetouch': autoRetouch,
      'autoClothing': autoClothing,
      'archiveCustomers': archiveCustomers,
      'exportFolder': exportFolder,
    };
  }
}