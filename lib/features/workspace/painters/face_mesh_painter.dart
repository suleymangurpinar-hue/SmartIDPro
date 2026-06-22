import 'package:flutter/material.dart';

class FaceMeshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x99D4AF37)
      ..strokeWidth = 1;

    final dotPaint = Paint()
      ..color = const Color(0xFFD4AF37);

    final points = <Offset>[
      Offset(size.width * .50, size.height * .18),

      Offset(size.width * .38, size.height * .30),
      Offset(size.width * .62, size.height * .30),

      Offset(size.width * .30, size.height * .42),
      Offset(size.width * .70, size.height * .42),

      Offset(size.width * .50, size.height * .50),

      Offset(size.width * .40, size.height * .62),
      Offset(size.width * .60, size.height * .62),

      Offset(size.width * .50, size.height * .80),
    ];

    for (final p in points) {
      canvas.drawCircle(
        p,
        4,
        dotPaint,
      );
    }

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(
        points[i],
        points[i + 1],
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}