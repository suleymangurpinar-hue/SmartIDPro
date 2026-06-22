import 'package:flutter/material.dart';

class IcaoCropOverlay
    extends StatelessWidget {
  const IcaoCropOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter:
          _IcaoCropPainter(),
    );
  }
}

class _IcaoCropPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final frame = Rect.fromCenter(
      center: center,
      width: 430,
      height: 560,
    );

    final paint = Paint()
      ..color =
          const Color(
            0x88FFD86A,
          )
      ..strokeWidth = 2
      ..style =
          PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        frame,
        const Radius.circular(
          18,
        ),
      ),
      paint,
    );

    final guide = Paint()
      ..color =
          const Color(
            0x22FFD86A,
          )
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(
        frame.left,
        center.dy,
      ),
      Offset(
        frame.right,
        center.dy,
      ),
      guide,
    );

    canvas.drawLine(
      Offset(
        center.dx,
        frame.top,
      ),
      Offset(
        center.dx,
        frame.bottom,
      ),
      guide,
    );

    final eyeLine =
        frame.top +
            frame.height *
                .38;

    canvas.drawLine(
      Offset(
        frame.left,
        eyeLine,
      ),
      Offset(
        frame.right,
        eyeLine,
      ),
      Paint()
        ..color =
            const Color(
              0x55FFD86A,
            )
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter
        oldDelegate,
  ) {
    return true;
  }
}