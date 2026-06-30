import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/raw_adjustments.dart';
import '../providers/raw_studio_provider.dart';

class RawAdjustmentPanel extends StatelessWidget {
  const RawAdjustmentPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RawStudioProvider>();
    final adjustments = provider.adjustments;

    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'RAW CONTROLS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _slider(
                    context,
                    'Exposure',
                    adjustments.exposure,
                    -100,
                    100,
                    (value) => adjustments.copyWith(exposure: value),
                  ),
                  _slider(
                    context,
                    'Contrast',
                    adjustments.contrast,
                    -100,
                    100,
                    (value) => adjustments.copyWith(contrast: value),
                  ),
                  _slider(
                    context,
                    'Highlights',
                    adjustments.highlights,
                    -100,
                    100,
                    (value) => adjustments.copyWith(highlights: value),
                  ),
                  _slider(
                    context,
                    'Shadows',
                    adjustments.shadows,
                    -100,
                    100,
                    (value) => adjustments.copyWith(shadows: value),
                  ),
                  _slider(
                    context,
                    'Temperature',
                    adjustments.temperature,
                    -100,
                    100,
                    (value) => adjustments.copyWith(temperature: value),
                  ),
                  _slider(
                    context,
                    'Tint',
                    adjustments.tint,
                    -100,
                    100,
                    (value) => adjustments.copyWith(tint: value),
                  ),
                  _slider(
                    context,
                    'Clarity',
                    adjustments.clarity,
                    0,
                    100,
                    (value) => adjustments.copyWith(clarity: value),
                  ),
                  _slider(
                    context,
                    'Sharpening',
                    adjustments.sharpening,
                    0,
                    100,
                    (value) => adjustments.copyWith(sharpening: value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _slider(
    BuildContext context,
    String label,
    double value,
    double min,
    double max,
    RawAdjustments Function(double) build,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
              Text(
                value.round().toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: const Color(0xFFD4A64A),
            onChanged: (next) {
              context.read<RawStudioProvider>().updateAdjustments(build(next));
            },
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
