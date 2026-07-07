import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../engine/print_engine.dart';
import '../models/photo_type.dart';
import '../models/print_layout.dart';

final class PreviewCanvas extends StatelessWidget {
  const PreviewCanvas({
    super.key,
    required this.photoType,
    required this.image,
    this.printEngine = const PrintEngine(),
  });

  final PhotoType photoType;
  final ui.Image? image;
  final PrintEngine printEngine;

  @override
  Widget build(BuildContext context) {
    final layout = printEngine.generate(photoType);

    return RepaintBoundary(
      child: AspectRatio(
        aspectRatio: AppConstants.paperAspectRatio,
        child: CustomPaint(
          painter: _PreviewPainter(layout: layout, image: image),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

final class _PreviewPainter extends CustomPainter {
  const _PreviewPainter({required this.layout, required this.image});

  final PrintLayout layout;
  final ui.Image? image;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = math.min(
      size.width / layout.paperWidthMm,
      size.height / layout.paperHeightMm,
    );
    final paperSize = Size(
      layout.paperWidthMm * scale,
      layout.paperHeightMm * scale,
    );
    final paperOffset = Offset(
      (size.width - paperSize.width) / 2,
      (size.height - paperSize.height) / 2,
    );
    final paperRect = paperOffset & paperSize;
    final paperRadius = Radius.circular(AppConstants.canvasCornerRadius);
    final paperRRect = RRect.fromRectAndRadius(paperRect, paperRadius);

    canvas.drawShadow(Path()..addRRect(paperRRect), Colors.black, 14, true);

    canvas.drawRRect(
      paperRRect,
      Paint()
        ..color = AppColors.paper
        ..isAntiAlias = true,
    );

    for (final photo in layout.photos) {
      final rect = Rect.fromLTWH(
        paperRect.left + (photo.xMm * scale),
        paperRect.top + (photo.yMm * scale),
        photo.widthMm * scale,
        photo.heightMm * scale,
      );

      final image = this.image;
      if (image != null) {
        _paintPhoto(
          canvas: canvas,
          rect: rect,
          image: image,
          rotate: photo.rotate,
        );
      }

      _paintCutLine(canvas, rect);
    }

    canvas.drawRRect(
      paperRRect,
      Paint()
        ..color = AppColors.cutLine
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7,
    );
  }

  void _paintPhoto({
    required Canvas canvas,
    required Rect rect,
    required ui.Image image,
    required bool rotate,
  }) {
    canvas.save();
    canvas.clipRect(rect);

    if (rotate) {
      canvas.translate(rect.center.dx, rect.center.dy);
      canvas.rotate(math.pi / 2);

      paintImage(
        canvas: canvas,
        rect: Rect.fromCenter(
          center: Offset.zero,
          width: rect.height,
          height: rect.width,
        ),
        image: image,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      );
    } else {
      paintImage(
        canvas: canvas,
        rect: rect,
        image: image,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      );
    }

    canvas.restore();
  }

  void _paintCutLine(Canvas canvas, Rect rect) {
    canvas.drawRect(
      rect,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.76)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.45,
    );
  }

  @override
  bool shouldRepaint(covariant _PreviewPainter oldDelegate) {
    return oldDelegate.layout != layout || oldDelegate.image != image;
  }
}
