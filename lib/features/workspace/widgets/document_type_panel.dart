import 'package:flutter/material.dart';
import '../../../shared/animations/gold_border_card.dart';

class DocumentTypePanel extends StatelessWidget {
  const DocumentTypePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GoldBorderCard(
      radius: 24,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF090909),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "DOCUMENT TYPES",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4AF37),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _Doc("PASSPORT"),
                    _Doc("ID CARD"),
                    _Doc("USA VISA"),
                    _Doc("SCHENGEN"),
                    _Doc("UK VISA"),
                    _Doc("CANADA"),
                    _Doc("CUSTOM"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Doc extends StatelessWidget {
  final String title;

  const _Doc(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF6B5215),
          width: .6,
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
        ),
      ),
    );
  }
}