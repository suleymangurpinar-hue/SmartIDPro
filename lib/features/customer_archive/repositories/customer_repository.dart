import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../core/database/local_database.dart';
import '../models/customer.dart';

class CustomerRepository {
  CustomerRepository({LocalDatabase? database})
    : _database = database ?? LocalDatabase.instance;

  final LocalDatabase _database;

  Future<List<Customer>> all() async {
    final db = await _database.database;
    final rows = await db.query('customers', orderBy: 'updated_at DESC');

    return rows.map(Customer.fromMap).toList(growable: false);
  }

  Future<List<Customer>> search(String query) async {
    final normalized = query.trim();

    if (normalized.isEmpty) {
      return all();
    }

    final db = await _database.database;
    final like = '%$normalized%';
    final rows = await db.query(
      'customers',
      where: '''
first_name LIKE ? OR
last_name LIKE ? OR
document_number LIKE ? OR
country_code LIKE ? OR
document_type LIKE ?
''',
      whereArgs: [like, like, like, like, like],
      orderBy: 'updated_at DESC',
    );

    return rows.map(Customer.fromMap).toList(growable: false);
  }

  Future<Customer?> find(String id) async {
    final db = await _database.database;
    final rows = await db.query(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }

    return Customer.fromMap(rows.first);
  }

  Future<void> upsert(Customer customer) async {
    final db = await _database.database;
    await db.insert(
      'customers',
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String id) async {
    final db = await _database.database;
    await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> recordJob(String customerId) async {
    final customer = await find(customerId);

    if (customer == null) {
      return;
    }

    await upsert(
      customer.copyWith(
        updatedAt: DateTime.now(),
        lastJobAt: DateTime.now(),
        jobCount: customer.jobCount + 1,
      ),
    );
  }
}
