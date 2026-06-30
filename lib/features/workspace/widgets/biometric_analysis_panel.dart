import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../compliance/provider/compliance_provider.dart';
import '../../../shared/animations/gold_border_card.dart';

class BiometricAnalysisPanel extends StatelessWidget {
  const BiometricAnalysisPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ComplianceProvider>();

    final result = provider.result;

    final score = result.overallScore.clamp(0, 100);

    return GoldBorderCard(
      radius: 30,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF131A26),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "COMPLIANCE SCORE",
                    style: TextStyle(
                      color: Colors.white70,
                      letterSpacing: 1.5,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: provider.loading
                        ? const Color(0xFF3A2F12)
                        : const Color(0xFF1F3B2A),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    provider.loading ? "ANALYZING" : "LIVE",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              score.toStringAsFixed(0),
              style: const TextStyle(
                fontSize: 72,
                height: 1,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              result.icaoReady ? "ICAO READY" : "NEEDS FIX",
              style: TextStyle(
                color: result.icaoReady
                    ? const Color(0xFF34D399)
                    : const Color(0xFFFF6B6B),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 30),

            _MetricRow("Eye Position", result.eyeScore.round()),

            _MetricRow("Head Ratio", result.headScore.round()),

            _MetricRow("Background", result.backgroundScore.round()),

            _MetricRow("Resolution", result.resolutionScore.round()),

            const Spacer(),

            Container(
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFF1A2233),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _MiniStat(
                      "ICAO",
                      result.icaoReady ? "PASS" : "FAIL",
                    ),
                  ),
                  Expanded(
                    child: _MiniStat(
                      "FACE",
                      result.faceDetected ? "FOUND" : "NONE",
                    ),
                  ),
                  Expanded(child: _MiniStat("SCORE", score.toStringAsFixed(0))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String title;
  final int value;

  const _MetricRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    final safeValue = value.clamp(0, 100);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
              Text(
                "$safeValue%",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: LinearProgressIndicator(
              value: safeValue / 100,
              minHeight: 6,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF5EA1FF)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String title;
  final String value;

  const _MiniStat(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}
