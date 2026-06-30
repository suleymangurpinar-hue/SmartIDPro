import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/raw_studio_provider.dart';

class RawPreviewPanel extends StatelessWidget {
  const RawPreviewPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RawStudioProvider>();
    final imagePath = provider.imagePath;

    return Container(
      decoration: _panelDecoration(),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: imagePath == null
                  ? const _EmptyPreview()
                  : Image.file(File(imagePath), fit: BoxFit.contain),
            ),
          ),
          Positioned(
            left: 18,
            top: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xCC0B1320),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'RAW STUDIO',
                style: TextStyle(
                  color: Color(0xFF65B9FF),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyPreview extends StatelessWidget {
  const _EmptyPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF07111D),
      child: const Center(
        child: Icon(
          Icons.camera_enhance_outlined,
          color: Colors.white24,
          size: 72,
        ),
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
