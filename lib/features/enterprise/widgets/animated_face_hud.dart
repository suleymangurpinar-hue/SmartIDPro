import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedFaceHud extends StatefulWidget {
  const AnimatedFaceHud({super.key});

  @override
  State<AnimatedFaceHud> createState() => _AnimatedFaceHudState();
}

class _AnimatedFaceHudState extends State<AnimatedFaceHud>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _FaceHudPainter(controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _FaceHudPainter extends CustomPainter {
  final double t;

  _FaceHudPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final gold = const Color(0xFFD4A64A);

    final frame = Rect.fromCenter(center: center, width: 520, height: 650);

    final meshPaint = Paint()
      ..color = gold.withValues(alpha: .18)
      ..strokeWidth = 1;

    final brightPaint = Paint()
      ..color = gold.withValues(alpha: .65)
      ..strokeWidth = 1.2;

    final glowDot = Paint()..color = const Color(0xFFFFD86A);

    _drawHudFrame(canvas, frame, gold);

    final headW = 170.0;
    final headH = 260.0;

    for (int r = 0; r < 42; r++) {
      final p = r / 41;

      final y = center.dy - headH + (headH * 2 * p);

      final radius = sin(p * pi) * headW;

      canvas.drawLine(
        Offset(center.dx - radius, y),
        Offset(center.dx + radius, y),
        meshPaint,
      );
    }

    for (int c = -22; c <= 22; c++) {
      final p = c / 22;

      final x = center.dx + (headW * p);

      final top = center.dy - headH;

      final bottom = center.dy + headH;

      canvas.drawLine(Offset(x, top), Offset(x, bottom), meshPaint);
    }

    for (int i = 0; i < 18; i++) {
      final p = i / 17;

      final radius = headW * (1 - (p * .05));

      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: radius * 2,
          height: headH * 2 * (1 - p * .025),
        ),
        meshPaint,
      );
    }

    final landmarks = [
      Offset(0, -190),
      Offset(-55, -95),
      Offset(55, -95),
      Offset(-70, -20),
      Offset(70, -20),
      Offset(0, 15),
      Offset(-45, 95),
      Offset(45, 95),
      Offset(0, 140),
      Offset(-110, -10),
      Offset(110, -10),
      Offset(-125, 40),
      Offset(125, 40),
      Offset(-80, 180),
      Offset(80, 180),
    ];

    for (int i = 0; i < landmarks.length; i++) {
      final p = landmarks[i];

      final dx = sin((t * 6.28) + i) * 3;

      final dy = cos((t * 6.28) + i) * 3;

      final point = Offset(center.dx + p.dx + dx, center.dy + p.dy + dy);

      canvas.drawCircle(
        point,
        10,
        Paint()..color = gold.withValues(alpha: .12),
      );

      canvas.drawCircle(point, 3, glowDot);
    }

    final eyeY = center.dy - 35;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx - 48, eyeY),
        width: 52,
        height: 20,
      ),
      brightPaint,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx + 48, eyeY),
        width: 52,
        height: 20,
      ),
      brightPaint,
    );

    final scanY = frame.top + (frame.height * t);

    final scanRect = Rect.fromLTWH(frame.left, scanY, frame.width, 4);

    canvas.save();
    canvas.clipRect(frame);

    canvas.drawRect(
      scanRect,
      Paint()
        ..shader = const LinearGradient(
          colors: [
            Colors.transparent,
            Color(0x55FFD86A),
            Color(0xFFFFD86A),
            Color(0x55FFD86A),
            Colors.transparent,
          ],
        ).createShader(scanRect),
    );

    canvas.drawRect(
      Rect.fromLTWH(frame.left, scanY - 40, frame.width, 80),
      Paint()
        ..shader = const LinearGradient(
          colors: [
            Colors.transparent,
            Color(0x11FFD86A),
            Color(0x33FFD86A),
            Color(0x11FFD86A),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(frame.left, scanY - 40, frame.width, 80)),
    );

    canvas.restore();
  }

  void _drawHudFrame(Canvas canvas, Rect frame, Color color) {
    final paint = Paint()
      ..color = color.withValues(alpha: .7)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(frame, const Radius.circular(18)),
      paint,
    );

    const l = 24.0;

    canvas.drawLine(frame.topLeft, frame.topLeft + const Offset(l, 0), paint);

    canvas.drawLine(frame.topLeft, frame.topLeft + const Offset(0, l), paint);

    canvas.drawLine(
      frame.topRight,
      frame.topRight + const Offset(-l, 0),
      paint,
    );

    canvas.drawLine(frame.topRight, frame.topRight + const Offset(0, l), paint);

    canvas.drawLine(
      frame.bottomLeft,
      frame.bottomLeft + const Offset(l, 0),
      paint,
    );

    canvas.drawLine(
      frame.bottomLeft,
      frame.bottomLeft + const Offset(0, -l),
      paint,
    );

    canvas.drawLine(
      frame.bottomRight,
      frame.bottomRight + const Offset(-l, 0),
      paint,
    );

    canvas.drawLine(
      frame.bottomRight,
      frame.bottomRight + const Offset(0, -l),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
