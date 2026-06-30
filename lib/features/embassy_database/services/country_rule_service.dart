import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/country_rule.dart';

class CountryRuleService {
  CountryRuleService({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;

  List<CountryRule>? _cache;

  Future<List<CountryRule>> loadRules() async {
    if (_cache != null) {
      return List.unmodifiable(_cache!);
    }

    final raw = await _bundle.loadString('assets/data/embassy_rules.json');

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final items = decoded['rules'] as List<dynamic>? ?? const [];

    _cache =
        items
            .map((item) => CountryRule.fromJson(item as Map<String, dynamic>))
            .toList(growable: false)
          ..sort((a, b) => a.countryName.compareTo(b.countryName));

    return List.unmodifiable(_cache!);
  }

  Future<CountryRule?> findById(String id) async {
    final rules = await loadRules();

    for (final rule in rules) {
      if (rule.id == id) {
        return rule;
      }
    }

    return null;
  }

  Future<CountryRule?> findByCountryCode(
    String countryCode, {
    String? documentType,
  }) async {
    final normalized = countryCode.trim().toUpperCase();
    final rules = await loadRules();

    for (final rule in rules) {
      final documentMatches =
          documentType == null ||
          rule.documentType.toLowerCase() == documentType.toLowerCase();

      if (rule.countryCode.toUpperCase() == normalized && documentMatches) {
        return rule;
      }
    }

    return null;
  }

  Future<List<CountryRule>> search(String query) async {
    final rules = await loadRules();
    final normalized = query.trim().toLowerCase();

    if (normalized.isEmpty) {
      return rules;
    }

    return rules
        .where((rule) {
          return rule.countryName.toLowerCase().contains(normalized) ||
              rule.countryCode.toLowerCase().contains(normalized) ||
              rule.region.toLowerCase().contains(normalized) ||
              rule.documentType.toLowerCase().contains(normalized);
        })
        .toList(growable: false);
  }

  Future<Map<String, List<CountryRule>>> groupedByRegion() async {
    final rules = await loadRules();
    final grouped = <String, List<CountryRule>>{};

    for (final rule in rules) {
      grouped.putIfAbsent(rule.region, () => <CountryRule>[]).add(rule);
    }

    return grouped;
  }
}
