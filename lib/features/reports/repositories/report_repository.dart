import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../core/database/local_database.dart';
import '../models/report_summary.dart';

class ReportRepository {
  ReportRepository({LocalDatabase? database})
    : _database = database ?? LocalDatabase.instance;

  final LocalDatabase _database;

  Future<ReportSummary> generateOperationalSummary() async {
    final db = await _database.database;
    final now = DateTime.now();

    final customerCount = _firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM customers'),
    );

    final totalJobs = _firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM batch_jobs'),
    );

    final passedJobs = _firstIntValue(
      await db.rawQuery(
        "SELECT COUNT(*) FROM batch_jobs WHERE status IN ('passed', 'exported')",
      ),
    );

    final failedJobs = _firstIntValue(
      await db.rawQuery(
        "SELECT COUNT(*) FROM batch_jobs WHERE status = 'failed'",
      ),
    );

    final summary = ReportSummary(
      id: 'report-${now.microsecondsSinceEpoch}',
      title: 'Operational Summary',
      periodLabel: '${now.year}-${_two(now.month)}-${_two(now.day)}',
      totalCustomers: customerCount,
      totalJobs: totalJobs,
      passedJobs: passedJobs,
      failedJobs: failedJobs,
      createdAt: now,
    );

    await db.insert(
      'generated_reports',
      summary.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return summary;
  }

  Future<List<ReportSummary>> history() async {
    final db = await _database.database;
    final rows = await db.query(
      'generated_reports',
      orderBy: 'created_at DESC',
      limit: 20,
    );

    return rows.map(ReportSummary.fromMap).toList(growable: false);
  }

  String _two(int value) {
    return value.toString().padLeft(2, '0');
  }

  int _firstIntValue(List<Map<String, Object?>> rows) {
    if (rows.isEmpty || rows.first.isEmpty) {
      return 0;
    }

    final value = rows.first.values.first;

    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value.toString()) ?? 0;
  }
}
