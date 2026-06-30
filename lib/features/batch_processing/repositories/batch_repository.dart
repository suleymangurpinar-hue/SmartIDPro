import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../core/database/local_database.dart';
import '../models/batch_job.dart';

class BatchRepository {
  BatchRepository({LocalDatabase? database})
    : _database = database ?? LocalDatabase.instance;

  final LocalDatabase _database;

  Future<List<BatchJob>> all() async {
    final db = await _database.database;
    final rows = await db.query('batch_jobs', orderBy: 'created_at DESC');

    return rows.map(BatchJob.fromMap).toList(growable: false);
  }

  Future<void> upsert(BatchJob job) async {
    final db = await _database.database;
    await db.insert(
      'batch_jobs',
      job.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> clearCompleted() async {
    final db = await _database.database;
    await db.delete(
      'batch_jobs',
      where: 'status IN (?, ?, ?)',
      whereArgs: [
        BatchJobStatus.passed.name,
        BatchJobStatus.failed.name,
        BatchJobStatus.exported.name,
      ],
    );
  }
}
