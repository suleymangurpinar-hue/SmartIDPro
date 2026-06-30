import 'dart:convert';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../core/database/local_database.dart';
import '../models/auth_user.dart';

class AuthService {
  AuthService({LocalDatabase? database})
    : _database = database ?? LocalDatabase.instance;

  static const _sessionKey = 'auth.current_user';

  final LocalDatabase _database;

  Future<AuthUser?> currentUser() async {
    final db = await _database.database;
    final rows = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [_sessionKey],
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }

    return AuthUser.fromJson(
      jsonDecode(rows.first['value'] as String) as Map<String, dynamic>,
    );
  }

  Future<AuthUser> signIn({required String email, required String pin}) async {
    final normalized = email.trim().toLowerCase();

    if (normalized != 'operator@smartid.pro' || pin != '1234') {
      throw AuthException('Invalid operator credentials');
    }

    final user = AuthUser(
      id: 'operator-local',
      displayName: 'Studio Operator',
      email: normalized,
      role: 'Administrator',
      signedInAt: DateTime.now(),
    );

    final db = await _database.database;
    await db.insert('settings', {
      'key': _sessionKey,
      'value': jsonEncode(user.toJson()),
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    return user;
  }

  Future<void> signOut() async {
    final db = await _database.database;
    await db.delete('settings', where: 'key = ?', whereArgs: [_sessionKey]);
  }
}

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
