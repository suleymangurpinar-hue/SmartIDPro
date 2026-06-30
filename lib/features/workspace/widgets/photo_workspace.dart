import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/animations/gold_border_card.dart';
import '../../compliance/provider/compliance_provider.dart';
import '../painters/face_mesh_painter.dart';
import 'scan_overlay.dart';

class PhotoWorkspace extends StatelessWidget {
  final String? imagePath;

  const PhotoWorkspace({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    final result = context.watch<ComplianceProvider>().result;

    return GoldBorderCard(
      radius: 36,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F1115),
          borderRadius: BorderRadius.circular(36),
        ),
        child: imagePath == null
            ? _emptyState()
            : LayoutBuilder(
                builder: (context, constraints) {
                  return _photoState(
                    result,
                    constraints.maxWidth,
                    constraints.maxHeight,
                  );
                },
              ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.add_photo_alternate_outlined,
            color: Color(0xFF6AA8FF),
            size: 120,
          ),
          SizedBox(height: 24),
          Text(
            "FOTOĞRAF YÜKLE",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "RAW • JPG • PNG • HEIC",
            style: TextStyle(color: Colors.white54, letterSpacing: 2),
          ),
        ],
      ),
    );
  }

  Widget _photoState(dynamic result, double width, double height) {
    final faceLeft = width * result.faceX;

    final faceTop = height * result.faceY;

    final faceWidth = width * result.faceWidth;

    final faceHeight = height * result.faceHeight;

    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: Image.file(File(imagePath!), fit: BoxFit.contain),
          ),
        ),

        const Positioned.fill(child: ScanOverlay()),

        if (result.faceDetected)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: FaceMeshPainter()),
            ),
          ),

        if (result.faceDetected)
          Positioned(
            left: faceLeft,
            top: faceTop,
            child: Container(
              width: faceWidth,
              height: faceHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF6AA8FF), width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x336AA8FF),
                    blurRadius: 24,
                    spreadRadius: 3,
                  ),
                ],
              ),
            ),
          ),

        Positioned.fill(
          child: Center(child: Container(width: 2, color: Colors.white24)),
        ),

        Positioned(
          left: 120,
          right: 120,
          top: height * 0.36,
          child: Container(height: 2, color: const Color(0x886AA8FF)),
        ),

        Positioned(
          left: 24,
          top: 24,
          child: _badge(
            result.faceDetected ? "FACE DETECTED" : "NO FACE",
            result.faceDetected
                ? const Color(0xFF34D399)
                : const Color(0xFFFF6B6B),
          ),
        ),

        Positioned(
          right: 24,
          top: 24,
          child: _badge(
            result.icaoReady ? "ICAO READY" : "ICAO FAIL",
            result.icaoReady
                ? const Color(0xFF34D399)
                : const Color(0xFFFF6B6B),
          ),
        ),

        Positioned(
          right: 24,
          bottom: 24,
          child: _scoreCard(result.overallScore.toStringAsFixed(0)),
        ),
      ],
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xCC131A26),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _scoreCard(String score) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xCC131A26),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFF6AA8FF)),
      ),
      child: Center(
        child: Text(
          score,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
