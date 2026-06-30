import 'package:flutter/material.dart';

import '../models/customer.dart';
import '../repositories/customer_repository.dart';

class CustomerArchiveProvider extends ChangeNotifier {
  CustomerArchiveProvider({CustomerRepository? repository})
    : _repository = repository ?? CustomerRepository();

  final CustomerRepository _repository;

  final List<Customer> _customers = [];

  bool _loading = false;
  String _query = '';
  Customer? _selected;

  List<Customer> get customers => List.unmodifiable(_customers);

  bool get loading => _loading;

  String get query => _query;

  Customer? get selected => _selected;

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    final result = _query.isEmpty
        ? await _repository.all()
        : await _repository.search(_query);

    _customers
      ..clear()
      ..addAll(result);

    _selected ??= _customers.isEmpty ? null : _customers.first;

    if (_selected != null &&
        !_customers.any((customer) => customer.id == _selected!.id)) {
      _selected = _customers.isEmpty ? null : _customers.first;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> search(String value) async {
    _query = value;
    await load();
  }

  void select(Customer customer) {
    _selected = customer;
    notifyListeners();
  }

  Future<void> save(Customer customer) async {
    await _repository.upsert(customer);
    _selected = customer;
    await load();
  }

  Future<void> deleteSelected() async {
    final customer = _selected;

    if (customer == null) {
      return;
    }

    await _repository.delete(customer.id);
    _selected = null;
    await load();
  }

  Future<void> createDemoCustomer() async {
    final now = DateTime.now();
    final customer = Customer(
      id: 'customer-${now.microsecondsSinceEpoch}',
      firstName: 'New',
      lastName: 'Customer',
      documentNumber: 'DOC-${now.millisecondsSinceEpoch % 100000}',
      countryCode: 'TR',
      documentType: 'Biometric Passport',
      createdAt: now,
      updatedAt: now,
      notes: 'Created from Customer Archive',
    );

    await save(customer);
  }
}
