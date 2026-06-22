import 'dart:math';
import 'package:flutter/material.dart';

class FaceMeshHud extends StatefulWidget {
  const FaceMeshHud({super.key});

  @override
  State<FaceMeshHud> createState() =>
      _FaceMeshHudState();
}

class _FaceMeshHudState
    extends State<FaceMeshHud>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
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
      builder: (_, __) {
        return CustomPaint(
          painter: _FacePainter(
            controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _FacePainter extends CustomPainter {
  final double t;

  _FacePainter(this.t);

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    _grid(canvas, size);

    _rings(canvas, center);

    _face(canvas, center);

    _hud(canvas, center);

    _labels(canvas, size);

    _scanner(canvas, center);
  }

  void _grid(
    Canvas canvas,
    Size size,
  ) {
    final p = Paint()
      ..color =
          const Color(0x111F8FFF)
      ..strokeWidth = 1;

    for (double x = 0;
        x < size.width;
        x += 40) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        p,
      );
    }

    for (double y = 0;
        y < size.height;
        y += 40) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        p,
      );
    }
  }

  void _rings(
    Canvas canvas,
    Offset c,
  ) {
    final p = Paint()
      ..style =
          PaintingStyle.stroke
      ..strokeWidth = .8
      ..color =
          const Color(
        0x221F8FFF,
      );

    for (int i = 1; i <= 5; i++) {
      canvas.drawCircle(
        c,
        i * 85,
        p,
      );
    }
  }

  void _face(
    Canvas canvas,
    Offset c,
  ) {
    final mesh = Paint()
      ..color =
          const Color(
        0x553FAEFF,
      )
      ..strokeWidth = .8;

    final node = Paint()
      ..color =
          const Color(
        0xFF57BFFF,
      );

    const headH = 520.0;
    const headW = 185.0;

    for (int row = 0; row < 54; row++) {
      final progress =
          row / 53;

      final y =
          c.dy -
              headH / 2 +
              progress * headH;

      final curve =
          sin(progress * pi) *
              headW;

      canvas.drawLine(
        Offset(
          c.dx - curve,
          y,
        ),
        Offset(
          c.dx + curve,
          y,
        ),
        mesh,
      );

      for (double x =
              c.dx - curve;
          x <
              c.dx +
                  curve;
          x += 9) {
        canvas.drawCircle(
          Offset(x, y),
          1,
          node,
        );
      }
    }

    for (int col = -18;
        col <= 18;
        col++) {
      final x =
          c.dx + col * 10.0;

      canvas.drawLine(
        Offset(
          x,
          c.dy - 260,
        ),
        Offset(
          x,
          c.dy + 260,
        ),
        mesh,
      );
    }

    final feature = Paint()
      ..color =
          const Color(
        0xAA6CCBFF,
      )
      ..style =
          PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(
          c.dx - 60,
          c.dy - 60,
        ),
        width: 42,
        height: 18,
      ),
      feature,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(
          c.dx + 60,
          c.dy - 60,
        ),
        width: 42,
        height: 18,
      ),
      feature,
    );

    canvas.drawCircle(
      Offset(
        c.dx - 60,
        c.dy - 60,
      ),
      3,
      node,
    );

    canvas.drawCircle(
      Offset(
        c.dx + 60,
        c.dy - 60,
      ),
      3,
      node,
    );

    canvas.drawLine(
      Offset(
        c.dx,
        c.dy - 25,
      ),
      Offset(
        c.dx,
        c.dy + 45,
      ),
      feature,
    );

    canvas.drawLine(
      Offset(
        c.dx,
        c.dy + 45,
      ),
      Offset(
        c.dx - 18,
        c.dy + 65,
      ),
      feature,
    );

    canvas.drawLine(
      Offset(
        c.dx,
        c.dy + 45,
      ),
      Offset(
        c.dx + 18,
        c.dy + 65,
      ),
      feature,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(
          c.dx,
          c.dy + 110,
        ),
        width: 90,
        height: 26,
      ),
      feature,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(
          c.dx,
          c.dy + 25,
        ),
        width: 240,
        height: 320,
      ),
      .55,
      2.05,
      false,
      feature,
    );

    canvas.drawLine(
      Offset(
        c.dx - 65,
        c.dy + 240,
      ),
      Offset(
        c.dx - 120,
        c.dy + 390,
      ),
      mesh,
    );

    canvas.drawLine(
      Offset(
        c.dx + 65,
        c.dy + 240,
      ),
      Offset(
        c.dx + 120,
        c.dy + 390,
      ),
      mesh,
    );

    canvas.drawLine(
      Offset(
        c.dx - 120,
        c.dy + 390,
      ),
      Offset(
        c.dx - 210,
        c.dy + 500,
      ),
      mesh,
    );

    canvas.drawLine(
      Offset(
        c.dx + 120,
        c.dy + 390,
      ),
      Offset(
        c.dx + 210,
        c.dy + 500,
      ),
      mesh,
    );
  }

  void _hud(
    Canvas canvas,
    Offset c,
  ) {
    final p = Paint()
      ..color =
          const Color(
        0xFF53B9FF,
      )
      ..strokeWidth = 2;

    final rect =
        Rect.fromCenter(
      center: c,
      width: 720,
      height: 820,
    );

    const l = 30.0;

    canvas.drawLine(
      rect.topLeft,
      rect.topLeft +
          const Offset(l, 0),
      p,
    );

    canvas.drawLine(
      rect.topLeft,
      rect.topLeft +
          const Offset(0, l),
      p,
    );

    canvas.drawLine(
      rect.topRight,
      rect.topRight +
          const Offset(-l, 0),
      p,
    );

    canvas.drawLine(
      rect.topRight,
      rect.topRight +
          const Offset(0, l),
      p,
    );

    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft +
          const Offset(l, 0),
      p,
    );

    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft +
          const Offset(0, -l),
      p,
    );

    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight +
          const Offset(-l, 0),
      p,
    );

    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight +
          const Offset(0, -l),
      p,
    );
  }

  void _labels(
    Canvas canvas,
    Size size,
  ) {
    final a = TextPainter(
      text: const TextSpan(
        text: 'SMART ID PRO',
        style: TextStyle(
          color: Color(0xFF58BFFF),
          fontSize: 12,
          letterSpacing: 3,
        ),
      ),
      textDirection:
          TextDirection.ltr,
    )..layout();

    a.paint(
      canvas,
      const Offset(
        24,
        24,
      ),
    );

    final b = TextPainter(
      text: const TextSpan(
        text:
            'BIOMETRIC ANALYSIS',
        style: TextStyle(
          color: Color(0xFF6CCBFF),
          fontSize: 10,
          letterSpacing: 4,
        ),
      ),
      textDirection:
          TextDirection.ltr,
    )..layout();

    b.paint(
      canvas,
      Offset(
        size.width / 2 - 90,
        18,
      ),
    );
  }

  void _scanner(
    Canvas canvas,
    Offset c,
  ) {
    final y =
        c.dy -
            300 +
            (600 * t);

    final rect =
        Rect.fromLTWH(
      c.dx - 260,
      y,
      520,
      4,
    );

    canvas.drawRect(
      rect,
      Paint()
        ..shader =
            const LinearGradient(
          colors: [
            Colors.transparent,
            Color(0xFF6CCBFF),
            Colors.white,
            Color(0xFF6CCBFF),
            Colors.transparent,
          ],
        ).createShader(
          rect,
        ),
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return true;
  }
}