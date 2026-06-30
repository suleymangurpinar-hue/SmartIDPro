class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String documentNumber;
  final String countryCode;
  final String documentType;
  final String? photoPath;
  final String? email;
  final String? phone;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastJobAt;
  final int jobCount;

  const Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.documentNumber,
    required this.countryCode,
    required this.documentType,
    required this.createdAt,
    required this.updatedAt,
    this.photoPath,
    this.email,
    this.phone,
    this.notes,
    this.lastJobAt,
    this.jobCount = 0,
  });

  String get fullName => '$firstName $lastName'.trim();

  Customer copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? documentNumber,
    String? countryCode,
    String? documentType,
    String? photoPath,
    String? email,
    String? phone,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastJobAt,
    int? jobCount,
  }) {
    return Customer(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      documentNumber: documentNumber ?? this.documentNumber,
      countryCode: countryCode ?? this.countryCode,
      documentType: documentType ?? this.documentType,
      photoPath: photoPath ?? this.photoPath,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastJobAt: lastJobAt ?? this.lastJobAt,
      jobCount: jobCount ?? this.jobCount,
    );
  }

  factory Customer.fromMap(Map<String, Object?> map) {
    return Customer(
      id: map['id'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      documentNumber: map['document_number'] as String,
      countryCode: map['country_code'] as String,
      documentType: map['document_type'] as String,
      photoPath: map['photo_path'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      notes: map['notes'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      lastJobAt: map['last_job_at'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['last_job_at'] as int),
      jobCount: map['job_count'] as int? ?? 0,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'document_number': documentNumber,
      'country_code': countryCode,
      'document_type': documentType,
      'photo_path': photoPath,
      'email': email,
      'phone': phone,
      'notes': notes,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'last_job_at': lastJobAt?.millisecondsSinceEpoch,
      'job_count': jobCount,
    };
  }
}
