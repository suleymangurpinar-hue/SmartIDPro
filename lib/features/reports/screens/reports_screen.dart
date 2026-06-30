import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/report_summary.dart';
import '../providers/reports_provider.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportsProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            Expanded(
              flex: 6,
              child: _ReportDashboard(
                summary: provider.current,
                loading: provider.loading,
                onGenerate: provider.generate,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              flex: 4,
              child: _ReportHistory(
                reports: provider.history,
                selected: provider.current,
                onSelected: provider.select,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ReportDashboard extends StatelessWidget {
  const _ReportDashboard({
    required this.summary,
    required this.loading,
    required this.onGenerate,
  });

  final ReportSummary? summary;
  final bool loading;
  final Future<void> Function() onGenerate;

  @override
  Widget build(BuildContext context) {
    final report = summary;

    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.analytics_outlined, color: Color(0xFFD4A64A)),
                const SizedBox(width: 10),
                const Text(
                  'REPORTS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: loading ? null : onGenerate,
                  icon: const Icon(Icons.refresh),
                  label: const Text('GENERATE'),
                ),
              ],
            ),
            const SizedBox(height: 22),
            if (loading)
              const LinearProgressIndicator(color: Color(0xFFD4A64A))
            else if (report == null)
              const Expanded(
                child: Center(
                  child: Text(
                    'No reports generated',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              )
            else
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 2.4,
                        children: [
                          _ReportMetric(
                            label: 'Customers',
                            value: report.totalCustomers.toString(),
                            color: const Color(0xFF65B9FF),
                          ),
                          _ReportMetric(
                            label: 'Jobs',
                            value: report.totalJobs.toString(),
                            color: const Color(0xFFD4A64A),
                          ),
                          _ReportMetric(
                            label: 'Passed',
                            value: report.passedJobs.toString(),
                            color: const Color(0xFF34D399),
                          ),
                          _ReportMetric(
                            label: 'Failed',
                            value: report.failedJobs.toString(),
                            color: const Color(0xFFF87171),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: report.passRate,
                        minHeight: 14,
                        color: const Color(0xFF34D399),
                        backgroundColor: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${(report.passRate * 100).round()}% pass rate',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ReportHistory extends StatelessWidget {
  const _ReportHistory({
    required this.reports,
    required this.selected,
    required this.onSelected,
  });

  final List<ReportSummary> reports;
  final ReportSummary? selected;
  final ValueChanged<ReportSummary> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'REPORT HISTORY',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  final active = selected?.id == report.id;

                  return GestureDetector(
                    onTap: () => onSelected(report),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: active
                            ? const Color(0xFF24324A)
                            : const Color(0xFF182232),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: active
                              ? const Color(0xFFD4A64A)
                              : Colors.transparent,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            report.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            report.periodLabel,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _ReportMetric extends StatelessWidget {
  const _ReportMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF182232),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 30,
              fontWeight: FontWeight.bold,
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
