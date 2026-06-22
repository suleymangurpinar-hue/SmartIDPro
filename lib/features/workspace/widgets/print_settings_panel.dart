import 'package:flutter/material.dart';
import '../../../shared/animations/gold_border_card.dart';

class PrintSettingsPanel extends StatelessWidget {
  const PrintSettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GoldBorderCard(
      radius: 24,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF090909),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "BASKI AYARLARI",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFD4AF37),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _PrintOption("4'lü"),
                _PrintOption("6'lı"),
                _PrintOption("8'li"),
                _PrintOption("10x15"),
                _PrintOption("15x21"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PrintOption extends StatelessWidget {
  final String title;

  const _PrintOption(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}