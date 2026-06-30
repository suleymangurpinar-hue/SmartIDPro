import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/country_rule.dart';
import '../providers/embassy_database_provider.dart';

class EmbassyDatabaseScreen extends StatelessWidget {
  const EmbassyDatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmbassyDatabaseProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            Expanded(flex: 5, child: _CountryRuleList(provider: provider)),
            const SizedBox(width: 18),
            Expanded(flex: 4, child: _RuleInspector(rule: provider.selected)),
          ],
        );
      },
    );
  }
}

class _CountryRuleList extends StatelessWidget {
  const _CountryRuleList({required this.provider});

  final EmbassyDatabaseProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.public, color: Color(0xFFD4A64A)),
                SizedBox(width: 10),
                Text(
                  'EMBASSY DATABASE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            TextField(
              onChanged: provider.search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Country, region, document',
                filled: true,
                fillColor: Color(0xFF1F2937),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: provider.loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: provider.rules.length,
                      itemBuilder: (context, index) {
                        final rule = provider.rules[index];
                        final active = provider.selected?.id == rule.id;

                        return _RuleTile(
                          rule: rule,
                          active: active,
                          onTap: () => provider.select(rule),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RuleTile extends StatelessWidget {
  const _RuleTile({
    required this.rule,
    required this.active,
    required this.onTap,
  });

  final CountryRule rule;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF24324A) : const Color(0xFF182232),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: active ? const Color(0xFFD4A64A) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  rule.countryCode,
                  style: const TextStyle(
                    color: Color(0xFF65B9FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rule.countryName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${rule.documentType} • ${rule.sizeLabel}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
      ),
    );
  }
}

class _RuleInspector extends StatelessWidget {
  const _RuleInspector({required this.rule});

  final CountryRule? rule;

  @override
  Widget build(BuildContext context) {
    final selected = rule;

    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: selected == null
            ? const Center(
                child: Text(
                  'No rule selected',
                  style: TextStyle(color: Colors.white54),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.rule_folder_outlined,
                        color: Color(0xFF65B9FF),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          selected.countryName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _MetricGrid(rule: selected),
                  const SizedBox(height: 18),
                  _RuleLine(
                    label: 'Background',
                    value: selected.backgroundType,
                  ),
                  _RuleLine(
                    label: 'Glasses',
                    value: selected.glassesAllowed ? 'Allowed' : 'Not allowed',
                  ),
                  _RuleLine(
                    label: 'Smile',
                    value: selected.smileAllowed ? 'Allowed' : 'Neutral only',
                  ),
                  _RuleLine(
                    label: 'ICAO',
                    value: selected.icaoRequired ? 'Required' : 'Advisory',
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: ListView(
                      children: selected.notes
                          .map(
                            (note) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: Color(0xFF34D399),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      note,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.rule});

  final CountryRule rule;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.7,
      children: [
        _MetricCard(label: 'Size', value: rule.sizeLabel),
        _MetricCard(label: 'DPI', value: rule.dpi.toString()),
        _MetricCard(label: 'Head', value: rule.headRangeLabel),
        _MetricCard(label: 'Eye line', value: rule.eyeLineRangeLabel),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleLine extends StatelessWidget {
  const _RuleLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(color: Colors.white54)),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _panelDecoration() {
  return BoxDecoration(
    color: const Color(0xFF111827),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: const Color.fromRGBO(255, 255, 255, .06)),
  );
}
