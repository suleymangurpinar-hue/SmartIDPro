import 'package:flutter/material.dart';
import '../../../shared/animations/gold_border_card.dart';

class PrintLayoutPreview extends StatelessWidget {
  const PrintLayoutPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return GoldBorderCard(
      radius: 28,
      child: Container(
        height: 320,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFF070707),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BASKI ÖNİZLEME',
              style: TextStyle(
                color: Color(0xFFD4AF37),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFF6B5215),
                    width: .8,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _sheetPreview(),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _sheetPreview(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _option("4'lü"),
                _option("6'lı"),
                _option("8'li"),
                _option("10x15"),
                _option("15x21"),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: 220,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "BASKI OLUŞTUR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sheetPreview() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAEAEA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GridView.count(
        physics:
            const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          8,
          (index) => Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius:
                  BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _option(String title) {
    return Container(
      width: 110,
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF6B5215),
          width: .7,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}