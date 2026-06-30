import 'package:flutter/material.dart';

import '../models/face_mesh_model.dart';

class LiveFaceMeshOverlay extends StatelessWidget {
  final FaceMeshModel mesh;

  const LiveFaceMeshOverlay({super.key, required this.mesh});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _FaceMeshPainter(mesh), size: Size.infinite);
  }
}

class _FaceMeshPainter extends CustomPainter {
  final FaceMeshModel mesh;

  _FaceMeshPainter(this.mesh);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0x33FFD86A)
      ..strokeWidth = 1;

    final pointPaint = Paint()..color = const Color(0xFFFFD86A);

    final points = mesh.landmarks.map((e) => e.toOffset(size)).toList();

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 1.8, pointPaint);

      if (i < points.length - 1) {
        canvas.drawLine(points[i], points[i + 1], linePaint);
      }
    }

    for (int row = 0; row < 12; row++) {
      for (int col = 0; col < 14; col++) {
        final index = row * 15 + col;

        if (index + 15 < points.length) {
          canvas.drawLine(points[index], points[index + 15], linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
