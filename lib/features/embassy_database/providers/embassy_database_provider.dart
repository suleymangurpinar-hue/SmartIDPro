import 'package:flutter/material.dart';

import '../models/country_rule.dart';
import '../services/country_rule_service.dart';

class EmbassyDatabaseProvider extends ChangeNotifier {
  EmbassyDatabaseProvider({CountryRuleService? service})
    : _service = service ?? CountryRuleService();

  final CountryRuleService _service;

  final List<CountryRule> _rules = [];

  bool _loading = false;
  String _query = '';
  CountryRule? _selected;

  List<CountryRule> get rules => List.unmodifiable(_rules);

  bool get loading => _loading;

  String get query => _query;

  CountryRule? get selected => _selected;

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    final result = _query.isEmpty
        ? await _service.loadRules()
        : await _service.search(_query);

    _rules
      ..clear()
      ..addAll(result);

    _selected ??= _rules.isEmpty ? null : _rules.first;

    if (_selected != null && !_rules.any((rule) => rule.id == _selected!.id)) {
      _selected = _rules.isEmpty ? null : _rules.first;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> search(String value) async {
    _query = value;
    await load();
  }

  void select(CountryRule rule) {
    _selected = rule;
    notifyListeners();
  }
}
