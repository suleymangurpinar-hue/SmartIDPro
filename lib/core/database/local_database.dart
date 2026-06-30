import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocalDatabase {
  LocalDatabase._();

  static final LocalDatabase instance = LocalDatabase._();

  Database? _database;

  Future<Database> get database async {
    final existing = _database;

    if (existing != null) {
      return existing;
    }

    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final supportDir = await getApplicationSupportDirectory();
    final databaseDir = Directory(path.join(supportDir.path, 'SmartIDPro'));

    if (!await databaseDir.exists()) {
      await databaseDir.create(recursive: true);
    }

    _database = await databaseFactory.openDatabase(
      path.join(databaseDir.path, 'smart_id_pro.sqlite'),
      options: OpenDatabaseOptions(version: 1, onCreate: _create),
    );

    return _database!;
  }

  Future<void> _create(Database db, int version) async {
    await db.execute('''
CREATE TABLE customers (
  id TEXT PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  document_number TEXT NOT NULL,
  country_code TEXT NOT NULL,
  document_type TEXT NOT NULL,
  photo_path TEXT,
  email TEXT,
  phone TEXT,
  notes TEXT,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  last_job_at INTEGER,
  job_count INTEGER NOT NULL DEFAULT 0
)
''');

    await db.execute('''
CREATE TABLE batch_jobs (
  id TEXT PRIMARY KEY,
  customer_id TEXT,
  source_path TEXT NOT NULL,
  output_path TEXT,
  preset_code TEXT NOT NULL,
  status TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  error_message TEXT,
  steps_completed INTEGER NOT NULL,
  total_steps INTEGER NOT NULL
)
''');

    await db.execute('''
CREATE TABLE generated_reports (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  period_label TEXT NOT NULL,
  total_customers INTEGER NOT NULL,
  total_jobs INTEGER NOT NULL,
  passed_jobs INTEGER NOT NULL,
  failed_jobs INTEGER NOT NULL,
  created_at INTEGER NOT NULL
)
''');

    await db.execute('''
CREATE TABLE settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
)
''');
  }

  Future<void> close() async {
    final existing = _database;

    if (existing == null) {
      return;
    }

    await existing.close();
    _database = null;
  }
}
