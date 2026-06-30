import 'package:flutter/material.dart';

import '../models/report_summary.dart';
import '../repositories/report_repository.dart';

class ReportsProvider extends ChangeNotifier {
  ReportsProvider({ReportRepository? repository})
    : _repository = repository ?? ReportRepository();

  final ReportRepository _repository;

  final List<ReportSummary> _history = [];
  ReportSummary? _current;
  bool _loading = false;

  List<ReportSummary> get history => List.unmodifiable(_history);

  ReportSummary? get current => _current;

  bool get loading => _loading;

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    final result = await _repository.history();
    _history
      ..clear()
      ..addAll(result);
    _current ??= _history.isEmpty ? null : _history.first;

    _loading = false;
    notifyListeners();
  }

  Future<void> generate() async {
    _loading = true;
    notifyListeners();

    _current = await _repository.generateOperationalSummary();
    final result = await _repository.history();
    _history
      ..clear()
      ..addAll(result);

    _loading = false;
    notifyListeners();
  }

  void select(ReportSummary summary) {
    _current = summary;
    notifyListeners();
  }
}
