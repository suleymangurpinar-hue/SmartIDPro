import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/compliance_provider.dart';
import '../../../shared/animations/gold_border_card.dart';

class CompliancePanel extends StatelessWidget {
  final bool photoLoaded;

  const CompliancePanel({super.key, required this.photoLoaded});

  @override
  Widget build(BuildContext context) {
    return Consumer<ComplianceProvider>(
      builder: (context, provider, _) {
        final result = provider.result;

        return GoldBorderCard(
          radius: 28,
          child: Container(
            width: 380,
            decoration: BoxDecoration(
              color: const Color(0xFF080808),
              borderRadius: BorderRadius.circular(28),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "BİYOMETRİK ANALİZ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFD4AF37),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFD4AF37),
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          photoLoaded
                              ? result.overallScore.toStringAsFixed(0)
                              : "--",
                          style: const TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD4AF37),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  _scoreItem("Göz Hizası", result.eyeScore),

                  _scoreItem("Baş Oranı", result.headScore),

                  _scoreItem("Arka Plan", result.backgroundScore),

                  _scoreItem("Çözünürlük", result.resolutionScore),

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: result.icaoReady
                          ? const Color(0xFF102410)
                          : const Color(0xFF241010),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      result.icaoReady ? "ICAO UYUMLU" : "ICAO UYUMLU DEĞİL",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: result.icaoReady
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _scoreItem(String title, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(color: Colors.white)),
              ),
              Text(
                "${value.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Color(0xFFD4AF37),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: value / 100,
            minHeight: 6,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation(Color(0xFFD4AF37)),
          ),
        ],
      ),
    );
  }
}
