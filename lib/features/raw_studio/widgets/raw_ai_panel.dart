import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/raw_studio_provider.dart';

class RawAiPanel extends StatelessWidget {
  const RawAiPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RawStudioProvider>();

    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI ENGINES',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            _engineButton(
              icon: Icons.face_retouching_natural,
              title: 'Retouch',
              subtitle: provider.retouchPreset,
              onPressed: provider.processing ? null : provider.queueRetouch,
            ),
            _engineButton(
              icon: Icons.checkroom_outlined,
              title: 'Clothing',
              subtitle:
                  '${provider.clothingCategory} • ${provider.clothingStyle}',
              onPressed: provider.processing ? null : provider.queueClothing,
            ),
            _BackgroundSwatches(selected: Color(provider.backgroundColor)),
            _engineButton(
              icon: Icons.wallpaper_outlined,
              title: 'Background',
              subtitle: 'Replace',
              onPressed: provider.processing ? null : provider.queueBackground,
            ),
            const Spacer(),
            if (provider.processing)
              const LinearProgressIndicator(color: Color(0xFFD4A64A)),
          ],
        ),
      ),
    );
  }

  Widget _engineButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Row(
            children: [
              Expanded(child: Text(title)),
              Flexible(
                child: Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundSwatches extends StatelessWidget {
  const _BackgroundSwatches({required this.selected});

  final Color selected;

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.white,
      Color(0xFFF3F4F6),
      Color(0xFFD1D5DB),
      Color(0xFFDBEAFE),
      Color(0xFF1E3A8A),
      Colors.black,
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: colors.map((color) {
          final active = color.toARGB32() == selected.toARGB32();

          return GestureDetector(
            onTap: () =>
                context.read<RawStudioProvider>().setBackgroundColor(color),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: active
                      ? const Color(0xFFD4A64A)
                      : const Color(0x55FFFFFF),
                  width: active ? 3 : 1,
                ),
              ),
            ),
          );
        }).toList(),
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
