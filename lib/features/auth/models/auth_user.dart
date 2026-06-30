class AuthUser {
  final String id;
  final String displayName;
  final String email;
  final String role;
  final DateTime signedInAt;

  const AuthUser({
    required this.id,
    required this.displayName,
    required this.email,
    required this.role,
    required this.signedInAt,
  });

  String get initials {
    final parts = displayName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return '?';
    }

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      signedInAt: DateTime.parse(json['signedInAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'role': role,
      'signedInAt': signedInAt.toIso8601String(),
    };
  }
}
