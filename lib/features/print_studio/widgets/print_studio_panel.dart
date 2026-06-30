import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/print_studio_provider.dart';
import 'preview_canvas.dart';

class PrintStudioPanel extends StatelessWidget {
  const PrintStudioPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PrintStudioProvider>();

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, .06)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PRINT STUDIO',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 16),

            _title('Baskı Boyutu'),

            _dropdown<String>(
              value: provider.paper,
              items: const ['10x15', '13x18', '15x21', 'A4'],
              onChanged: provider.setPaper,
            ),

            const SizedBox(height: 10),

            _title('Fotoğraf Dizilimi'),

            _dropdown<String>(
              value: provider.layout,
              items: const ['Auto', '4', '6', '8', '12', '16'],
              labels: const {
                'Auto': 'Otomatik',
                '4': '4 Lü',
                '6': '6 Lı',
                '8': '8 Li',
                '12': '12 Li',
                '16': '16 Lı',
              },
              onChanged: provider.setLayout,
            ),

            const SizedBox(height: 10),

            _title('Baskı Adedi'),

            _dropdown<int>(
              value: provider.quantity,
              items: List.generate(20, (i) => i + 1),
              onChanged: provider.setQuantity,
            ),

            const SizedBox(height: 14),

            const Text(
              'Baskı Önizlemesi',
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 230,
              child: PreviewCanvas(count: provider.photoCount),
            ),

            const SizedBox(height: 12),

            Center(
              child: Text(
                '${provider.photoCount} Adet • ${provider.paper}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: const TextStyle(color: Colors.white70)),
    );
  }

  Widget _dropdown<T>({
    required T value,
    required List<T> items,
    required Function(T) onChanged,
    Map<T, String>? labels,
  }) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        dropdownColor: const Color(0xFF1E293B),
        underline: const SizedBox.shrink(),
        style: const TextStyle(color: Colors.white),
        items: items
            .map(
              (e) => DropdownMenuItem<T>(
                value: e,
                child: Text(labels?[e] ?? e.toString()),
              ),
            )
            .toList(),
        onChanged: (v) {
          if (v != null) {
            onChanged(v);
          }
        },
      ),
    );
  }
}
