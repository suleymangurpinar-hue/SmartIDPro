import 'dart:convert';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../core/database/local_database.dart';
import '../models/app_settings.dart';

class SettingsRepository {
  SettingsRepository({LocalDatabase? database})
    : _database = database ?? LocalDatabase.instance;

  static const _settingsKey = 'app.settings';

  final LocalDatabase _database;

  Future<AppSettings> load() async {
    final db = await _database.database;
    final rows = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [_settingsKey],
      limit: 1,
    );

    if (rows.isEmpty) {
      const defaults = AppSettings();
      await save(defaults);
      return defaults;
    }

    final value = rows.first['value'] as String;
    return AppSettings.fromJson(jsonDecode(value) as Map<String, dynamic>);
  }

  Future<void> save(AppSettings settings) async {
    final db = await _database.database;
    await db.insert('settings', {
      'key': _settingsKey,
      'value': jsonEncode(settings.toJson()),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
